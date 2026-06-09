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
            Statement ps = null;
            ResultSet rs = null;

            if (nomCl != null && !nomCl.trim().isEmpty() &&
                correoCl != null && !correoCl.trim().isEmpty() &&
                puntCl != null && !puntCl.trim().isEmpty() &&
                passConfirm != null && !passConfirm.trim().isEmpty()) {

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost/FoodSync?autoReconnect=true&useSSL=false", "root", "n0m3l0");

                    ps = con.createStatement();
                    rs = ps.executeQuery("SELECT * FROM Clientes WHERE correo='" + correoCl + "';");

                    if (!rs.next()) {
                        out.println("<script>");
                        out.println("alert('El cliente ingresado no existe.');");
                        out.println("window.location.href='Clientes.html';");
                        out.println("</script>");
                    } else {
                        String passBD = rs.getString("password");
                        String nomBD = rs.getString("nombre");
                        int puntBD = rs.getInt("puntos");
                        String correoBD = rs.getString("correo");

                        boolean datosCorrectos = true;

                        // Verificar coincidencia de datos
                        if (!nomBD.equals(nomCl) || puntBD != Integer.parseInt(puntCl) || !correoBD.equals(correoCl)) {
                            datosCorrectos = false;
                            out.println("<script>");
                            out.println("alert('Los datos ingresados no coinciden con la base de datos.');");
                            out.println("window.location.href='Clientes.html';");
                            out.println("</script>");
                        }

                        // Verificar contraseña y eliminar si es correcta
                        if (passBD.equals(passConfirm)) {
                            ps.executeUpdate("DELETE FROM Clientes WHERE correo='" + correoCl + "';");
                            out.println("<script>");
                            out.println("alert('Contraseña correcta. Cliente eliminado exitosamente.');");
                            out.println("window.location.href='Clientes.html';");
                            out.println("</script>");
                        } else {
                            out.println("<script>");
                            out.println("alert('Contraseña incorrecta. Acción cancelada.');");
                            out.println("window.location.href='Clientes.html';");
                            out.println("</script>");
                        }
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
