

import UIKit

class ContractSuccessVC: UIViewController {
    @IBOutlet weak var imgBtnGradient: UIImageView!
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
    
    @IBAction func actionBtnBackToHome(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
