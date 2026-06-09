<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar sesión - FoodSync</title>
    <link rel="stylesheet" href="SesionR.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;700&family=Pacifico&display=swap" rel="stylesheet">
</head>
<body>

    <%@include file="navbar.jsp" %>

    <section class="registro-section">
        <h1 class="titulo-registro">Iniciar sesión</h1>

        <div class="registro-card">
            <div class="formulario-box">
                <form id="formulario" method="post" action="validarLogin.jsp">
                    <label>Ingresa un usuario</label>
                    <div class="input-box">
                        <input type="text" id="usuario" name="usuario" placeholder="Nombre de usuario">
                    </div>

                    <label>Contraseña</label>
                    <div class="input-box">
                        <input type="password" id="password" name="password" placeholder="Por lo menos 8 caracteres">
                        <span class="ojo" onclick="mostrarPassword('password')">
                            <i class="fa-solid fa-eye"></i>
                        </span>
                    </div>

                    <button type="submit" class="btn-registrar">Iniciar sesión</button>
                    <div class="mensaje" id="mensaje"></div>
                </form>
            </div>
        </div>
    </section>

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

    <script>
        function mostrarPassword(id){
            let input = document.getElementById(id);
            if(input.type === "password"){
                input.type = "text";
            }else{
                input.type = "password";
            }
        }

        document.getElementById("formulario").addEventListener("submit", function(e){
            let usuario = document.getElementById("usuario").value;
            let password = document.getElementById("password").value;
            let mensaje = document.getElementById("mensaje");

            if(usuario === "" || password === ""){
                e.preventDefault();
                mensaje.innerHTML = "Completa todos los campos";
                mensaje.style.color = "orange";
                return;
            }

            if(password.length < 8){
                e.preventDefault();
                mensaje.innerHTML = "La contraseña debe tener mínimo 8 caracteres";
                mensaje.style.color = "red";
                return;
            }
        });
    </script>
</body>
</html>