
import UIKit

class ChooseCarVC: UIViewController {
    
    @IBOutlet weak var tfNoPlate: UITextField!
    @IBOutlet weak var numberBackView: DesignableButton!
    @IBOutlet weak var viewSearchVehcle: UIControl!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        tfNoPlate.delegate = self
        self.navigationController?.isNavigationBarHidden = false
        topViewHeight.constant = topDistance + 8
        DispatchQueue.main.async {
            self.navView.roundCorners([.bottomLeft, .bottomRight], radius: 16)
            self.numberBackView.applyGradient(withColours: [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.8078431373, green: 0.8078431373, blue: 0.8078431373, alpha: 1)], gradientOrientation: .vertical)
            self.viewSearchVehcle.applyGradient(withColours: [#colorLiteral(red: 0.5019607843, green: 0.7647058824, blue: 0.9529411765, alpha: 1), #colorLiteral(red: 0, green: 0.4274509804, blue: 0.9294117647, alpha: 1)], gradientOrientation: .horizontal)
            self.viewSearchVehcle.cornerRadius = self.viewSearchVehcle.frame.height / 2
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setNavigationBarImage(for: UIImage(), color: #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1))
        self.setBackButton(tintColor: .white, isImage: true)
        self.title = "Véhicule"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 16)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)]
    }
    
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionSearchVehcle(_ sender: UIControl) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let confirmCarVC = storyboard.instantiateViewController(withIdentifier: "ConfirmCarVC") as! ConfirmCarVC
        self.navigationController?.pushViewController(confirmCarVC, animated: true)
    }
    @IBAction func actionAddMenual(_ sender: UIControl) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editCarVC = storyboard.instantiateViewController(withIdentifier: "EditCarVC") as! EditCarVC
        guard let getNav =  UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: editCarVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
}

extension ChooseCarVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let cs = CharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
        let filtered: String = (string.components(separatedBy: cs) as NSArray).componentsJoined(by: "")
        return (string == filtered)
    }
}
