<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodSync - Agregar Platillo</title>

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
        <a href="../Reservaciones.jsp">Reservaciones</a>
        <span>|</span>
        <a href="../Pedidos.jsp">Pedidos</a>
        <span>|</span>
        <a href="../Personal.jsp">Personal</a>
        <span>|</span>
        <a href="../Clientes.jsp">Clientes</a>
        <span>|</span>
        <a href="../Ventas.jsp">Ventas</a>
        <span>|</span>
        <a href="../Cocina.jsp">Cocina</a>
    </div>

    <!-- CONTENIDO -->
    <main class="contenido">

        <section class="panel-principal">

            <h1 class="titulo-menu">Agregar platillo</h1>

            <div class="barra-acciones">
                <a href="../Platillos.jsp">Consultar</a>
                <span>|</span>
                <a href="Agregar.jsp" class="activo">Agregar</a>
                <span>|</span>
                <a href="Eliminar.jsp">Eliminar</a>
                <span>|</span>
                <a href="Modificar.jsp">Modificar</a>
            </div>

            <!-- FORMULARIO -->
            <div class="contenido-platillos">

                <form method="post">

                    <div class="seccion-agregar">

                        <label>Nombre</label>
                        <input type="text" name="nombre" class="input-form" required>

                        <label>Categoría</label>
                        <input type="text" name="categoria" class="input-form" required>

                        <label>Precio</label>
                        <input type="number" step="0.01" name="precio" class="input-form" required>

                        <label>Descripción</label>
                        <input type="text" name="descripcion" class="descripcion">

                        <label>Imagen (ej: Takos.jpg)</label>
                        <input type="text" name="ruta_imagen" class="input-form" required>

                    </div>

                    <div class="confirmacion">

                        <label>Confirmar registro</label>

                        <div class="input-password">
                            <input type="password" name="clave" placeholder="Clave">
                            <i class="fa-solid fa-eye"></i>
                        </div>

                        <input type="submit" value="Confirmar" class="confirmar">

                    </div>

                </form>

            </div>

        </section>

    </main>

    <!-- INSERT A BD -->
    <%
    if(request.getMethod().equalsIgnoreCase("POST")){

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
                "INSERT INTO Platillos(nombre,categoria,descripcion,precio,ruta_imagen,estado) VALUES (?,?,?,?,?,'Disponible')"
            );

            ps.setString(1, nombre);
            ps.setString(2, categoria);
            ps.setString(3, descripcion);
            ps.setDouble(4, Double.parseDouble(precio));
            ps.setString(5, imagen);

            ps.executeUpdate();

            out.println("<script>alert('Platillo agregado correctamente');</script>");

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