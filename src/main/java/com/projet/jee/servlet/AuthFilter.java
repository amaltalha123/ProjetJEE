package com.projet.jee.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.projet.jee.dto.*;

@WebFilter("/secured/*") // protège tout ce qui est sous /secured
public class AuthFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);
        SessionUser su = (session != null) ? (SessionUser) session.getAttribute("sessionUser") : null;

        if (su == null) {
            // non authentifié : rediriger vers login
            response.sendRedirect("/login");
            return;
        }

        // Exemple : contrôle simple par rôle (optionnel)
        String uri = request.getRequestURI();
        if (uri.contains("/secured/manager/") && su.getRole() != com.projet.jee.model.Role.MANAGER) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès refusé");
            return;
        }

        chain.doFilter(req, res);
    }
}
