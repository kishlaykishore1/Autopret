
import UIKit

class SuccessReturnVC: UIViewController {
    @IBOutlet weak var imgBtnGradient: UIImageView!
    var contractDetailsVC: ContractDetailsVC?
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton(tintColor: .clear, isImage: true)
        DispatchQueue.main.async {
            self.imgBtnGradient.cornerRadius = self.imgBtnGradient.frame.height / 2
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        DispatchQueue.main.async {
            self.setNavigationBarImage(for: UIImage(), color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
            self.navigationController?.navigationBar.barStyle = .black
        }
    }
    @IBAction func actionSeeContract(_ sender: UIControl) {
    }
    
    @IBAction func actionReturnDetails(_ sender: UIControl) {
        self.dismiss(animated: true) {
            self.contractDetailsVC?.returnViewHeight.constant = 369.0
            self.contractDetailsVC?.returnView.isHidden = false
            self.contractDetailsVC?.viewMarkAsSold.isHidden = false
            self.contractDetailsVC?.viewReturnMark.isHidden = true
            
            DispatchQueue.main.async {
                self.contractDetailsVC?.viewBackImg.cornerRadius = (self.contractDetailsVC?.viewBackImg.frame.height)! / 2
            }
        }
    }
}
