<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <title>Forgot Password</title>
    <style>
        form { width: 350px; }
        body { background-image: url('LoginImage.png'); background-repeat: no-repeat; }
    </style>
</head>
<body class="d-flex justify-content-center align-items-center vh-100">
    <div class="card p-4">
        <form id="forgotPasswordForm" action="ForgotPasswordServlet" method="post">
            <h5 class="text-center mb-4 text-warning">Forgot Password</h5>
            <div class="mb-3">
                <input type="email" id="email" name="email" class="form-control" placeholder="Enter your Email" required>
            </div>
            <div class="d-grid">
                <button type="submit" class="btn btn-secondary">Reset Password</button>
            </div>
            <div class="text-center mt-3">
                <a href="SurveyLogin.jsp" style="text-decoration:none;">Back to Login</a>
            </div>
        </form>
    </div>
</body>
</html>
