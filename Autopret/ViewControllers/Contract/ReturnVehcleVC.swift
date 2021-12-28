
import UIKit
import IQKeyboardManagerSwift

class ReturnVehcleVC: UIViewController {
    
    @IBOutlet weak var timeOfReservation: UITextField!
    @IBOutlet weak var dateOfResurvation: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewValidateReturn: UIControl!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    var selectedIndex = 0
    var arrImage = [#imageLiteral(resourceName: "dashed_camera"),#imageLiteral(resourceName: "dashed_camera"),#imageLiteral(resourceName: "dashed_camera"),#imageLiteral(resourceName: "dashed_camera"),#imageLiteral(resourceName: "dashed_camera"),#imageLiteral(resourceName: "dashed_camera"),#imageLiteral(resourceName: "dashed_camera"),#imageLiteral(resourceName: "dashed_camera")]
    var contractDetailsVC: ContractDetailsVC?
    
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
        
        timeOfReservation.delegate = self
        dateOfResurvation.delegate = self
        textView.text = "Commentaires au retour du véhicule"
        textView.textColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        
        self.navigationController?.isNavigationBarHidden = false
        topViewHeight.constant = self.navigationController?.navigationBar.frame.height ?? 0
        DispatchQueue.main.async {
            self.viewValidateReturn.applyGradient(withColours: [#colorLiteral(red: 0.5019607843, green: 0.7647058824, blue: 0.9529411765, alpha: 1), #colorLiteral(red: 0, green: 0.4274509804, blue: 0.9294117647, alpha: 1)], gradientOrientation: .horizontal)
            self.viewValidateReturn.cornerRadius = self.viewValidateReturn.frame.height / 2
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setNavigationBarImage(for: UIImage(), color: #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1))
        self.setBackButton(tintColor: .white, isImage: true)
        self.title = "Restitution du véhicule"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 16)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)]
        IQKeyboardManager.shared.enableAutoToolbar = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        IQKeyboardManager.shared.enableAutoToolbar = false
        self.view.endEditing(true)
    }
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionReturnValidate(_ sender: UIControl) {
        self.dismiss(animated: true) {
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let successReturnVC = storyboard.instantiateViewController(withIdentifier: "SuccessReturnVC") as! SuccessReturnVC
                successReturnVC.contractDetailsVC = self.contractDetailsVC
                guard let getNav =  UIApplication.topViewController()?.navigationController else { return }
                let rootNavView = UINavigationController(rootViewController: successReturnVC)
                rootNavView.modalPresentationStyle = .fullScreen
                getNav.present( rootNavView, animated: true, completion: nil)
            }
        }
    }
}

extension ReturnVehcleVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        if arrImage[indexPath.row] == #imageLiteral(resourceName: "dashed_camera") {
            cell.imageView.contentMode = .center
            cell.borderView._border.strokeColor = #colorLiteral(red: 0.2705882353, green: 0.6470588235, blue: 0.7764705882, alpha: 1)
        } else {
            cell.imageView.contentMode = .scaleAspectFill
            cell.borderView._border.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        }
        cell.imageView.image = arrImage[indexPath.row]
        return cell
    }
    
}
extension ReturnVehcleVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.3, height: collectionView.frame.height)
    }
}
extension ReturnVehcleVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        showImagePickerView()
    }
}

extension ReturnVehcleVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if  textView.text == "Commentaires au retour du véhicule" {
            textView.selectedTextRange = textView.textRange(from: textView.endOfDocument, to: textView.beginningOfDocument)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Commentaires au retour du véhicule"
            textView.textColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        if updatedText.isEmpty {
            
            textView.text = "Commentaires au retour du véhicule"
            textView.textColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
        else if textView.textColor == #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1) && !text.isEmpty {
            textView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            textView.text = text
        }
        else {
            return true
        }
        return false
    }
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1) {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
}

//MARK: UIImagePickerController Config
extension ReturnVehcleVC {
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
extension ReturnVehcleVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let  pickedImage = info[.editedImage] as? UIImage {
            arrImage[selectedIndex] = pickedImage
            collectionView.reloadData()
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK: UITextFieldDelegate
extension ReturnVehcleVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == timeOfReservation {
            textField.inputView = timePicker
        } else if textField == dateOfResurvation {
            textField.inputView = datePicker
        }
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == timeOfReservation {
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
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return view.endEditing(true)
    }
}
