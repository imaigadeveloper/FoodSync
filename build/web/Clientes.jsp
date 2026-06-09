<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // -----------------------------------------------------------------
    // VALIDACIÓN DE SEGURIDAD 
    // -----------------------------------------------------------------
    String usuario = (String) session.getAttribute("usuario");
    String rol = (String) session.getAttribute("rol");

    // Restringimos el acceso a la administración de clientes únicamente al Supervisor
    if (usuario == null || rol == null || !rol.equals("Supervisor")) {
%>
    <script>
        alert("Acceso denegado. Se requieren permisos de Supervisor para administrar los datos de clientes.");
        window.location.href = "Sesion.jsp";
    </script>
<%
        return; // Detiene la ejecución del resto de la página
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Clientes - FoodSync</title>
    <link rel="stylesheet" href="Clientes.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;700&family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <script>
        // Función Javascript para alternar la visibilidad de la contraseña de confirmación
        function mostrarPassword(){
            let input = document.getElementById("password");
            if(input.type === "password"){
                input.type = "text";
            } else {
                input.type = "password";
            }
        }
    </script>
</head>
<body>

<div class="contenedor-sitio">

    <%-- INCLUSIÓN DEL NAVBAR DINÁMICO REUTILIZABLE --%>
    <%@include file="navbar.jsp" %>

    <main class="contenido">
        <section class="panel-principal">
            <div class="administrar-clientes">
                <h1>Administrar clientes</h1>

                <div class="panel-admin">
                    <form method="post">
                        <div class="datos-cliente">
                            <h2>Datos del Cliente</h2>

                            <div class="campo">
                                <label>Nombre:</label>
                                <input type="text" name="nomCliente">
                            </div>

                            <div class="campo">
                                <label>Email:</label>
                                <input type="email" name="emailCliente">
                            </div>
                            
                            <div class="campo">
                                <label>Puntos:</label>
                                <input type="number" name="puntosCl">
                            </div>
                        </div>

                        <div class="confirmacion">
                            <label>
                                Confirmar modificación
                                <br>
                                con clave de permiso
                            </label>

                            <div class="input-password">
                                <input type="password"
                                       id="password"
                                       name="pass_Confirm"
                                       required placeholder="Escribe tu contraseña">
                                <i class="fa-solid fa-eye" onclick="mostrarPassword()"></i>
                            </div>
                        </div>

                        <div class="crud-botones">
                            <button type="submit"
                                   value="Eliminar"
                                   formaction="eliminarCl.jsp"
                                   class="crud-btn">Eliminar</button>
                            <button type="submit"
                                   value="Actualizar"
                                   formaction="actualizarCl.jsp"
                                   class="crud-btn">Actualizar</button>
                            <button type="submit"
                                   value="Añadir"
                                   formaction="añadirCl.jsp"
                                   class="crud-btn">Añadir</button>
                        </div>
                    </form>    
                </div>
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