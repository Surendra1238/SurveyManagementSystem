package survey;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class AnalyzeResponsesServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int formId = Integer.parseInt(request.getParameter("formId"));
        
        // Fetch the form title
        String formTitle = getFormTitle(formId);
        
        List<String> responses = getResponseData(formId);
        Map<String, Map<String, Integer>> analysisResults = analyzeResponses(responses);

        request.setAttribute("analysisResults", analysisResults);
        request.setAttribute("formTitle", formTitle); // Add formTitle to request attributes
        request.getRequestDispatcher("responseAnalysis.jsp").forward(request, response);
    }

    private String getFormTitle(int formId) {
        String formTitle = "";
        String query = "SELECT FORM_TITLE FROM Forms WHERE ID = ?";

        try (Connection conn = DatabaseConnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, formId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                formTitle = rs.getString("FORM_TITLE");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return formTitle;
    }

    private List<String> getResponseData(int formId) {
        List<String> responses = new ArrayList<>();
        String query = "SELECT RESPONSE_DATA FROM Responses WHERE FORM_ID = ?";

        try (Connection conn = DatabaseConnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, formId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                responses.add(rs.getString("RESPONSE_DATA"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return responses;
    }

    private Map<String, Map<String, Integer>> analyzeResponses(List<String> responses) {
        Map<String, Map<String, Integer>> analysisResults = new HashMap<>();

        for (String responseData : responses) {
            try {
                // Assuming responseData is a JSON array
                JSONArray responseArray = new JSONArray(responseData);

                for (int i = 0; i < responseArray.length(); i++) {
                    JSONObject question = responseArray.getJSONObject(i);
                    String type = question.getString("type");

                    if (type.equals("radio-group") || type.equals("checkbox-group")) {
                        String label = question.getString("label");
                        JSONArray userData = question.getJSONArray("userData");

                        analysisResults.putIfAbsent(label, new HashMap<>());
                        Map<String, Integer> optionCounts = analysisResults.get(label);

                        for (int j = 0; j < userData.length(); j++) {
                            String selectedOption = userData.getString(j);
                            optionCounts.put(selectedOption, optionCounts.getOrDefault(selectedOption, 0) + 1);
                        }
                    }
                }
            } catch (JSONException e) {
                System.err.println("Failed to parse JSON: " + responseData);
                e.printStackTrace();
            }
        }

        return analysisResults;
    }
}
