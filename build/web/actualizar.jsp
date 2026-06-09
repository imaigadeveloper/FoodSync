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
            String clave = request.getParameter("Id_Per");
            String nomPersonal = request.getParameter("nomPer");
            String puestoPer = request.getParameter("puesPer");
            String edoPer = request.getParameter("estPer");
            String horaPer = request.getParameter("horarioPer");
            String passConfirm = request.getParameter("pass_Confirm");

            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            if (clave != null && !clave.trim().isEmpty() && passConfirm != null && !passConfirm.trim().isEmpty()) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost/FoodSync?autoReconnect=true&useSSL=false", "root", "n0m3l0");

                    ps = con.prepareStatement("SELECT password_token FROM Personal WHERE id_personal = ?");
                    ps.setString(1, clave);
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        String storedPass = rs.getString("password_token");
                        if (storedPass.equals(passConfirm)) {
                            ps = con.prepareStatement("UPDATE Personal SET nombre=?, id_puesto=?, id_estado=?, horario=? WHERE id_personal=?");
                            ps.setString(1, nomPersonal);
                            ps.setInt(2, Integer.parseInt(puestoPer));
                            ps.setInt(3, Integer.parseInt(edoPer));
                            ps.setString(4, horaPer);
                            ps.setString(5, clave);
                            ps.executeUpdate();

                            out.println("<script>");
                            out.println("alert('Datos actualizados correctamente');");
                            out.println("window.location.href='administrarPersonal.jsp';");
                            out.println("</script>");
                        } else {
                            out.println("<script>");
                            out.println("alert('Contraseña incorrecta. No se realizaron cambios.');");
                            out.println("window.location.href='administrarPersonal.jsp';");
                            out.println("</script>");
                        }
                    } else {
                        out.println("<script>");
                        out.println("alert('El ID ingresado no existe en la base de datos.');");
                        out.println("window.location.href='administrarPersonal.jsp';");
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
                out.println("alert('Por favor, rellena el ID y la contraseña.');");
                out.println("window.location.href='administrarPersonal.jsp';");
                out.println("</script>");
            }
            %>
        </div>
    </body>
</html>
