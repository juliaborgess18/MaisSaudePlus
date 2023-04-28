package maissaudeplus.controller.medico;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

import com.jfoenix.controls.JFXButton;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.control.MenuItem;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;
import maissaudeplus.Main;

public class FXMLVBoxMedicoMainController implements Initializable {
    
    @FXML
    private MenuItem menuItemTrocarFuncionario;

    @FXML
    private MenuItem menuItemTrocarMedico;

    @FXML
    private JFXButton buttonRealizarConsulta;
    
    @FXML
    private JFXButton buttonConsultaPorMes;

    @FXML
    private JFXButton buttonClose;

    @FXML
    private AnchorPane anchorPaneBase;

    private AnchorPane anchorPaneRealizarConsulta;
    private AnchorPane anchorPaneGraficoPorMes;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
    }
  
    @FXML
    void handleMenuItemTrocarFuncionario() throws IOException {
        Main.setRoot("/maissaudeplus/view/funcionario/FXMLVBoxFuncionarioMain.fxml");
    }

    @FXML
    void handleMenuItemTrocarMedico() throws IOException {
        Main.setRoot("/maissaudeplus/view/medico/FXMLVBoxMedicoMain.fxml");
    }
    
    @FXML
    public void handleButtonClose(){
        Stage stage = (Stage) buttonClose.getScene().getWindow();
        stage.close(); 
    }

    @FXML
    public void handleRealizarConsulta() throws IOException{
        if(anchorPaneRealizarConsulta == null){
            anchorPaneRealizarConsulta = (AnchorPane) FXMLLoader.load(getClass().getResource("/maissaudeplus/view/medico/FXMLAnchorPaneMedicoRealizarConsulta.fxml"));
        }


        AnchorPane.setTopAnchor(anchorPaneRealizarConsulta, 200.0);
        AnchorPane.setBottomAnchor(anchorPaneRealizarConsulta,200.0 );
        AnchorPane.setLeftAnchor(anchorPaneRealizarConsulta, 200.0);
        AnchorPane.setRightAnchor(anchorPaneRealizarConsulta, 200.0);
        
        anchorPaneBase.getChildren().setAll(anchorPaneRealizarConsulta);
        
    }
    
    @FXML
    public void handleButtonConsultaPorMes() throws IOException {
        if(anchorPaneGraficoPorMes == null){
            anchorPaneGraficoPorMes = (AnchorPane) FXMLLoader.load(getClass().getResource("/maissaudeplus/view/medico/FXMLAnchorPaneMedicoGraficoConsultasPorMes.fxml"));
        }
        AnchorPane.setTopAnchor(anchorPaneGraficoPorMes, 0.0);
        AnchorPane.setBottomAnchor(anchorPaneGraficoPorMes,0.0 );
        AnchorPane.setLeftAnchor(anchorPaneGraficoPorMes, 0.0);
        AnchorPane.setRightAnchor(anchorPaneGraficoPorMes, 0.0);
        anchorPaneBase.getChildren().setAll(anchorPaneGraficoPorMes);
    }
    
}
