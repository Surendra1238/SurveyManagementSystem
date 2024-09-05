<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fill Form</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/formBuilder/dist/form-render.min.css">
    <style>
        #form-render {
            border: 1px solid #ccc;
            padding: 10px;
            margin-top: 10px;
            background-color: #fff;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="mb-4"><%= request.getAttribute("formTitle") %></h1>
        <div id="form-render"></div>
        <button id="submit-form" class="btn btn-success mt-3">Submit Form</button>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/formBuilder/dist/form-render.min.js"></script>
    <script>
        $(document).ready(function() {
            var formData = <%= request.getAttribute("formContent") %>;

            $('#form-render').formRender({
                formData: formData
            });

            $('#submit-form').on('click', function() {
                // Collect form data and send it to the server
                var formData = $('#form-render').formRender('userData');
                $.ajax({
                    type: 'POST',
                    url: 'SubmitFormServlet',
                    data: {
                        formId: '<%= request.getParameter("formId") %>',
                        formData: JSON.stringify(formData)
                    },
                    success: function(response) {
                        window.location.href = 'FormSubmissionSuccess.jsp';
                    },
                    error: function(xhr, status, error) {
                        console.error('Error:', error);
                        alert('Failed to submit form.');
                    }
                });
            });
        });
    </script>
</body>
</html>
