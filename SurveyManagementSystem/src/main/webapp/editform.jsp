<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.JSONObject" %> <!-- Assuming you are using JSON -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Form</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/formBuilder/dist/form-builder.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/formBuilder/dist/form-render.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style2.css">
</head>
<body>
    <h3 style="text-align:center;color:green">Form Editing</h3>
    <div class="container">
        <div id="form-builder"></div>
        <br><br>
        <div class="button-group">
            <button id="update-form" class="update-button">Update Form</button>
            <a href="viewforms.jsp" class="back-button">Back</a>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/formBuilder/dist/form-builder.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/formBuilder/dist/form-render.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            var formId = new URLSearchParams(window.location.search).get('id');

            // Fetch the existing form data
            $.ajax({
                type: 'GET',
                url: 'GetFormServlet', // This servlet will return the form data for the given form ID
                data: { id: formId },
                success: function(response) {
                    var formData = response.formData; // Assuming formData is returned in JSON format
                    var formBuilder = $('#form-builder').formBuilder({
                        formData: formData // Load the form data into form builder
                    });
                    $('#update-form').on('click', function() {
                        var updatedFormData = formBuilder.actions.getData('json');
                        $.ajax({
                            type: 'POST',
                            url: 'UpdateFormServlet', // Servlet to update form data
                            data: {
                                formId: formId,
                                formData: updatedFormData
                            },
                            success: function(response) {
                                alert('Form updated successfully!');
                            },
                            error: function(xhr, status, error) {
                                console.error('Error:', error);
                                alert('Failed to update form.');
                            }
                        });
                    });
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                    alert('Failed to load form data.');
                }
            });
        });
    </script>
</body>
</html>