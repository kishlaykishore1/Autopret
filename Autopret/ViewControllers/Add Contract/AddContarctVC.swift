
import UIKit
import IQKeyboardManagerSwift

class AddContarctVC: UIViewController {
    
    @IBOutlet weak var tfDob: UITextField!
    @IBOutlet weak var viewNextStep: UIControl!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    var isPresent = false
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        let date = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        picker.maximumDate = date
        picker.locale =  Locale(identifier: "fr")
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        self.navigationController?.isNavigationBarHidden = false
        topViewHeight.constant = topDistance + 8
        tfDob.delegate = self
        DispatchQueue.main.async {
            self.navView.roundCorners([.bottomLeft, .bottomRight], radius: 16)
            self.viewNextStep.applyGradient(withColours: [#colorLiteral(red: 0.5019607843, green: 0.7647058824, blue: 0.9529411765, alpha: 1), #colorLiteral(red: 0, green: 0.4274509804, blue: 0.9294117647, alpha: 1)], gradientOrientation: .horizontal)
            self.viewNextStep.cornerRadius = self.viewNextStep.frame.height / 2
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setNavigationBarImage(for: UIImage(), color: #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1))
        self.setBackButton(tintColor: .white, isImage: true)
        self.title = "Infomations client"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 16)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)]
        IQKeyboardManager.shared.enableAutoToolbar = true
    }
    
    override func backBtnTapAction() {
        if isPresent {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func actionNextStep(_ sender: UIControl) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addContarct2VC = storyboard.instantiateViewController(withIdentifier: "AddContarct2VC") as! AddContarct2VC
        self.navigationController?.pushViewController(addContarct2VC, animated: true)
    }
    
    @IBAction func actionExistClient(_ sender: UIControl) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let clientExistVC = storyboard.instantiateViewController(withIdentifier: "ClientExistVC") as! ClientExistVC
        guard let getNav =  UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: clientExistVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
}

//MARK: UITextFieldDelegate
extension AddContarctVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       if textField == tfDob {
             textField.inputView = datePicker
        }
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == tfDob {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.long
            dateFormatter.timeStyle = DateFormatter.Style.none
            dateFormatter.locale = Locale(identifier: "fr")
            let date =  dateFormatter.string(from: self.datePicker.date)
            textField.text = date
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return view.endEditing(true)
    }
}
