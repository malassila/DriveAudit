package com.pcsp.DriveAuditFX;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.context.ConfigurableApplicationContext;

import java.io.IOException;

@SpringBootApplication
public class DriveAuditFxApplication extends Application {

	private ConfigurableApplicationContext context;

	@Override
	public void init() {
		String[] args = getParameters().getRaw().toArray(new String[0]);
		this.context = new SpringApplicationBuilder()
				.sources(DriveAuditFxApplication.class)
				.run(args);
	}

	@Override
	public void start(Stage stage) {
		FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("/home.fxml"));
		fxmlLoader.setControllerFactory(context::getBean);
		Parent parent = null;
		try {
			parent = fxmlLoader.load();
		} catch (IOException e) {
			e.printStackTrace();
		}
		Scene scene = new Scene(parent);
		stage.setScene(scene);
		stage.show();
	}

	@Override
	public void stop() {
		this.context.close();
	}

}

