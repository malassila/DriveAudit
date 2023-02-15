package com.pcsp.DriveAuditFX.controller;

import javafx.beans.property.SimpleStringProperty;
import javafx.fxml.FXML;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;

public class Home {
    @FXML
    private TableView<String[]> table;
    @FXML
    private TableColumn<String[], String> column1;
    @FXML
    private TableColumn<String[], String> column2;
    @FXML
    private TableColumn<String[], String> column3;
    @FXML
    private TableColumn<String[], String> column4;
    @FXML
    private TableColumn<String[], String> column5;

    public void initialize() {
        // Define the table columns
        column1.setCellValueFactory(cellData -> new SimpleStringProperty(cellData.getValue()[0]));
        column2.setCellValueFactory(cellData -> new SimpleStringProperty(cellData.getValue()[1]));
        column3.setCellValueFactory(cellData -> new SimpleStringProperty(cellData.getValue()[2]));
        column4.setCellValueFactory(cellData -> new SimpleStringProperty(cellData.getValue()[3]));
        column5.setCellValueFactory(cellData -> new SimpleStringProperty(cellData.getValue()[4]));

        // Add sample data to the table
        String[][] data = {
                { "1", "apple", "red", "fruit", "sweet" },
                { "2", "banana", "yellow", "fruit", "sweet" },
                { "3", "carrot", "orange", "vegetable", "crunchy" },
                { "4", "pear", "green", "fruit", "juicy" },
                { "5", "tomato", "red", "fruit", "sour" }
        };
        for (String[] row : data) {
            table.getItems().add(row);
        }
    }
}
