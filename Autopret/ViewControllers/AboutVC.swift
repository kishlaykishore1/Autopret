
import UIKit
import MessageUI

class AboutVC: UIViewController {
    
    private var siteUrl = "https://www.wikipedia.org/"
    private var contactMailId = "contact@autopret.fr"
    private var privacyURl = "https://meta.wikimedia.org/wiki/Privacy_policy"
    private var tAndCUrl = "https://meta.wikimedia.org/wiki/Terms_of_use"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.setNavigationBarImage(for: UIImage(), color: #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1))
        setBackButton(tintColor: #colorLiteral(red: 0.05490196078, green: 0.1411764706, blue: 0.3176470588, alpha: 1), isImage: true, #imageLiteral(resourceName: "back_arrow_blue"))
        
        self.title = "À propos"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 16)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.05490196078, green: 0.1411764706, blue: 0.3176470588, alpha: 1)]
        
    }
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionTapOnView(_ sender: UIControl) {
        switch sender.tag {
        case 101:
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "Signaler un bug", message: "Aidez-nous à améliorer l’application en signalant toute anomalie rencontrée.", preferredStyle: .alert)
                alertController.addTextField { (textField : UITextField!) -> Void in
                    textField.placeholder = "Détails de votre rapport..."
                    textField.autocapitalizationType = .sentences
                    textField.isEnabled = false
                }
                
                let saveAction = UIAlertAction(title: "Envoyer", style: .destructive, handler: { alert -> Void in
                    let firstTextField = alertController.textFields![0] as UITextField
                    if firstTextField.text?.trim().count == 0 {
                        Common.showAlertMessage(message: Messages.txtPleaseEnterTheBugDetail, alertType: .error)
                        return
                    }
                })
                let cancelAction = UIAlertAction(title: "Annuler", style: .cancel, handler: { (action : UIAlertAction!) -> Void in
                    
                })
                alertController.addAction(saveAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: {
                    let firstTextField = alertController.textFields![0] as UITextField
                    firstTextField.isEnabled = true
                    firstTextField.becomeFirstResponder()
                })
            }
            break
        case 102:
            sendMail()
            break
        case 103:
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let webViewController = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            guard let getNav =  UIApplication.topViewController()?.navigationController else {
                return
            }
            webViewController.url = tAndCUrl
            webViewController.titleString = "Conditions Générales d’Utilisation"
            webViewController.flag = true
            let rootNavView = UINavigationController(rootViewController: webViewController)
            getNav.present( rootNavView, animated: true, completion: nil)
            break
        case 104:
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let webViewController = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            guard let getNav =  UIApplication.topViewController()?.navigationController else {
                return
            }
            webViewController.titleString = "Confidentialité"
            webViewController.url = privacyURl
            webViewController.flag = true
            let rootNavView = UINavigationController(rootViewController: webViewController)
            getNav.present( rootNavView, animated: true, completion: nil)
            break
        default:
            break
        }
    }
}

//MARK: Send Mail
extension AboutVC: MFMailComposeViewControllerDelegate {
    
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
