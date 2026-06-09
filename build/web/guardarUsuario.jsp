<%@ page import="java.sql.*" %>
<%@ page import="modelo.Conexion" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    
    String fecha = request.getParameter("fecha");
    String nombre = request.getParameter("nombre");
    String correo = request.getParameter("correo");
    String usuario = request.getParameter("usuario");
    String password = request.getParameter("password");
    
    if(fecha == null || nombre == null || correo == null || usuario == null || password == null) {
        response.sendRedirect("Registrarse.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;

    try {
        Conexion conClase = new Conexion();
        con = conClase.conectar();

        String sql = "INSERT INTO Clientes (nombre, correo, usuario, password, fecha_nacimiento, puntos) VALUES (?, ?, ?, ?, ?, 0)";
        ps = con.prepareStatement(sql);
        ps.setString(1, nombre);
        ps.setString(2, correo);
        ps.setString(3, usuario);
        ps.setString(4, password);
        ps.setString(5, fecha);

        int resultado = ps.executeUpdate();

        if(resultado > 0) {
            // Iniciar sesión automáticamente al registrarse con éxito
            session.setAttribute("usuario", usuario);
            session.setAttribute("nombre", nombre);
            session.setAttribute("rol", "Cliente");
            
            out.println("<script>");
            out.println("alert('¡Registro exitoso! Bienvenido.');");
            out.println("window.location.href='index.jsp';");
            out.println("</script>");
        }

    } catch (Exception e) {
        out.println("<script>");
        out.println("alert('Error al registrar: El usuario o correo ya existen.');");
        out.println("window.location.href='Registrarse.jsp';");
        out.println("</script>");
    } finally {
        if (ps != null) try { ps.close(); } catch(Exception e){}
        if (con != null) try { con.close(); } catch(Exception e){}
    }
%>