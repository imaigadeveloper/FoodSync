<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="contenedor-sitio">
            <%@ page import="java.sql.*,java.io.*" %>
            <%
            String nomCl = request.getParameter("nomCliente");
            String correoCl = request.getParameter("emailCliente");
            String puntCl = request.getParameter("puntosCl");
            String passConfirm = request.getParameter("pass_Confirm");

            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            if (nomCl != null && !nomCl.trim().isEmpty() &&
                correoCl != null && !correoCl.trim().isEmpty() &&
                puntCl != null && !puntCl.trim().isEmpty() &&
                passConfirm != null && !passConfirm.trim().isEmpty()) {

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost/FoodSync?autoReconnect=true&useSSL=false", "root", "n0m3l0");

                    // Verificar si el correo ya existe
                    ps = con.prepareStatement("SELECT correo FROM Clientes WHERE correo = ?");
                    ps.setString(1, correoCl);
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        out.println("<script>");
                        out.println("alert('El correo ingresado ya está registrado.');");
                        out.println("window.location.href='Clientes.html';");
                        out.println("</script>");
                    } else {
                        // Insertar nuevo cliente
                        ps = con.prepareStatement("INSERT INTO Clientes (nombre, correo, usuario, password, fecha_nacimiento, puntos) VALUES (?, ?, ?, ?, CURDATE(), ?)");
                        ps.setString(1, nomCl);
                        ps.setString(2, correoCl);
                        ps.setString(3, nomCl.toLowerCase().replace(" ", "_")); // genera usuario automático
                        ps.setString(4, passConfirm);
                        ps.setInt(5, Integer.parseInt(puntCl));
                        ps.executeUpdate();

                        out.println("<script>");
                        out.println("alert('Cliente añadido exitosamente.');");
                        out.println("window.location.href='Clientes.html';");
                        out.println("</script>");
                    }
                } catch (Exception error) {
                    out.print(error.toString());
                    error.printStackTrace();
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception e) {}
                    try { if (ps != null) ps.close(); } catch (Exception e) {}
                    try { if (con != null) con.close(); } catch (Exception e) {}
                }
            } else {
                out.println("<script>");
                out.println("alert('Por favor, rellena todos los campos.');");
                out.println("window.location.href='Clientes.html';");
                out.println("</script>");
            }
            %>

        </div>
    </body>
</html>
