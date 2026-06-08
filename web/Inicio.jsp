<%@page import="java.sql.*"%>
<%@page import="modelo.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>FoodSync - Mesas</title>

    <link rel="stylesheet" href="Inicioo.css">

    <!-- ICONOS -->
    <link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- FUENTES -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;700&family=Pacifico&display=swap" rel="stylesheet">

</head>

<body>

    <!-- CONTENEDOR -->
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
            <!-- pÃ¡gina actual -->
            <a href="Inicio.html">Inicio</a>

            <span>|</span>

            <a href="Platillos.jsp">Platillos</a>

            <span>|</span>

            <a href="Mesas.jsp">Mesas</a>

            <span>|</span>

            <a href="Reservaciones.jsp">Reservaciones</a>
 
            <span>|</span>

            <a href="Pedidos.jsp">Pedidos</a>

            <span>|</span>

            <a href="Personal.jsp">Personal</a>

            <span>|</span>

            <a href="Clientes.html">Clientes</a>

            <span>|</span>

            <a href="Ventas.jsp">Ventas</a>

            <span>|</span>

            <a href="Cocina.jsp">Cocina</a>

        </div>

        <!-- CONTENIDO -->
        <main class="contenido">

            <!-- PANEL -->
            <section class="panel-principal">

                <!-- BIENVENIDA -->
                <div class="bienvenida">

                    <h1>
                        ¡Bienvenido!!
                    </h1>

                    <p>
                        Aqui tienes resumen de la actividad de hoy
                    </p>

                </div>

                <!-- RESUMEN -->
                <div class="resumen-container">

                    <!-- CARD -->
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

                    <!-- BOTONES -->
                    <div class="acciones">

                        <a href="Platillos.jsp">
                            <button type="button">
                                Consultar platillos
                            </button>
                        </a>

                        <a href="Mesas.jsp">
                            <button type="button">
                                Mesa
                            </button>
                        </a>

                    </div>

                </div>

                <!-- MAPA -->
                <div class="mapa-container">

                    <h2>
                        MAPA DE MESAS
                    </h2>

                    <!-- LEYENDA -->
                    <div class="leyenda">

                        <div class="estado">
                            <span class="circulo libre"></span>
                            Libre
                        </div>

                        <div class="estado">
                            <span class="circulo ocupada"></span>
                            Ocupada
                        </div>

                        <div class="estado">
                            <span class="circulo sucia"></span>
                            Sucia
                        </div>

                        <div class="estado">
                            <span class="circulo reservada"></span>
                            Reservada
                        </div>

                    </div>

                    <!-- MESAS -->
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

            </section>

        </main>

        <!-- FOOTER -->
        <footer class="footer-morado">

            <div class="footer-box">

                <h4>SÃ­guenos</h4>

                <div class="iconos">

                    <i class="fa-brands fa-facebook-f"></i>

                    <i class="fa-brands fa-instagram"></i>

                    <i class="fa-brands fa-x-twitter"></i>

                    <i class="fa-brands fa-youtube"></i>

                </div>

            </div>

            <div class="footer-box">

                <h4>Contacto</h4>

                <p>â³ 079</p>

                <p>
                    ComunÃ­cate, estamos <br>
                    para ayudarte
                </p>

            </div>

        </footer>

    </div>

</body>
</html>