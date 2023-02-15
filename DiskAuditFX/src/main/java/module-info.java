module com.pcsp.diskauditfx {
    requires javafx.controls;
    requires javafx.fxml;


    opens com.pcsp.diskauditfx to javafx.fxml;
    exports com.pcsp.diskauditfx;
}