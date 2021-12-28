
import UIKit

class AddContarct2VC: UIViewController {
    
    @IBOutlet weak var tfDateOfPermit: UITextField!
    @IBOutlet weak var secondBorderView: DashedBorderView!
    @IBOutlet weak var firstBorderView: DashedBorderView!
    @IBOutlet weak var imgSecond: UIImageView!
    @IBOutlet weak var imgFirst: UIImageView!
    @IBOutlet weak var viewNextStep: UIControl!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    var selectedView = 0
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.maximumDate = Date()
        picker.locale =  Locale(identifier: "fr")
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        tfDateOfPermit.delegate = self
        self.navigationController?.isNavigationBarHidden = false
        topViewHeight.constant = topDistance + 8
        DispatchQueue.main.async {
            self.navView.roundCorners([.bottomLeft, .bottomRight], radius: 16)
            self.viewNextStep.applyGradient(withColours: [#colorLiteral(red: 0.5019607843, green: 0.7647058824, blue: 0.9529411765, alpha: 1), #colorLiteral(red: 0, green: 0.4274509804, blue: 0.9294117647, alpha: 1)], gradientOrientation: .horizontal)
            self.viewNextStep.cornerRadius = self.viewNextStep.frame.height / 2
        }
    }
    @IBAction func actionSelectImage(_ sender: UIControl) {
        selectedView = sender.tag
        self.showImagePickerView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setNavigationBarImage(for: UIImage(), color: #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1))
        self.setBackButton(tintColor: .white, isImage: true)
        self.title = "Infomations client"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 16)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)]
    }
    
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionNextStep(_ sender: UIControl) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chooseCarVC = storyboard.instantiateViewController(withIdentifier: "ChooseCarVC") as! ChooseCarVC
        self.navigationController?.pushViewController(chooseCarVC, animated: true)
    }
}
//MARK: UIImagePickerController Config
extension AddContarct2VC {
    func openCamera() {
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            Common.showAlertMessage(message: Messages.cameraNotFound, alertType: .warning)
        }
    }
    
    func openGallary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func showImagePickerView() {
        
        let alert = UIAlertController(title: Messages.photoMassage, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title:  Messages.txtCamera, style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: Messages.txtGallery, style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: Messages.txtCancel, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: UIImagePickerControllerDelegate
extension AddContarct2VC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let  pickedImage = info[.editedImage] as? UIImage {
            
            if selectedView == 101 {
                imgFirst.contentMode = .scaleAspectFill
                imgFirst.image = pickedImage
                firstBorderView._border.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            } else if selectedView == 102 {
                imgSecond.contentMode = .scaleAspectFill
                imgSecond.image = pickedImage
                secondBorderView._border.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK: UITextFieldDelegate
extension AddContarct2VC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       if textField == tfDateOfPermit {
             textField.inputView = datePicker
        }
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == tfDateOfPermit {
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
