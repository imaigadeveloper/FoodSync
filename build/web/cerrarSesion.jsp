<%
    session.invalidate(); // Destruye por completo la sesión actual
    response.sendRedirect("index.jsp");
%>