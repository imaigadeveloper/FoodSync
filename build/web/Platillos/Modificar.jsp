<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodSync - Modificar Platillo</title>

    <link rel="stylesheet" href="Platilloss.css"/>

    <link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;700&family=Pacifico&display=swap" rel="stylesheet">
</head>

<body>

<div class="contenedor-sitio">

    <!-- NAVBAR -->
    <nav class="navbar-top">
        <div class="logo-box">
            <img src="../Logo.png" class="nav-logo">
        </div>
    </nav>

    <!-- MENU -->
    <div class="menu-nav">
        <a href="../Inicio.html">Inicio</a>
        <span>|</span>
        <a href="../Platillos.jsp">Platillos</a>
        <span>|</span>
        <a href="../Mesas.jsp">Mesas</a>
        <span>|</span>
        <a href="../Reservaciones.html">Reservaciones</a>
        <span>|</span>
        <a href="../Pedidos.html">Pedidos</a>
        <span>|</span>
        <a href="../Personal.html">Personal</a>
        <span>|</span>
        <a href="../Clientes.html">Clientes</a>
        <span>|</span>
        <a href="../Ventas.html">Ventas</a>
        <span>|</span>
        <a href="../Cocina.html">Cocina</a>
    </div>

    <!-- CONTENIDO -->
    <main class="contenido">

        <section class="panel-principal">

            <h1 class="titulo-menu">Modificar platillo</h1>

            <div class="barra-acciones">
                <a href="../Platillos.jsp">Consultar</a>
                <span>|</span>
                <a href="Agregar.jsp">Agregar</a>
                <span>|</span>
                <a href="Eliminar.jsp">Eliminar</a>
                <span>|</span>
                <a href="Modificar.jsp" class="activo">Modificar</a>
            </div>

            <!-- FORMULARIO -->
            <div class="contenido-platillos">

                <form method="post">

                    <div class="seccion-eliminar">

                        <label>ID del platillo</label>
                        <input type="number" name="id_platillo" class="input-form" required>

                        <label>Nombre</label>
                        <input type="text" name="nombre" class="input-form">

                        <label>Categoría</label>
                        <input type="text" name="categoria" class="input-form">

                        <label>Precio</label>
                        <input type="number" step="0.01" name="precio" class="input-form">

                        <label>Descripción</label>
                        <input type="text" name="descripcion" class="descripcion">

                        <label>Imagen</label>
                        <input type="text" name="ruta_imagen" class="input-form">

                    </div>

                    <div class="confirmacion">

                        <label>Confirmar modificación</label>

                        <div class="input-password">
                            <input type="password" name="clave">
                            <i class="fa-solid fa-eye"></i>
                        </div>

                        <input type="submit" value="Actualizar" class="confirmar">

                    </div>

                </form>

            </div>

        </section>

    </main>

    <!-- UPDATE EN BD -->
    <%
    if(request.getMethod().equalsIgnoreCase("POST")){

        String id = request.getParameter("id_platillo");
        String nombre = request.getParameter("nombre");
        String categoria = request.getParameter("categoria");
        String descripcion = request.getParameter("descripcion");
        String precio = request.getParameter("precio");
        String imagen = request.getParameter("ruta_imagen");

        try{

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/FoodSync",
                "root",
                "n0m3l0"
            );

            PreparedStatement ps = con.prepareStatement(
                "UPDATE Platillos SET nombre=?, categoria=?, descripcion=?, precio=?, ruta_imagen=? WHERE id_platillo=?"
            );

            ps.setString(1, nombre);
            ps.setString(2, categoria);
            ps.setString(3, descripcion);
            ps.setDouble(4, Double.parseDouble(precio));
            ps.setString(5, imagen);
            ps.setInt(6, Integer.parseInt(id));

            int filas = ps.executeUpdate();

            if(filas > 0){
                out.println("<script>alert('Platillo actualizado correctamente');</script>");
            }else{
                out.println("<script>alert('No existe ese ID');</script>");
            }

            ps.close();
            con.close();

        }catch(Exception e){
            out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
        }
    }
    %>

</div>

</body>
</html>