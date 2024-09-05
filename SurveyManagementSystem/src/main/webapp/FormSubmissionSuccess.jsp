<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Form Submission Success</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: skyblue;
        }
        .container {
            max-width: 600px;
            margin-top: 50px;
        }
        .message {
            background: #d4edda;
            color: #155724;
            padding: 20px;
            border-radius: 5px;
            border: 1px solid #c3e6cb;
        }
    </style>
</head>
<body>
    <div class="container text-center">
        <div class="message">
            <h1 class="mb-4">Your responses have been recorded successfully!</h1>
            <a href="SurveyLogin.jsp" class="btn btn-primary">Submit Another Response</a>
        </div>
    </div>
</body>
</html>
