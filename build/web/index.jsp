<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodSync</title>
    <link rel="stylesheet" href="principal.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>

<body>
    <div class="contenedor-sitio">

        <%@include file="navbar.jsp" %>
        
        <div class="linea-morada"></div>

        <section class="banner-suizas">
            <div class="texto-suizas">
                <h1>NUEVAS <br> SUIZAS</h1>
                <div class="precio-badge">
                    <span class="txt-small">A SOLO</span>
                    <span class="precio">$128</span>
                    <span class="txt-small">PESOS</span>
                </div>
                <button class="btn-ordenar">Ordenar ahora</button>
            </div>
            <div class="suizas-tarjeta-foto">
                <img src="imagen/Suizas.png" alt="Enchiladas Suizas" class="foto-platillo">
            </div>
        </section>

        <section class="seccion-morada">
            <div class="cuadro-blanco-interno">
                <div class="texto-disfruta">
                    <h3>DISFRUTA CADA MOMENTO</h3>
                    <h2>COMIDA QUE SE VE Y SABE INCREÍBLE</h2>
                    <p>Creamos experiencias a traves de sabores unicos, ingredientes frescos y un ambiente pensado para compartir. Cada detalle esta diseñado para que disfrutes desde el primer vistazo hasta el ultimo bocado.</p>
                </div>
                <div class="contenedor-foto-circular">
                    <img src="imagen/chilee.png" alt="Platillo Gourmet" class="foto-circular">
                </div>
            </div>
        </section>

        <section class="cards-comida">
            <div class="card-food">
                <img src="imagen/tacos.png" alt="Tacos">
                <h3>Tacos Gourmet</h3>
                <p>Tortillas recien hechas con ingredientes premium.</p>
            </div>
            <div class="card-food">
                <img src="imagen/posole.jpg" alt="Hamburguesa">
                <h3>Pozole</h3>
                <p>Carne jugosa y combinaciones irresistibles.</p>
            </div>
            <div class="card-food">
                <img src="imagen/arroz.png" alt="Postres">
                <h3>Postres</h3>
                <p>Dulces momentos para terminar perfecto.</p>
            </div>
        </section>

        <footer class="footer-morado">
            <div class="footer-box">
                <h4>Horario</h4>
                <p>Lunes - Domingo</p>
                <p>8:00 AM - 11:00 PM</p>
            </div>
            <div class="footer-box">
                <h4>Ubicacion</h4>
                <p>Av. FoodSync #128</p>
                <p>Ciudad de Mexico</p>
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
            © 2026 FoodSync - Todos los derechos reservados
        </div>

    </div>
</body>
</html>