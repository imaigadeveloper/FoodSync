<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset=UTF-8">
        <title>Añadir Personal</title>
        <link rel="stylesheet" href="AdministrarPersonal.css">
        
    </head>
    <body>
        <div class="contenedor-sitio">
            <%@page import="java.sql.*,java.io.*" %>
            <%
                String passConfirm = request.getParameter("pass_Confirm");
                String clave = request.getParameter("Id_Per");
                String nomPersonal = request.getParameter("nomPer");
                String puestoPer = request.getParameter("puesPer");
                String edoPer = request.getParameter("estPer");
                String horaPer = request.getParameter("horarioPer");
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                
                if (clave != null && !clave.trim().isEmpty() && passConfirm != null && !passConfirm.trim().isEmpty() && 
                    puestoPer != null && !puestoPer.trim().isEmpty() && horaPer != null && !horaPer.trim().isEmpty()
                    && nomPersonal != null && !nomPersonal.trim().isEmpty() && edoPer != null && !edoPer.trim().isEmpty()) {
                    try{
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://localhost/FoodSync?autoReconnect=true&useSSL=false",
                        "root","n0m3l0");
                        
                        Statement st = con.createStatement();
                        rs = st.executeQuery("select * from Personal where id_personal ='"+clave+"';");
                        if (rs.next()) {
                            out.println("<script>");
                            out.println("alert('Error: Ya existe un personal registrado con ese ID.');");
                            out.println("window.location.href='administrarPersonal.jsp';"); 
                            out.println("</script>");
                        }
                        else{
                            String query = "insert into Personal (id_personal, nombre, id_puesto, id_estado, horario, password_token) values (?,?,?,?,?,?)";
                            ps=con.prepareStatement(query);
                            
                            ps.setString(1, clave);
                            ps.setString(2, nomPersonal);
                            ps.setInt(3, Integer.parseInt(puestoPer));
                            ps.setInt(4, Integer.parseInt(edoPer));
                            ps.setString(5, horaPer);
                            ps.setString(6, passConfirm);

                            ps.executeUpdate();
                            
                            out.println("<script>");
                            out.println("alert('Personal añadido exitosamente');");
                            out.println("window.location.href='administrarPersonal.jsp';"); // Regreso automático
                            out.println("</script>");
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
