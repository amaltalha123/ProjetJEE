package com.projet.jee.servlet;

import com.projet.jee.model.Categorie;
import com.projet.jee.dao.CategorieRepository;
import com.google.gson.Gson;  

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/api/categories")
public class CategoryListServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private CategorieRepository categorieRepo = new CategorieRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Récupérer la liste depuis la base
        List<Categorie> categories = categorieRepo.findAll();

        // 2. Convertir en JSON
        Gson gson = new Gson();
        String json = gson.toJson(categories);

        // 3. Retourner le JSON dans la réponse
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
}
