package Chart;

import org.knowm.xchart.CategoryChart;
import org.knowm.xchart.CategoryChartBuilder;
import java.sql.*;
import java.util.ArrayList;
import java.util.Map;
import java.util.TreeMap; // Import TreeMap to sort the data
import Database.DatabaseManager;
import Database.UserSession;
import javax.swing.JFrame;
import org.knowm.xchart.SwingWrapper;

public class IncomeExpenseChart {

    // Array of month names in chronological order
    private static final String[] MONTHS = {
            "January", "February", "March", "April", "May", "June", "July", "August", "September", "October",
            "November", "December"
    };

    public static Map<String, Integer> getMonthlyIncome() throws SQLException {
        Map<String, Integer> monthlyIncome = new TreeMap<>();
        DatabaseManager.connect();
        String query = "SELECT monthname(income_date) AS month, SUM(amount) AS income " +
                "FROM income " +
                "WHERE user_id = ? " +
                "GROUP BY month";
        try (PreparedStatement pstmt = DatabaseManager.getConnection().prepareStatement(query)) {
            pstmt.setInt(1, UserSession.userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                String month = rs.getString("month");
                int income = rs.getInt("income");
                monthlyIncome.put(month, income);
            }
        }
        // Ensure all months are in the map with 0 income if no records found
        for (String month : MONTHS) {
            monthlyIncome.putIfAbsent(month, 0);
        }
        return monthlyIncome;
    }

    public static Map<String, Integer> getMonthlyExpenses() throws SQLException {
        Map<String, Integer> monthlyExpenses = new TreeMap<>();
        DatabaseManager.connect();
        String query = "SELECT monthname(expense_date) AS month, SUM(amount) AS expense " +
                "FROM expense " +
                "WHERE user_id = ? " +
                "GROUP BY month";
        try (PreparedStatement pstmt = DatabaseManager.getConnection().prepareStatement(query)) {
            pstmt.setInt(1, UserSession.userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                String month = rs.getString("month");
                int expense = rs.getInt("expense");
                monthlyExpenses.put(month, expense);
            }
        }
        // Ensure all months are in the map with 0 expenses if no records found
        for (String month : MONTHS) {
            monthlyExpenses.putIfAbsent(month, 0);
        }
        return monthlyExpenses;
    }

    public static void generateChart(Map<String, Integer> monthlyIncome, Map<String, Integer> monthlyExpenses) {

        Thread chartThread = new Thread(() -> {
            // Create XChart
            CategoryChart chart = new CategoryChartBuilder()
                    .width(1000)
                    .height(504)
                    .title("Monthly Income vs. Expenses")
                    .xAxisTitle("Month")
                    .yAxisTitle("Amount")
                    .build();

            // Add income and expense series to the chart
            chart.addSeries("Income", new ArrayList<>(monthlyIncome.keySet()), new ArrayList<>(monthlyIncome.values()));
            chart.addSeries("Expenses", new ArrayList<>(monthlyExpenses.keySet()),
                    new ArrayList<>(monthlyExpenses.values()));

            SwingWrapper<CategoryChart> wrapper = new SwingWrapper<>(chart);
            JFrame frame = wrapper.displayChart();

            // Override the default close operation of the JFrame
            frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        });
        // Start the thread
        chartThread.start();
    }
}