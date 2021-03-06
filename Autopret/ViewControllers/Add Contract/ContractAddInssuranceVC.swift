
import UIKit

class ContractAddInssuranceVC: UIViewController {
    
    @IBOutlet weak var seconSwitch: UISwitch!
    @IBOutlet weak var firstSwitch: UISwitch!
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var viewNextStep: UIControl!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        self.navigationController?.isNavigationBarHidden = false
        topViewHeight.constant = topDistance + 8
        DispatchQueue.main.async {
            self.navView.roundCorners([.bottomLeft, .bottomRight], radius: 16)
            self.viewNextStep.applyGradient(withColours: [#colorLiteral(red: 0.5019607843, green: 0.7647058824, blue: 0.9529411765, alpha: 1), #colorLiteral(red: 0, green: 0.4274509804, blue: 0.9294117647, alpha: 1)], gradientOrientation: .horizontal)
            self.viewNextStep.cornerRadius = self.viewNextStep.frame.height / 2
        }
        setString()
        setString1()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setNavigationBarImage(for: UIImage(), color: #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1))
        self.setBackButton(tintColor: .white, isImage: true)
        self.title = "Assurance"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 16)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)]
    }
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionNextStep(_ sender: UIControl) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let contractAddConditionsVC = storyboard.instantiateViewController(withIdentifier: "ContractAddConditionsVC") as! ContractAddConditionsVC
        self.navigationController?.pushViewController(contractAddConditionsVC, animated: true)
    }
    
    @IBAction func actionFirstSwitch(_ sender: UISwitch) {
        seconSwitch.isOn = !sender.isOn
    }
    
    @IBAction func actionSecondSwitch(_ sender: UISwitch) {
        firstSwitch.isOn = !sender.isOn
    }
}

extension ContractAddInssuranceVC {
    func setString() {
        let myString = "Tout dommage caus?? au v??hicule sera pris en charge pas l???assurance du Pr??teur. "
        let myString1 = "En cas de faute de l???Emprunteur ou de vol du v??hicule, la franchise de [XXX] euros restera ?? la charge de l???Emprunteur qui s???oblige ?? la rembourser. Les effets personnels de l???Emprunteur ne sont pas pris en charge, quel que soient les dommages subis par le v??hicule."
        
        let myAttribute: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Poppins-SemiBold", size: 12) as Any]
        let myAttribute1: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 12) as Any]
        
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
        
        let myAttrString1 = NSAttributedString(string: myString1, attributes: myAttribute1)
        
        let finalAttr = NSMutableAttributedString()
        finalAttr.append(myAttrString)
        finalAttr.append(myAttrString1)
        
        lblFirst.attributedText = finalAttr
    }
    
    func setString1() {
        let myString = "L???Emprunteur s???engage ?? assurer la prise en charge du v??hicule par son assurance personnelle"
        let myString1 = " au titre des d??gration, vol, accident, bris de glace, incendie et autres ??v??nements dommageables suseptible d???affecter ledit v??hicule pendant toute la dur??e du pr??sent contrat de pr??t ?? usage."
        
        let myAttribute: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Poppins-SemiBold", size: 12) as Any]
        let myAttribute1: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 12) as Any]
        
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
        
        let myAttrString1 = NSAttributedString(string: myString1, attributes: myAttribute1)
        
        let finalAttr = NSMutableAttributedString()
        finalAttr.append(myAttrString)
        finalAttr.append(myAttrString1)
        
        lblSecond.attributedText = finalAttr
    }
}
