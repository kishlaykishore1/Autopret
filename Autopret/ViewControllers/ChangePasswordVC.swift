
import UIKit

class ChangePasswordVC: UIViewController {
    
    //MARK: IBOutlet
    @IBOutlet weak var navBarBtnEnRegister: UIBarButtonItem!
    @IBOutlet weak var navBarBtnBack: UIBarButtonItem!
    //MARK: Proparites
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        hideKeyboardWhenTappedAround()
        self.navigationController?.isNavigationBarHidden = false
        self.setNavigationBarImage(for: UIImage(), color: #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1))
        navBarBtnEnRegister.setTitleTextAttributes (
            [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Bold", size: 16)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1)], for: .normal)
        navBarBtnBack.setTitleTextAttributes (
            [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Medium", size: 16)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1)], for: .normal)
    }
    
    @IBAction func backBtnTapAction(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func enRegisterTapAction(_ sender: UIBarButtonItem) {
        
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
}
