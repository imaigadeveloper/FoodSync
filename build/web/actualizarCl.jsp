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
                String correoCl = request.getParameter("emailCliente"); // llave única
                String nomCl = request.getParameter("nomCliente");
                String puntCl = request.getParameter("puntosCl");
                String passConfirm = request.getParameter("pass_Confirm");

                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                if (correoCl != null && !correoCl.trim().isEmpty() && passConfirm != null && !passConfirm.trim().isEmpty()) {
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://localhost/FoodSync?autoReconnect=true&useSSL=false", "root", "n0m3l0");

                        // Verificar si el cliente existe
                        ps = con.prepareStatement("SELECT password, nombre, puntos FROM Clientes WHERE correo = ?");
                        ps.setString(1, correoCl);
                        rs = ps.executeQuery();

                        if (rs.next()) {
                            String storedPass = rs.getString("password");

                            if (storedPass.equals(passConfirm)) {
                                // Actualizar solo nombre y puntos
                                ps = con.prepareStatement("UPDATE Clientes SET nombre=?, puntos=? WHERE correo=?");
                                ps.setString(1, nomCl);
                                ps.setInt(2, Integer.parseInt(puntCl));
                                ps.setString(3, correoCl);
                                ps.executeUpdate();

                                out.println("<script>");
                                out.println("alert('Datos del cliente actualizados correctamente.');");
                                out.println("window.location.href='Clientes.html';");
                                out.println("</script>");
                            } else {
                                out.println("<script>");
                                out.println("alert('Contraseña incorrecta. No se realizaron cambios.');");
                                out.println("window.location.href='Clientes.html';");
                                out.println("</script>");
                            }
                        } else {
                            out.println("<script>");
                            out.println("alert('El correo ingresado no existe en la base de datos.');");
                            out.println("window.location.href='Clientes.html';");
                            out.println("</script>");
                        }
                    } catch (Exception e) {
                        out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
                        e.printStackTrace();
                    } finally {
                        try { if (rs != null) rs.close(); } catch (Exception e) {}
                        try { if (ps != null) ps.close(); } catch (Exception e) {}
                        try { if (con != null) con.close(); } catch (Exception e) {}
                    }
                } else {
                    out.println("<script>");
                    out.println("alert('Por favor, rellena el correo y la contraseña.');");
                    out.println("window.location.href='Clientes.html';");
                    out.println("</script>");
                }
            %>

        </div>
    </body>
</html>
