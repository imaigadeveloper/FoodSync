<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset=UTF-8">
        <title>Eliminar Personal</title>
        <link rel="stylesheet" href="AdministrarPersonal.css">
        
    </head>
    <body>
        <div class="contenedor-sitio">
            <%@page import="java.sql.*,java.io.*" %>
            <%
                String clave = request.getParameter("Id_Per");
                String passConfirm = request.getParameter("pass_Confirm");
                String nomPersonal = request.getParameter("nomPer");
                String puestoPer = request.getParameter("puesPer");
                String edoPer = request.getParameter("estPer");
                String horario = request.getParameter("horarioPer");
                Connection con = null;
                Statement ps = null;
                ResultSet rs = null;
                
                if (clave != null && !clave.trim().isEmpty() && passConfirm != null && !passConfirm.trim().isEmpty() && 
                    puestoPer != null && !puestoPer.trim().isEmpty() && horario != null && !horario.trim().isEmpty() && 
                    nomPersonal != null && !nomPersonal.trim().isEmpty() && edoPer != null && !edoPer.trim().isEmpty()) {
                    try{
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://localhost/FoodSync?autoReconnect=true&useSSL=false",
                        "root","n0m3l0");
                        
                        ps = con.createStatement();
                        rs = ps.executeQuery("select * from Personal where id_personal ='"+clave+"';");
                        if (!rs.next()) {
                            out.println("<script>");
                            out.println("alert('El personal ingresado no existe');");
                            out.println("window.location.href='administrarPersonal.jsp';"); 
                            out.println("</script>");
                        }
                        else{
                            String passBD = rs.getString("password_token");
                            String nomBD = rs.getString("nombre");
                            int puestoBD = rs.getInt("id_puesto");
                            int estadoBD = rs.getInt("id_estado");
                            String horarioBD = rs.getString("horario");

                            boolean datosCorrectos = true;

                            if (!nomBD.equals(nomPersonal) || puestoBD != Integer.parseInt(puestoPer)
                                || estadoBD != Integer.parseInt(edoPer) || !horarioBD.equals(horario)) {
                                datosCorrectos = false;
                                out.println("<script>");
                                out.println("alert('Los datos ingresados no coinciden con la base de datos.');");
                                out.println("window.location.href='administrarPersonal.jsp';");
                                out.println("</script>");
                               }
                            
                            if(passBD.equals(passConfirm)){
                            
                                ps.executeUpdate("delete from Personal where id_personal ='"+clave+"';");
                                out.println("<script>");
                                out.println("alert('Contraseña correcta. Personal borrado exitosamente');");
                                out.println("window.location.href='administrarPersonal.jsp';"); // Regreso automático
                                out.println("</script>");
                            }
                            else{
                                out.println("<script>");
                                out.println("alert('Contraseña incorrecta. Acción cancelada');");
                                out.println("window.location.href='administrarPersonal.jsp';"); // Regreso automático
                                out.println("</script>");
                            }
                        }
                    }
                    catch(Exception error){
                        out.print(error.toString());
                        error.printStackTrace();
                    }
                    try { if (rs != null) rs.close(); } catch (Exception e) {}
                    try { if (ps != null) ps.close(); } catch (Exception e) {}
                    try { if (con != null) con.close(); } catch (Exception e) {}
                }
                else{
                    out.println("<script>");
                    out.println("alert('Por favor, rellena todos los campos.');");
                    out.println("window.location.href='administrarPersonal.jsp';"); 
                    out.println("</script>");
                }
            %>
            
        </div>
    </body>
</html>
