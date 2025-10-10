package com.projet.jee.servlet;

import com.projet.jee.dao.CategorieRepository;
import com.projet.jee.model.Categorie;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/categories")
public class CategorieServlet extends HttpServlet {
    private CategorieRepository categorieRepo = new CategorieRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "new":
                request.getRequestDispatcher("/JSP/secured/admin/categorie-form.jsp").forward(request, response);
                break;
            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                Categorie cat = categorieRepo.findById(id);
                request.setAttribute("categorie", cat);
                request.getRequestDispatcher("/JSP/secured/admin/categorie-form.jsp").forward(request, response);
                break;
            case "delete":
                int idDelete = Integer.parseInt(request.getParameter("id"));
                categorieRepo.delete(idDelete);
                response.sendRedirect(request.getContextPath() + "/admin/categories");
                break;
            default:
                List<Categorie> categories = categorieRepo.findAll();
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("/JSP/secured/admin/categories.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String nom = request.getParameter("nom");
        String description = request.getParameter("description");

        if (idStr == null || idStr.isEmpty()) {
            // Ajout
            Categorie c = new Categorie();
            c.setNom(nom);
            c.setDescription(description);
            categorieRepo.save(c);
        } else {
            // Modification
            int id = Integer.parseInt(idStr);
            Categorie c = categorieRepo.findById(id);
            if (c != null) {
                c.setNom(nom);
                c.setDescription(description);
                categorieRepo.update(c);
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/categories");
    }
}
