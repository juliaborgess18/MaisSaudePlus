package maissaudeplus.controller.funcionario;

import com.jfoenix.controls.JFXButton;
import java.net.URL;
import java.util.ResourceBundle;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.stage.Stage;

/**
 * FXML Controller class
 * @author Igor
 * Dialog responsável pela remoção dos pacientes, está tela mostra apenas uma mensagem perguntando se o funcionário realmente 
 * deseja remover o paciente.
 */
public class FXMLAnchorPaneFuncionarioRemoverPacienteDialogController implements Initializable {

    @FXML
    private JFXButton buttonConfirmar;

    @FXML
    private JFXButton buttonCancelar;
    
    //Atributos para a manipulação do Stage
    private Stage dialogStage;
    private boolean buttonConfirmarClicked = false;
    
    @Override
    public void initialize(URL url, ResourceBundle rb) {
    
    }    
    
    //Método de manipulação do botão "Cancelar" 
    @FXML
    void handleButtonCancelar() {
        //Fechando o dialog, note que não a necessidade de informar que este botão foi pressionado já que a flag "buttonConfirmarClicked" foi declarada como falsa
        dialogStage.close();
    }

    //Método de manipulação do botão "Confirmar"
    @FXML
    void handleButtonConfirmar() {
        //Retorna verdadeiro sinalizando que o botão "Confirmar" foi pressionado
        buttonConfirmarClicked = true;
        //Fechando o dialog
        dialogStage.close();
    }

    //Getter e Setters dos atributos de manipulação do stage
    public Stage getDialogStage() {
        return dialogStage;
    }

    public void setDialogStage(Stage dialogStage) {
        this.dialogStage = dialogStage;
    }

    public boolean isButtonConfirmarClicked() {
        return buttonConfirmarClicked;
    }    
}
