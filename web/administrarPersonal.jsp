<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Administrar Personal - FoodSync</title>

    <link rel="stylesheet" href="AdministrarPersonal.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;700&family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <script>
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

    <%-- INCLUSIÓN DEL NAVBAR DINÁMICO UNIFICADO --%>
    <%-- Se encarga de procesar el menú de navegación y validar el estado de la sesión activa --%>
    <%@include file="navbar.jsp" %>

    <main class="contenido">

        <section class="panel-principal">

            <div class="administrar-personal">

                <h1>Administrar personal</h1>

                <div class="panel-admin">
                    <form method="post">

                        <div class="datos-personal">

                            <h2>Datos del Personal</h2>
                            
                            <div class="campo">
                                <label>Id</label>
                                <input type="text" name="Id_Per">
                            </div>

                            <div class="campo">
                                <label>Nombre:</label>
                                <input type="text" name="nomPer">
                            </div>

                            <div class="campo">
                                <label>Puesto</label>
                                <select name="puesPer">
                                    <option value="">Selecciona un Puesto</option>
                                    <option value="1">Supervisores</option>
                                    <option value="2">Mesero</option>
                                    <option value="3">Cocinero</option>
                                </select>
                            </div>
                            
                            <div class="campo">
                                <label>Estado</label>
                                <select name="estPer">
                                    <option value="">Selecciona un Estado</option>
                                    <option value="1">Trabajando</option>
                                    <option value="2">Descansando</option>
                                    <option value="3">Inactivo</option>
                                </select>
                            </div>

                            <div class="campo">
                                <label>Horario</label>
                                <input type="text" name="horarioPer">
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

                                <i class="fa-solid fa-eye"
                                   onclick="mostrarPassword()"></i>
                            </div>

                        </div>

                        <div class="crud-botones">
                            <button type="submit"
                                    value="Eliminar"
                                    formaction="eliminar.jsp"
                                    class="crud-btn">Eliminar</button>
                            <button type="submit"
                                    value="Actualizar"
                                    formaction="actualizar.jsp"
                                    class="crud-btn">Actualizar</button>
                            <button type="submit"
                                    value="Añadir"
                                    formaction="añadir.jsp"
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
            <h4>Siguenos</h4>
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