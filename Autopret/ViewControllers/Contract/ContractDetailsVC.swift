
import UIKit
import IQKeyboardManagerSwift

class ContractDetailsVC: UIViewController {
    
    @IBOutlet weak var vehcleSoldView: UIView!
    @IBOutlet weak var viewMarkAsSold: UIControl!
    @IBOutlet weak var viewBackImg: UIImageView!
    @IBOutlet weak var returnCollectionView: UICollectionView!
    @IBOutlet weak var returnView: UIView!
    @IBOutlet weak var returnViewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewReturnMark: UIControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewSeeAllContract: UIControl!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        self.navigationController?.isNavigationBarHidden = false
        topViewHeight.constant = self.navigationController?.navigationBar.frame.height ?? 0
        DispatchQueue.main.async {
            self.viewSeeAllContract.applyGradient(withColours: [#colorLiteral(red: 0.5019607843, green: 0.7647058824, blue: 0.9529411765, alpha: 1), #colorLiteral(red: 0, green: 0.4274509804, blue: 0.9294117647, alpha: 1)], gradientOrientation: .horizontal)
            self.viewSeeAllContract.cornerRadius = self.viewSeeAllContract.frame.height / 2
            
            self.viewReturnMark.applyGradient(withColours: [#colorLiteral(red: 0.5019607843, green: 0.7647058824, blue: 0.9529411765, alpha: 1), #colorLiteral(red: 0, green: 0.4274509804, blue: 0.9294117647, alpha: 1)], gradientOrientation: .horizontal)
            self.viewReturnMark.cornerRadius = self.viewReturnMark.frame.height / 2
            self.viewBackImg.cornerRadius = self.viewBackImg.frame.height / 2
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setNavigationBarImage(for: UIImage(), color: #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1))
        self.setBackButton(tintColor: .white, isImage: true)
        self.setRightButton(tintColor: #colorLiteral(red: 0.4398949444, green: 0.4830535054, blue: 0.5647997856, alpha: 1), isImage: true, image: #imageLiteral(resourceName: "more"))
        self.title = "Prêt #34FR34F"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 16)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)]
        
        returnViewHeight.constant = 0
        returnView.isHidden = true
        vehcleSoldView.isHidden = true
        viewMarkAsSold.isHidden = true
        IQKeyboardManager.shared.enableAutoToolbar = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        IQKeyboardManager.shared.enableAutoToolbar = false
        self.view.endEditing(true)
    }
    
    override func rightBtnTapAction(sender: UIButton) {
        let alert  = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let edit = UIAlertAction(title: "Modifier le contrat", style: .default, handler: { _ in
            
            let alert  = UIAlertController(title: "Avertissement !", message: "\nÊtes-vous certain de vouloir\nmodifier ce contrat ? Le client doit être\nprésent pour signer les nouvelles conditions du contrat.", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "Modifier", style: .default, handler: { _ in
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let addContarctVC = storyboard.instantiateViewController(withIdentifier: "AddContarctVC") as! AddContarctVC
                    addContarctVC.isPresent = true
                    guard let getNav =  UIApplication.topViewController()?.navigationController else { return }
                    let rootNavView = UINavigationController(rootViewController: addContarctVC)
                    rootNavView.modalPresentationStyle = .fullScreen
                    getNav.present( rootNavView, animated: true, completion: nil)
                }
            })
            alert.addAction(UIAlertAction(title: "Annuler", style: .default, handler: nil))
            alert.addAction(confirm)
            alert.preferredAction = confirm
            
            self.present(alert, animated: true, completion: nil)
        })
        
        let delete = UIAlertAction(title: "Supprimer le contrat", style: .destructive, handler: { _ in
            let alert  = UIAlertController(title: "Avertissement !", message: "\nÊtes-vous certain de vouloir\nsupprimer ce contrat ? Le client sera prévenu pas email.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Supprimer", style: .destructive, handler: { _ in
            }))
            alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
        
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        alert.addAction(edit)
        alert.addAction(delete)
        alert.preferredAction = delete
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func actionSeeContract(_ sender: UIControl) {
    }
    @IBAction func actionReturnMark(_ sender: UIControl) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let returnVehcleVC = storyboard.instantiateViewController(withIdentifier: "ReturnVehcleVC") as! ReturnVehcleVC
            returnVehcleVC.contractDetailsVC = self
            guard let getNav =  UIApplication.topViewController()?.navigationController else {
                return
            }
            let rootNavView = UINavigationController(rootViewController: returnVehcleVC)
            getNav.present( rootNavView, animated: true, completion: nil)
        }
    }
    @IBAction func actionMarkAsSold(_ sender: UIControl) {
        vehcleSoldView.isHidden = false
        viewMarkAsSold.isHidden = true
    }
    override func backBtnTapAction() {
        
        if returnView.isHidden {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
}
extension ContractDetailsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "Image2Cell", for: indexPath) as! Image2Cell
    }
    
}
extension ContractDetailsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.3, height: collectionView.frame.height)
    }
}
extension ContractDetailsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let returnVehcleVC = storyboard.instantiateViewController(withIdentifier: "GalleryImageVC") as! GalleryImageVC
        guard let getNav =  UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: returnVehcleVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
}

class Image2Cell: UICollectionViewCell {
    
}
