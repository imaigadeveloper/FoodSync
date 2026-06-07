<%@page import="java.sql.*"%>
<%@page import="modelo.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
    <meta charset="UTF-8">
    <title>Mesas</title>
    <link rel="stylesheet" href="Mesass.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;700&family=Pacifico&display=swap" rel="stylesheet">
    <!-- ICONOS -->
    <link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    </head>
    <body>
        <div class="contenedor-sitio">

        <!-- NAVBAR SUPERIOR -->
        <nav class="navbar-top">
            <div class="logo-box">
                <img src="imagen/Logo.png"
                     alt="FoodSync"
                     class="nav-logo">
            </div>
        </nav>

        <!-- MENU -->
        <div class="menu-nav">
            <!-- página actual -->
            <a href="Inicio.html">Inicio</a>
            <span>|</span>
            <a href="Platillos.jsp">Platillos</a>
            <span>|</span>
            <a href="Mesas.jsp">Mesas</a>
            <span>|</span>
            <a href="Reservaciones.html">Reservaciones</a>
            <span>|</span>
            <a href="Pedidos.html">Pedidos</a>
            <span>|</span>
            <a href="Personal.html">Personal</a>
            <span>|</span>
            <a href="Clientes.html">Clientes</a>
            <span>|</span>
            <a href="Ventas.html">Ventas</a>
            <span>|</span>
            <a href="Cocina.html">Cocina</a>
        </div>

        <!-- CONTENIDO -->
<main class="contenido">

            <section class="panel-principal">

                <div class="columna-izquierda">
                    <div class="Mesas">
                        <h1>Mesas</h1>
                    </div>
                    
                    <div class="card-ocupadas">
                        <div class="icono-mesa">
                            <i class="fa-solid fa-chair"></i>
                        </div>

                        <div class="info-mesas">
                            <h3>Mesas ocupadas</h3>
                            <div class="numero">
                                <%
                                Conexion conexion2 = new Conexion();
                                Connection con2 = conexion2.conectar();

                                PreparedStatement totalPS = con2.prepareStatement("SELECT COUNT(*) FROM Mesas");
                                ResultSet totalRS = totalPS.executeQuery();
                                int totalMesas = 0;
                                if(totalRS.next()){ totalMesas = totalRS.getShort(1); }

                                PreparedStatement ocupadasPS = con2.prepareStatement("SELECT COUNT(*) FROM Mesas WHERE estado='Ocupada'");
                                ResultSet ocupadasRS = ocupadasPS.executeQuery();
                                int ocupadas = 0;
                                if(ocupadasRS.next()){ ocupadas = ocupadasRS.getInt(1); }

                                double porcentaje = 0;
                                if(totalMesas > 0){ porcentaje = (ocupadas * 100.0) / totalMesas; }

                                ocupadasRS.close();
                                ocupadasPS.close();
                                totalRS.close();
                                totalPS.close();
                                con2.close();
                                %>
                                <span class="ocupadas"><%=ocupadas%></span>
                                <span class="total">/<%=totalMesas%></span>
                                <p><%=String.format("%.0f", porcentaje)%>% ocupado</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="columna-derecha">
                    <div class="mapa-container">

                        <div class="mapa-header">
                            <h2>MAPA DE MESAS</h2>
                            <div class="acciones">
                                <form action="configurarMesas.jsp">
                                    <input type="submit" value="Configurar mesa" class="botonAccion">
                                </form>
                            </div>
                        </div>
                        
                        <div class="leyenda">
                            <div class="estado"><span class="circulo libre"></span> Libre</div>
                            <div class="estado"><span class="circulo ocupada"></span> Ocupada</div>
                            <div class="estado"><span class="circulo sucia"></span> Sucia</div>
                            <div class="estado"><span class="circulo reservada"></span> Reservada</div>
                        </div>
                        
                        <div class="mapa-mesas">
                        <%
                        Conexion conexion = new Conexion();
                        Connection con = conexion.conectar();
                        PreparedStatement ps = con.prepareStatement("SELECT * FROM Mesas ORDER BY id_mesa");
                        ResultSet rs = ps.executeQuery();

                        while(rs.next()){
                            int mesa = rs.getInt("id_mesa");
                            String estadoMesa = rs.getString("estado");
                            String clase = "";

                            if(estadoMesa.equals("Libre")) { clase = "libre-mesa"; }
                            else if(estadoMesa.equals("Ocupada")) { clase = "ocupada-mesa"; }
                            else if(estadoMesa.equals("Sucia")) { clase = "sucia-mesa"; }
                            else if(estadoMesa.equals("Reservada")) { clase = "reservada-mesa"; }
                        %>
                            <div class="mesa <%=clase%>"><%=mesa%></div>
                        <%
                        }
                        rs.close();
                        ps.close();
                        con.close();
                        %>
                        </div>

                    </div>
                </div>

            </section>
        </main>

        <!-- FOOTER -->
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

        <!-- COPYRIGHT -->
        <div class="copy">
            © 2026 FoodSync — Todos los derechos reservados
        </div>

    </div>
    </body>
</html>