<%@page import="java.sql.*"%>
<%@page import="modelo.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Reservaciones - FoodSync</title>
        <link rel="stylesheet" href="Mesass.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght=300;400;500;700&family=Pacifico&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">  
        <style>
            .mesa.seleccionada {
                border: 3px solid #6f42c1; /* Color morado acorde a tu footer */
                transform: scale(1.08);
                box-shadow: 0 0 15px rgba(111, 66, 193, 0.5);
            }
        </style>
    </head>
    <body>
        <div class="contenedor-sitio">

            <%-- INCLUSIÓN DEL NAVBAR DINÁMICO UNIFICADO --%>
            <%-- Nota: navbar.jsp ya declara e inicializa la variable "usuarioLogueado" --%>
            <%@include file="navbar.jsp" %>

            <main class="contenido">
                <section class="panel-principal">
                    <div class="Mesas">
                        <h1>Nueva reservación</h1>
                    </div>
                    
                    <div class="mapa-container">
                        <h2>RESERVAR</h2>

                        <form action="procesarReservacion.jsp" method="POST" id="formReservacion" class="contenedor-mesas-formulario">

                            <div class="zona-mesas">
                                <div class="leyenda">
                                    <div class="estado"><span class="circulo libre"></span> Libre</div>
                                    <div class="estado"><span class="circulo ocupada"></span> Ocupada</div>
                                    <div class="estado"><span class="circulo sucia"></span> Sucia</div>
                                    <div class="estado"><span class="circulo reservada"></span> Reservada</div>
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
                                        int idMesa = rs.getInt("id_mesa");
                                        String estado = rs.getString("estado");
                                        String clase = "";

                                        // Mapeo exacto de tus ENUM de la BD
                                        if(estado.equals("Libre")) clase = "libre-mesa";
                                        else if(estado.equals("Ocupada")) clase = "ocupada-mesa";
                                        else if(estado.equals("Sucia")) clase = "sucia-mesa";
                                        else if(estado.equals("Reservada")) clase = "reservada-mesa";
                                        
                                        if(estado.equals("Libre")){
                                %>
                                            <div class="mesa <%=clase%>" data-id="<%=idMesa%>" onclick="seleccionarMesa(this)" style="cursor:pointer;">
                                                <%=idMesa%>
                                            </div>
                                <%
                                        } else {
                                %>
                                            <div class="mesa <%=clase%>" style="cursor:not-allowed; opacity: 0.5;" title="Estado: <%=estado%>">
                                                <%=idMesa%>
                                            </div>
                                <%
                                        }
                                    }
                                } catch(Exception e) {
                                    out.print("<p style='color:red;'>Error de BD: " + e.getMessage() + "</p>");
                                } finally {
                                    if(rs != null) rs.close();
                                    if(ps != null) ps.close();
                                    if(con != null) con.close();
                                }
                                %>
                                </div>
                            </div>

                            <div class="inputs-abajo">
                                <input type="hidden" name="id_mesa" id="id_mesa" value="">

                                <label>Mesa Seleccionada</label>
                                <input type="text" id="mesa_visible" readonly placeholder="Haz clic en una mesa" style="background-color: #f0f0f0; font-weight: bold; text-align: center;">

                                <label>Fecha de Reserva</label>
                                <input type="date" name="fecha_reserva" id="fecha_reserva" required>

                                <label>Hora de Reserva</label>
                                <input type="time" name="hora_reserva" required>

                                <%-- 
                                    Como navbar.jsp ya se cargó arriba, la variable 'usuarioLogueado' 
                                    ya existe y la podemos usar directamente aquí sin volver a declararla.
                                --%>
                                <% if (usuarioLogueado != null && !usuarioLogueado.isEmpty()) { %>
                                    <input type="hidden" name="usuario_cliente" value="<%= usuarioLogueado %>">
                                    <p style="margin-top: 15px; color: #555; font-size: 0.95rem;">
                                        Reservando como cuenta activa: <strong style="color: #6f42c1;"><%= usuarioLogueado %></strong>
                                    </p>
                                <% } else { %>
                                    <label>Usuario del Cliente (Registrado)</label>
                                    <input type="text" name="usuario_cliente" required placeholder="Ej: juan99">
                                <% } %>

                                <input type="submit" value="Confirmar Reservación" class="confirmar">
                            </div>

                        </form>
                    </div>
                </section>
             </main>

            <footer class="pie-morado">
                <div class="footer-box">
                    <h4>Horario</h4>
                    <p>Lunes - Domingo</p>
                    <p>8:00 AM - 11:00 PM</p>
                </div>
                <div class="footer-box">
                    <h4>Ubicación</h4>
                    <p>Av. FoodSync #128</p>
                    <p>Ciudad de México</p>
                </div>
                <div class="footer-box">
                    <h4>Síguenos</h4>
                    <div class="iconos">
                        <i class="fa-brands fa-facebook-f"></i>
                        <i class="fa-brands fa-instagram"></i>
                        <i class="fa-brands fa-x-twitter"></i>
                        <i class="fa-brands fa-youtube"></i>
                    </div>
                </div>
            </footer>

            <div class="copy">
                © 2026 FoodSync — Todos los derechos reservados
            </div>
        </div>

<script>
    window.addEventListener('DOMContentLoaded', (event) => {
        var fechaInput = document.getElementById('fecha_reserva');
        var hoy = new Date();
        
        var offset = hoy.getTimezoneOffset() * 60000;
        var fechaLocal = new Date(hoy.getTime() - offset).toISOString().split('T')[0];
        
        if (fechaInput) {
            fechaInput.value = fechaLocal;
            fechaInput.min = fechaLocal;
            fechaInput.max = fechaLocal;
        }
    });

    function seleccionarMesa(elemento) {
        document.querySelectorAll('.mesa').forEach(m => m.classList.remove('seleccionada'));
        elemento.classList.add('seleccionada');
        
        var idMesa = elemento.getAttribute('data-id');
        document.getElementById('id_mesa').value = idMesa;
        document.getElementById('mesa_visible').value = "Mesa N° " + idMesa;
    }

    document.getElementById('formReservacion').onsubmit = function(e) {
        var mesa = document.getElementById('id_mesa').value;
        if(!mesa) {
            alert('¡Selecciona una mesa del mapa primero!');
            e.preventDefault();
        }
    };
</script>
    </body>
</html>