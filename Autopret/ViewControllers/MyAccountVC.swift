
import UIKit

class MyAccountVC: UIViewController {
    let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.setNavigationBarImage(for: UIImage(), color: #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1))
        setBackButton(tintColor: #colorLiteral(red: 0.05490196078, green: 0.1411764706, blue: 0.3176470588, alpha: 1), isImage: true, #imageLiteral(resourceName: "back_arrow_blue"))
        
        self.title = "Mon compte"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 16)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.05490196078, green: 0.1411764706, blue: 0.3176470588, alpha: 1)]
        
    }
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionChangePassword(_ sender: UIView) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myAccountVC = storyboard.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        guard let getNav =  UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: myAccountVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
    
    @IBAction func actionDeleteVD(_ sender: UIControl) {
        
    }
    @IBAction func actionUpdateVD(_ sender: UIControl) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Ajouter un VD", message: "\nEntrez la plaque d’immatricutlation pour ajouter le VD sur votre compte.", preferredStyle: .alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Immatricuation"
                textField.delegate = self
                textField.autocapitalizationType = .allCharacters
                textField.isEnabled = false
            }
            let cancelAction = UIAlertAction(title: "Annuler", style: .default, handler: { (action : UIAlertAction!) -> Void in
                
            })
            let saveAction = UIAlertAction(title: "Confirmer", style: .default, handler: { alert -> Void in
                
                //let firstTextField = alertController.textFields![0] as UITextField
                //                if firstTextField.text?.trim().count == 0 {
                //                    Common.showAlertMessage(message: Messages.txtPleaseEnterTheBugDetail, alertType: .error)
                //                    return
                //                }
                
                let alert  = UIAlertController(title: "Confirmer le VD", message: "\nNous avous trouvé le véhicule suivant pour cette plaque d’immatricualtion :\n\nRENAULT Clio 4", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "Confirmer le modèle", style: .default, handler: { _ in
                    
                })
                alert.addAction(confirm)
                alert.preferredAction = confirm
                alert.addAction(UIAlertAction(title: "Ajouter mannuellement", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            })
            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
            alertController.preferredAction = saveAction
            
            self.present(alertController, animated: true, completion: {
                let firstTextField = alertController.textFields![0] as UITextField
                firstTextField.isEnabled = true
                firstTextField.becomeFirstResponder()
            })
        }
    }
    @IBAction func actionLogout(_ sender: UIControl) {
        let alert  = UIAlertController(title: "Avertissement !", message: "\nÊtes-vous certain de vouloir vous déconnecter ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Se déconnecter", style: .destructive, handler: { _ in
            if #available(iOS 13.0, *) {
                let scene = UIApplication.shared.connectedScenes.first
                if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                    sd.isUserLogin(false)
                }
            } else {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.isUserLogin(false)
            }
        }))
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
extension MyAccountVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let cs = CharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
        let filtered: String = (string.components(separatedBy: cs) as NSArray).componentsJoined(by: "")
        return (string == filtered)
    }
}
