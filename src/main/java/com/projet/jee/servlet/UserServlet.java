package com.projet.jee.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.InputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Properties;
import java.util.Random;
import java.util.UUID;
import java.security.SecureRandom;

import javax.mail.*;
import javax.mail.internet.*;

import org.mindrot.jbcrypt.BCrypt;

import com.projet.jee.model.Utilisateur;
import com.projet.jee.dao.UserRepository;
import com.projet.jee.model.Abonnement;
import com.projet.jee.model.Manager;
import com.projet.jee.model.Role;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/UserServlet")
@MultipartConfig
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserRepository repo = new UserRepository();

    // Configuration SMTP (à adapter selon votre fournisseur d'email)
    private static final String SMTP_HOST = "smtp.gmail.com"; // Exemple pour Gmail
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_USERNAME = "talha.amal@etu.uae.ac.ma"; // Remplacez par votre email
    private static final String EMAIL_PASSWORD = "kgfl ycve qjum nmoi"; // Utilisez un mot de passe d'application pour Gmail

    // Limite de renvois de code pour éviter les abus
    private static final int MAX_RESEND_ATTEMPTS = 3;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String nom = request.getParameter("nom");
        String motDePasse = request.getParameter("password");
        String roleParam = request.getParameter("role");
        Role role = Role.valueOf(roleParam.toUpperCase());
        String hashedPassword = BCrypt.hashpw(motDePasse, BCrypt.gensalt());

        Part filePart = request.getPart("photo");
        byte[] photoBytes = null;
        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream inputStream = filePart.getInputStream()) {
                photoBytes = inputStream.readAllBytes();
            }
        }

        Utilisateur utilisateur;
        if (role == Role.MANAGER) { // Correction : Utilisez Role.MANAGER directement
            String telephone = request.getParameter("telephone");
            String abonnementParam = request.getParameter("abonnement");
            Abonnement abonnement = Abonnement.valueOf(abonnementParam);

            Manager manager = new Manager();
            manager.setEmail(email);
            manager.setNom(nom);
            manager.setMotDePasse(hashedPassword);
            manager.setRole(role);
            manager.setTelephone(telephone);
            manager.setAbonnement(abonnement);
            manager.setPhotoProfile(photoBytes);
            utilisateur = manager;
        } else {
            utilisateur = new Utilisateur();
            utilisateur.setEmail(email);
            utilisateur.setNom(nom);
            utilisateur.setMotDePasse(hashedPassword);
            utilisateur.setRole(role);
            utilisateur.setPhotoProfile(photoBytes);
        }

        // Générer un code de vérification de 4 chiffres
        SecureRandom random = new SecureRandom();
        int verificationCode = 1000 + random.nextInt(9000); // Entre 1000 et 9999

        // Envoyer l'email avec le code
        boolean emailSent = sendVerificationEmail(email, verificationCode);
        if (!emailSent) {
            request.setAttribute("message", "Erreur lors de l'envoi de l'email. Veuillez réessayer.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        // Stocker temporairement l'utilisateur et le code en session
        HttpSession session = request.getSession();
        session.setAttribute("pendingUser", utilisateur);
        session.setAttribute("verificationCode", verificationCode);
        session.setAttribute("resendAttempts", 0); // Initialiser le compteur de renvois
        session.setMaxInactiveInterval(300); // Expiration après 5 minutes

        // Rediriger vers la page de vérification
        request.setAttribute("message", "Un code de vérification a été envoyé à votre email.");
        request.getRequestDispatcher("/JSP/Verification.jsp").forward(request, response);
    }

    // Nouvelle méthode doGet pour renvoyer le code
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // Ne pas créer de nouvelle session
        if (session == null) {
            request.setAttribute("message", "Session expirée. Veuillez recommencer l'inscription.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        Utilisateur pendingUser = (Utilisateur) session.getAttribute("pendingUser");
        Integer verificationCode = (Integer) session.getAttribute("verificationCode");
        Integer resendAttempts = (Integer) session.getAttribute("resendAttempts");

        if (pendingUser == null || verificationCode == null) {
            request.setAttribute("message", "Aucune inscription en cours. Veuillez vous inscrire d'abord.");
            request.getRequestDispatcher("/JSP/echec.jsp").forward(request, response); 
            return;
        }

        // Vérifier le nombre de tentatives de renvoi
        if (resendAttempts == null) {
            resendAttempts = 0;
        }
        if (resendAttempts >= MAX_RESEND_ATTEMPTS) {
            session.invalidate(); // Invalider la session après trop de tentatives
            request.setAttribute("message", "Trop de tentatives de renvoi. Veuillez recommencer l'inscription.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        // Renvoyer l'email avec le même code
        boolean emailSent = sendVerificationEmail(pendingUser.getEmail(), verificationCode);
        if (!emailSent) {
            request.setAttribute("message", "Erreur lors du renvoi de l'email. Veuillez réessayer plus tard.");
            request.getRequestDispatcher("/JSP/Verification.jsp").forward(request, response);
            return;
        }

        // Incrémenter le compteur de renvois
        session.setAttribute("resendAttempts", resendAttempts + 1);

        // Rediriger vers la page de vérification avec un message de succès
        request.setAttribute("message", "Le code de vérification a été renvoyé à votre email.");
        request.getRequestDispatcher("/JSP/Verification.jsp").forward(request, response);
    }

    // Méthode pour envoyer l'email
    private boolean sendVerificationEmail(String toEmail, int code) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_USERNAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Code de vérification pour votre inscription");
            message.setText("Votre code de vérification est : " + code + "\n\nEntrez ce code pour finaliser votre inscription.");

            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}