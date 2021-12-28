
import UIKit

class ConfirmCarVC: UIViewController {
    @IBOutlet weak var viewValidateVehcle: UIControl!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        self.navigationController?.isNavigationBarHidden = false
        topViewHeight.constant = topDistance + 8
        DispatchQueue.main.async {
            self.navView.roundCorners([.bottomLeft, .bottomRight], radius: 16)
            
            self.viewValidateVehcle.applyGradient(withColours: [#colorLiteral(red: 0.5019607843, green: 0.7647058824, blue: 0.9529411765, alpha: 1), #colorLiteral(red: 0, green: 0.4274509804, blue: 0.9294117647, alpha: 1)], gradientOrientation: .horizontal)
            self.viewValidateVehcle.cornerRadius = self.viewValidateVehcle.frame.height / 2
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
    @IBAction func actionValidateVehcle(_ sender: UIControl) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let contractAddDetailsVC = storyboard.instantiateViewController(withIdentifier: "ContractAddDetailsVC") as! ContractAddDetailsVC
        self.navigationController?.pushViewController(contractAddDetailsVC, animated: true)
    }
    @IBAction func actionNotMyCar(_ sender: UIControl) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editCarVC = storyboard.instantiateViewController(withIdentifier: "EditCarVC") as! EditCarVC
        guard let getNav =  UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: editCarVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
}
