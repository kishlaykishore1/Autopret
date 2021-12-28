
import UIKit

class EditCarVC: UIViewController {
    @IBOutlet weak var viewVelidateVehcle: UIControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        DispatchQueue.main.async {
            self.viewVelidateVehcle.applyGradient(withColours: [#colorLiteral(red: 0.5019607843, green: 0.7647058824, blue: 0.9529411765, alpha: 1), #colorLiteral(red: 0, green: 0.4274509804, blue: 0.9294117647, alpha: 1)], gradientOrientation: .horizontal)
            self.viewVelidateVehcle.cornerRadius = self.viewVelidateVehcle.frame.height / 2
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.setNavigationBarImage(for: UIImage(), color: #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1))
        setBackButton(tintColor: #colorLiteral(red: 0.05490196078, green: 0.1411764706, blue: 0.3176470588, alpha: 1), isImage: true, #imageLiteral(resourceName: "back_arrow_blue"))
        
        self.title = "Modifier le véhicule"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 16)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.05490196078, green: 0.1411764706, blue: 0.3176470588, alpha: 1)]
        
    }
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionVelidateVehcle(_ sender: UIControl) {
        
        self.dismiss(animated: true) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let contractAddDetailsVC = storyboard.instantiateViewController(withIdentifier: "ContractAddDetailsVC") as! ContractAddDetailsVC
            self.navigationController?.pushViewController(contractAddDetailsVC, animated: true)
        }
    }
}
