
import UIKit

class ContractAddDetails2VC: UIViewController {
    
    @IBOutlet weak var timeOfResrvation: UITextField!
    @IBOutlet weak var dateOfResurvation: UITextField!
    @IBOutlet weak var timeOfDepart: UITextField!
    @IBOutlet weak var dateOfDepart: UITextField!
    @IBOutlet weak var viewNextStep: UIControl!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.minimumDate = Date()
        picker.locale = Locale(identifier: "fr")
        return picker
    }()
    
    lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.minimumDate = Date()
        picker.locale = Locale(identifier: "fr")
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        timeOfResrvation.delegate = self
        dateOfResurvation.delegate = self
        timeOfDepart.delegate = self
        dateOfDepart.delegate = self
        
        self.navigationController?.isNavigationBarHidden = false
        topViewHeight.constant = topDistance + 8
        DispatchQueue.main.async {
            self.navView.roundCorners([.bottomLeft, .bottomRight], radius: 16)
            self.viewNextStep.applyGradient(withColours: [#colorLiteral(red: 0.5019607843, green: 0.7647058824, blue: 0.9529411765, alpha: 1), #colorLiteral(red: 0, green: 0.4274509804, blue: 0.9294117647, alpha: 1)], gradientOrientation: .horizontal)
            self.viewNextStep.cornerRadius = self.viewNextStep.frame.height / 2
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setNavigationBarImage(for: UIImage(), color: #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1))
        self.setBackButton(tintColor: .white, isImage: true)
        self.title = "Conditions du prêt"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 16)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)]
    }
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionNextStep(_ sender: UIControl) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let contractAddInssuranceVC = storyboard.instantiateViewController(withIdentifier: "ContractAddInssuranceVC") as! ContractAddInssuranceVC
        self.navigationController?.pushViewController(contractAddInssuranceVC, animated: true)
    }
}

//MARK: UITextFieldDelegate
extension ContractAddDetails2VC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == timeOfResrvation {
            textField.inputView = timePicker
        } else if textField == dateOfResurvation {
            textField.inputView = datePicker
        } else if textField == timeOfDepart {
            textField.inputView = timePicker
        } else if textField == dateOfDepart {
            textField.inputView = datePicker
        }
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == timeOfResrvation {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.none
            dateFormatter.timeStyle = DateFormatter.Style.short
            dateFormatter.locale = Locale(identifier: "fr")
            let date =  dateFormatter.string(from: self.timePicker.date)
            textField.text = date
        } else if textField == dateOfResurvation {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            dateFormatter.locale = Locale(identifier: "fr")
            let date =  dateFormatter.string(from: self.datePicker.date)
            textField.text = date
        } else if textField == timeOfDepart {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.none
            dateFormatter.timeStyle = DateFormatter.Style.short
            dateFormatter.locale = Locale(identifier: "fr")
            let date =  dateFormatter.string(from: self.timePicker.date)
            textField.text = date
        } else if textField == dateOfDepart {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
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
