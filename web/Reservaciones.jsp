
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            <a href="Inicio.jsp">Inicio</a>
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
            <a href="Clientes.jsp">Clientes</a>
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
                <div class="Mesas">
                    <h1>
                        Mesas
                    </h1>
                </div>

              
                <!-- MAPA -->
                <div class="mapa-container">

                    <h2>
                        MAPA DE MESAS
                    </h2>
                    
                    <div class="acciones">
                        <form action="nuevaReservacion.jsp">
                             <input type="submit" value="Reservar mesa" class="botonAccion">
                        </form>
                    </div>
                    
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

                        <div class="mesa libre-mesa">1</div>
                        <div class="mesa ocupada-mesa">2</div>
                        <div class="mesa sucia-mesa">3</div>
                        <div class="mesa libre-mesa">4</div>
                        <div class="mesa libre-mesa">5</div>
                        <div class="mesa reservada-mesa">6</div>
                        <div class="mesa ocupada-mesa">7</div>
                        <div class="mesa libre-mesa">8</div>
                        <div class="mesa libre-mesa">9</div>
                        <div class="mesa sucia-mesa">10</div>
                        <div class="mesa libre-mesa">11</div>
                        <div class="mesa ocupada-rect">12</div>

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
