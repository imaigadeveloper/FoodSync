<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%-- IMPORTAMOS CLASE CONEXION --%>
<%@ page import="modelo.Conexion" %>

<%
    // -----------------------------------------------------------------
    // VALIDACIÓN DE SEGURIDAD 
    // -----------------------------------------------------------------
    String usuario = (String) session.getAttribute("usuario");
    String rol = (String) session.getAttribute("rol");

    // Restringimos el acceso a los datos del personal únicamente al rol de Supervisor
    if (usuario == null || rol == null || !rol.equals("Supervisor")) {
%>
    <script>
        alert("Acceso denegado. Se requieren permisos de Supervisor para gestionar el personal.");
        window.location.href = "Sesion.jsp";
    </script>
<%
        return; // Detiene por completo la carga del resto de la página
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Personal - FoodSync</title>
    <link rel="stylesheet" href="Personal.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght=300;400;500;700&family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>

<div class="contenedor-sitio">

    <%-- INCLUSIÓN DEL NAVBAR DINÁMICO --%>
    <%@include file="navbar.jsp" %>

    <main class="contenido">
        <section class="panel-principal">
            <div class="titulo-personal">
                <h1>Personal</h1>
            </div>

            <div class="tabla-personal">
            <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    // INSTANCIAMOS Y USAMOS TU CLASE CONEXIÓN GLOBAL
                    Conexion conClase = new Conexion();
                    con = conClase.conectar();

                    // Consulta para obtener todo el personal con su puesto y estado
                    String sql = "SELECT nombre, id_puesto, id_estado, horario FROM Personal ORDER BY id_puesto";
                    ps = con.prepareStatement(sql);
                    rs = ps.executeQuery();

                    int puestoActual = -1;
                    boolean hayPersonal = false;

                    while (rs.next()) {
                        hayPersonal = true;
                        String nombre = rs.getString("nombre");
                        int puesto = rs.getInt("id_puesto");
                        int estado = rs.getInt("id_estado");
                        String horario = rs.getString("horario");

                        // Mostrar categoría visual estructurada cuando cambie el puesto
                        if (puesto != puestoActual) {
                            if (puesto == 1) {
                                out.println("<div class='categoria'>Cocineros</div>");
                            } else if (puesto == 2) {
                                out.println("<div class='categoria'>Meseros</div>");
                            } else if (puesto == 3) {
                                out.println("<div class='categoria'>Supervisores</div>");
                            }
                            puestoActual = puesto;
                        }
            %>
                        <%-- Usamos etiquetas HTML nativas en lugar de puros out.println para mejorar rendimiento y lectura --%>
                        <div class="fila-personal">
                            <span><%= nombre %></span>
                            <span class="<%= (estado == 1) ? "estado-trabajando" : "estado-descansando" %>">
                                <%= (estado == 1 ? "trabajando" : "descansando") %>
                            </span>
                            <span><%= (horario != null) ? horario : "Sin horario asignado" %></span>
                        </div>
            <%
                    }

                    if (!hayPersonal) {
            %>
                        <p style="text-align:center; color:gray; padding:20px; font-style: italic;">No se ha encontrado personal registrado en el sistema.</p>
            <%
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p style='color:red;'>Error al cargar la lista de personal: " + e.getMessage() + "</p>");
                } finally {
                    // Cierre seguro y explícito en orden inverso
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (con != null) con.close();
                }
            %>
            </div>

            <div class="contenedor-boton">
                <form action="administrarPersonal.jsp">
                    <input type="submit" value="Administrar personal" class="btn-personal">
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
</body>
</html>