<%@ page pageEncoding="UTF-8" %>
<%
    // Recuperamos los datos de sesión
    String usuarioLogueado = (String) session.getAttribute("usuario");
    String nombreLogueado = (String) session.getAttribute("nombre");
    String rolLogueado = (String) session.getAttribute("rol"); 

    if (rolLogueado == null) {
        rolLogueado = "Invitado";
    }
%>

<style>
    /* Estilos integrados para asegurar que todo quede en su lugar */
    .navbar-top {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 30px;
        background-color: #fff;
    }

    .auth-container {
        display: flex;
        align-items: center;
        margin-left: auto;
        background-color: #f5e6ed;
        padding: 8px 20px;
        border-radius: 50px;
        gap: 10px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .auth-link {
        color: #3b0022;
        text-decoration: none;
        font-family: 'Poppins', sans-serif;
        font-weight: 700;
        font-size: 14px;
    }

    .auth-bienvenida {
        font-family: 'Poppins', sans-serif;
        font-weight: 500;
        margin-right: 15px;
        color: #3b0022;
    }
</style>

<nav class="navbar-top">
    <div class="logo-box">
        <img src="imagen/Logo.png" alt="FoodSync" class="nav-logo" style="height: 50px;">
    </div>

    <div class="auth-container">
        <% if (usuarioLogueado == null) { %>
            <a href="Sesion.jsp" class="auth-link">Iniciar sesión</a>
            <span style="color: #3b0022;">|</span>
            <a href="Registrarse.jsp" class="auth-link">Registrarse</a>
        <% } else { %>
            <span class="auth-bienvenida">Hola, <%= nombreLogueado %></span>
            <a href="cerrarSesion.jsp" class="auth-link" style="color: #cc0000;">Cerrar Sesión</a>
        <% } %>
    </div>
</nav>

<div class="menu-nav">
    <a href="index.jsp">Inicio</a> <span>|</span>
    <a href="Platillos.jsp">Platillos</a> <span>|</span>
    <a href="Reservaciones.jsp">Reservaciones</a>

    <% if (rolLogueado.equals("Mesero") || rolLogueado.equals("Supervisor")) { %>
        <span>|</span> <a href="Mesas.jsp">Mesas</a>
        <span>|</span> <a href="Pedidos.jsp">Pedidos</a>
        <span>|</span> <a href="Ventas.jsp">Ventas</a>
    <% } %>

    <% if (rolLogueado.equals("Cocinero") || rolLogueado.equals("Supervisor")) { %>
        <span>|</span> <a href="Cocina.jsp">Cocina</a>
    <% } %>

    <% if (rolLogueado.equals("Supervisor")) { %>
        <span>|</span> <a href="Personal.jsp">Personal</a>
        <span>|</span> <a href="Clientes.jsp">Clientes</a>
    <% } %>
</div>