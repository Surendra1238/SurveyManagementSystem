<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <title>Dynamic Form</title>
    <style>
        form { width: 350px; }
        body { background-image: url('LoginImage.png'); background-repeat: no-repeat; }
        .login-links a { margin-right: 15px; }
    </style>
</head>
<body class="d-flex justify-content-center align-items-center vh-100">
    <div class="card p-4">
        <form id="myForm" action="LoginServlet" method="post">
            <h5 class="text-center mb-4 text-success">Survey Management System</h5>
            <div class="mb-3">
                <label for="email" class="form-label">Email:</label>
                <input type="email" id="email" name="email" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password:</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="role" class="form-label">Role:</label>
                <input type="radio" name="role" value="admin" required>Admin
                <input type="radio" name="role" value="user" required>User
            </div>
            <div class="d-grid">
                <button type="submit" class="btn btn-warning">Login</button>
            </div>
            <div class="text-center mt-3 login-links">
                <a href="ForgotPassword.jsp">Forgot Password?</a>
                <a href="register.jsp">Don't have an account?</a>
            </div>
        </form>
    </div>
</body>
</html>
