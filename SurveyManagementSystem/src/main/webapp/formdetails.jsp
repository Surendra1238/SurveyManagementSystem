<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Form Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/formBuilder/dist/form-render.min.css">
    <style>
        #form-render {
            border: 1px solid #ccc;
            padding: 10px;
            margin-top: 10px;
            background-color: #fff;
        }
        /* Back button styling */
        .back-button {
            position: absolute;
            top: 20px;
            right: 20px;
            padding: 10px 20px;
            font-size: 16px;
            color: #ffffff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
        }
        .back-button:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="mb-4"><%= request.getAttribute("formTitle") %></h1>
        <div id="form-render">
        </div>
    </div>
    <a href="viewforms.jsp" class="back-button">Back</a>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/formBuilder/dist/form-render.min.js"></script>
    <script>
        $(document).ready(function() {
            var formData = '<%= request.getAttribute("formContent") %>';
            $('#form-render').formRender({
                formData: formData
            });
        });
    </script>
</body>
</html>
