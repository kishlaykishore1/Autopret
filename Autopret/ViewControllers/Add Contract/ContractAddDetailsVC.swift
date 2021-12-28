
import UIKit

class ContractAddDetailsVC: UIViewController {
    
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var heightOfHiddenView: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imgProfessional: UIImageView!
    @IBOutlet weak var lblProfessional: UILabel!
    @IBOutlet weak var lblStuff: UILabel!
    @IBOutlet weak var imgStuff: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewNextStep: UIControl!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    var selectedIndex = 0
    var arrImage = [#imageLiteral(resourceName: "dashed_camera"),#imageLiteral(resourceName: "dashed_camera"),#imageLiteral(resourceName: "dashed_camera"),#imageLiteral(resourceName: "dashed_camera"),#imageLiteral(resourceName: "dashed_camera"),#imageLiteral(resourceName: "dashed_camera"),#imageLiteral(resourceName: "dashed_camera"),#imageLiteral(resourceName: "dashed_camera")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        textView.text = "Commentaires et équipement(s)"
        textView.textColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        heightOfHiddenView.constant =  0.0
         hiddenView.isHidden = true
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
        self.title = "État voiture"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 16)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)]
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        heightOfHiddenView.constant = sender.isOn ? 108.0 : 0.0
        hiddenView.isHidden = !sender.isOn
    }
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionNextStep(_ sender: UIControl) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let contractAddDetails2VC = storyboard.instantiateViewController(withIdentifier: "ContractAddDetails2VC") as! ContractAddDetails2VC
        self.navigationController?.pushViewController(contractAddDetails2VC, animated: true)
    }
    
    
    @IBAction func actionStuff(_ sender: UIControl) {
        tabSelected(true)
    }
    
    @IBAction func actionProfessional(_ sender: UIControl) {
        tabSelected(false)
    }
    
    func tabSelected(_ isStuffSelected: Bool) {
        if isStuffSelected {
            imgStuff.isHidden = false
            imgProfessional.isHidden = true
            lblProfessional.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            lblStuff.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        } else {
            imgStuff.isHidden = true
            imgProfessional.isHidden = false
            lblProfessional.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            lblStuff.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
}

extension ContractAddDetailsVC: UICollectionViewDataSource {
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
extension ContractAddDetailsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.3, height: collectionView.frame.height)
    }
}
extension ContractAddDetailsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        showImagePickerView()
    }
}

extension ContractAddDetailsVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if  textView.text == "Commentaires et équipement(s)" {
            textView.selectedTextRange = textView.textRange(from: textView.endOfDocument, to: textView.beginningOfDocument)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Commentaires et équipement(s)"
            textView.textColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        if updatedText.isEmpty {
            
            textView.text = "Commentaires et équipement(s)"
            textView.textColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        } else if textView.textColor == #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1) && !text.isEmpty {
            textView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            textView.text = text
        } else {
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
extension ContractAddDetailsVC {
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
extension ContractAddDetailsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let  pickedImage = info[.editedImage] as? UIImage {
            arrImage[selectedIndex] = pickedImage
            collectionView.reloadData()
        }
        picker.dismiss(animated: true, completion: nil)
    }
}


class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var borderView: DashedBorderView!
    @IBOutlet weak var imageView: UIImageView!
}
