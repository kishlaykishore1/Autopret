
import UIKit
import MessageUI

class LoginVC: UIViewController {
    
    @IBOutlet weak var loginView: UIControl!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UILabel!
    
    private var contactMailId = "contact@autopret.fr"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        DispatchQueue.main.async {
            self.loginView.applyGradient(withColours: [#colorLiteral(red: 0.5019607843, green: 0.7647058824, blue: 0.9529411765, alpha: 1), #colorLiteral(red: 0, green: 0.4274509804, blue: 0.9294117647, alpha: 1)], gradientOrientation: .horizontal)
            self.loginView.cornerRadius = self.loginView.frame.height / 2
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func actionLogin(_ sender: UIControl) {
        
        
        
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                sd.isUserLogin(true)
            }
        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.isUserLogin(true)
        }
    }
    
    @IBAction func actionOpenMail(_ sender: UIControl) {
        sendMail()
    }
}

//MARK: Send Mail
extension LoginVC: MFMailComposeViewControllerDelegate {
    
    func sendMail() {
        if !MFMailComposeViewController.canSendMail() {
            Common.showAlertMessage(message: Messages.mailNotFound, alertType: .warning)
            return
        }
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients([self.contactMailId])
        composeVC.setSubject("Demande de contact")
        composeVC.setMessageBody("", isHTML: false)
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
