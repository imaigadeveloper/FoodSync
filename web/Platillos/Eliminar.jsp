<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodSync - Eliminar Platillo</title>

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

            <h1 class="titulo-menu">Eliminar platillo</h1>

            <div class="barra-acciones">
                <a href="../Platillos.jsp">Consultar</a>
                <span>|</span>
                <a href="Agregar.jsp">Agregar</a>
                <span>|</span>
                <a href="Eliminar.jsp" class="activo">Eliminar</a>
                <span>|</span>
                <a href="Modificar.jsp">Modificar</a>
            </div>

            <!-- FORMULARIO ELIMINAR -->
            <div class="contenido-platillos">

                <form method="post">

                    <div class="seccion-eliminar">

                        <h2>Eliminar platillo</h2>

                        <label>ID del platillo</label>
                        <input type="number" name="id_platillo" class="input-form" required>

                        <label>Confirmar eliminación</label>

                        <div class="input-password">
                            <input type="password" name="clave" placeholder="Clave">
                            <i class="fa-solid fa-eye"></i>
                        </div>

                        <input type="submit" value="Eliminar" class="confirmar">

                    </div>

                </form>

            </div>

        </section>

    </main>

    <!-- DELETE EN BD -->
    <%
    if(request.getMethod().equalsIgnoreCase("POST")){

        String id = request.getParameter("id_platillo");

        try{

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/FoodSync",
                "root",
                "n0m3l0"
            );

            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM Platillos WHERE id_platillo=?"
            );

            ps.setInt(1, Integer.parseInt(id));

            int filas = ps.executeUpdate();

            if(filas > 0){
                out.println("<script>alert('Platillo eliminado correctamente');</script>");
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