<%@page import="java.sql.*"%>
<%@page import="modelo.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Reservaciones - FoodSync</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="Mesass.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;700&family=Pacifico&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        
        <script>
            function verificarSesion(event) {
                // CORRECCIÓN: Volvemos a consultar directamente el atributo nativo de la sesión 
                // para que no cause errores si el Navbar se procesa después.
                var usuario = "<%= (session.getAttribute("usuario") != null) ? session.getAttribute("usuario") : "" %>";
                
                if (usuario === "") {
                    event.preventDefault(); // Detiene el envío del formulario hacia nuevaReservacion.jsp
                    alert("Debes iniciar sesión para poder reservar una mesa.");
                    window.location.href = "Sesion.jsp";
                }
            }
        </script>
    </head>
    <body>
        <div class="contenedor-sitio">
            
            <%-- Inclusión del navbar dinámico --%>
            <%@include file="navbar.jsp" %>

            <main class="contenido">
                <section class="panel-principal">
                    <div class="Mesas">
                        <h1>Mesas</h1>
                    </div>

                    <div class="mapa-container">
                        <h2>MAPA DE MESAS</h2>
                        <div class="acciones">
                            <%-- Al dar clic en el botón, el script de JS valida si de verdad hay sesión activa --%>
                            <form action="nuevaReservacion.jsp" onsubmit="verificarSesion(event)">
                                 <input type="submit" value="Reservar mesa" class="botonAccion">
                            </form>
                        </div>
                        
                        <div class="mapa-mesas">
                            <%
                            Connection con = null;
                            PreparedStatement ps = null;
                            ResultSet rs = null;
                            try {
                                Conexion conexion = new Conexion();
                                con = conexion.conectar();
                                ps = con.prepareStatement("SELECT * FROM Mesas ORDER BY id_mesa");
                                rs = ps.executeQuery();
                                while(rs.next()){
                                    String estadoMesa = rs.getString("estado");
                                    String clase = (estadoMesa.equals("Libre")) ? "libre-mesa" : 
                                                   (estadoMesa.equals("Ocupada")) ? "ocupada-mesa" : 
                                                   (estadoMesa.equals("Sucia")) ? "sucia-mesa" : "reservada-mesa";
                            %>
                                <div class="mesa <%=clase%>"><%=rs.getInt("id_mesa")%></div>
                            <%
                                }
                            } catch(Exception e) {
                                out.println("Error al cargar mesas: " + e.getMessage());
                            } finally {
                                if(rs!=null) rs.close();
                                if(ps!=null) ps.close();
                                if(con!=null) con.close();
                            }
                            %>
                        </div>
                    </div>
                </section>
            </main>
        </div>
    </body>
</html>