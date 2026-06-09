<%@page import="java.sql.*"%>
<%@page import="modelo.Conexion"%>
<%
    String user = request.getParameter("usuario");
    String pass = request.getParameter("password");
    
    Conexion conClase = new Conexion();
    Connection conn = conClase.conectar();
    PreparedStatement ps = null;
    ResultSet rs = null;

    // 1. INTENTAR LOGIN COMO PERSONAL (Supervisor o Cocinero)
    ps = conn.prepareStatement("SELECT p.id_personal, p.nombre, pu.nombre_puesto FROM Personal p JOIN Puestos pu ON p.id_puesto = pu.id_puesto WHERE p.id_personal = ? AND p.password_token = ?");
    ps.setString(1, user);
    ps.setString(2, pass);
    rs = ps.executeQuery();

    if (rs.next()) {
        session.setAttribute("usuario", rs.getString("id_personal"));
        session.setAttribute("nombre", rs.getString("nombre"));
        session.setAttribute("rol", rs.getString("nombre_puesto")); // Guarda 'Supervisor' o 'Cocinero'
        response.sendRedirect("index.jsp");
    } else {
        // 2. SI NO ES PERSONAL, INTENTAR LOGIN COMO CLIENTE
        ps = conn.prepareStatement("SELECT * FROM Clientes WHERE usuario = ? AND password = ?");
        ps.setString(1, user);
        ps.setString(2, pass);
        rs = ps.executeQuery();
        
        if (rs.next()) {
            session.setAttribute("usuario", rs.getString("usuario"));
            session.setAttribute("nombre", rs.getString("nombre"));
            session.setAttribute("rol", "Cliente"); // Rol especial para los registrados
            response.sendRedirect("index.jsp");
        } else {
            response.sendRedirect("Sesion.jsp?error=CredencialesIncorrectas");
        }
    }
    conn.close();
%>