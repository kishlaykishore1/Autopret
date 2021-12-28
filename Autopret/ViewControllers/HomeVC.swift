
import UIKit

class HomeVC: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var viewNewLoan: UIView!
    @IBOutlet weak var viewMyLoans: UIView!
    @IBOutlet weak var viewMyEvolution: UIView!
    @IBOutlet weak var viewMyAccount: UIView!
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.viewNewLoan.applyGradient(withColours: [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),#colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)], gradientOrientation: .vertical)
            self.viewMyLoans.applyGradient(withColours: [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),#colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)], gradientOrientation: .vertical)
            self.viewMyEvolution.applyGradient(withColours: [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),#colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)], gradientOrientation: .vertical)
            self.viewMyAccount.applyGradient(withColours: [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),#colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)], gradientOrientation: .vertical)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        DispatchQueue.main.async {
            self.setNavigationBarImage(for: UIImage(), color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
            self.navigationController?.navigationBar.barStyle = .black
        }
    }
    @IBAction func actionBtnAbout(_ sender: UIControl) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let aboutVC = storyboard.instantiateViewController(withIdentifier: "AboutVC") as! AboutVC
        guard let getNav =  UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
}

//MARK:- Acttions on Views
extension HomeVC {
    @IBAction func actionOnViews(_ sender: UIView) {
        print(sender.tag)
        switch sender.tag {
        case 101:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let addContarctVC = storyboard.instantiateViewController(withIdentifier: "AddContarctVC") as! AddContarctVC
            self.navigationController?.pushViewController(addContarctVC, animated: true)
            
            break
        case 102:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let contractVC = storyboard.instantiateViewController(withIdentifier: "ContractVC") as! ContractVC
            contractVC.homeVC = self
            guard let getNav =  UIApplication.topViewController()?.navigationController else {
                return
            }
            let rootNavView = UINavigationController(rootViewController: contractVC)
            getNav.present(rootNavView, animated: true, completion: nil)
            break
        case 103:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let staticsVC = storyboard.instantiateViewController(withIdentifier: "StaticsVC") as! StaticsVC
            guard let getNav =  UIApplication.topViewController()?.navigationController else {
                return
            }
            let rootNavView = UINavigationController(rootViewController: staticsVC)
            getNav.present(rootNavView, animated: true, completion: nil)
            break
        case 104:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let myAccountVC = storyboard.instantiateViewController(withIdentifier: "MyAccountVC") as! MyAccountVC
            guard let getNav =  UIApplication.topViewController()?.navigationController else {
                return
            }
            let rootNavView = UINavigationController(rootViewController: myAccountVC)
            getNav.present( rootNavView, animated: true, completion: nil)
            break
        default:
            break
        }
    }
}
