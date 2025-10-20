   package com.projet.jee.servlet;

   import jakarta.servlet.ServletException;
   import jakarta.servlet.annotation.WebServlet;
   import jakarta.servlet.http.HttpServlet;
   import jakarta.servlet.http.HttpServletRequest;
   import jakarta.servlet.http.HttpServletResponse;
   import java.io.IOException;

   /**
    * Servlet implementation class GetServicesPage
    */
   @WebServlet("/secured/GetServicesPage")
   public class GetServicesPage extends HttpServlet {
       private static final long serialVersionUID = 1L;

       // No custom constructor needed - Java provides the implicit no-argument constructor

       /**
        * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
        */
       protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
           try {
               // Forward to the services JSP page
               request.getRequestDispatcher("/JSP/secured/manager/services.jsp").forward(request, response);
           } catch (Exception e) {
               e.printStackTrace();
               response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors du chargement de la page services: " + e.getMessage());
           }
       }

     
   }
   