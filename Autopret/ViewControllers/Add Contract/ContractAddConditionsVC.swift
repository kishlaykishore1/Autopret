
import UIKit

class ContractAddConditionsVC: UIViewController {
    
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var viewAcceptTandC: UIControl!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        self.navigationController?.isNavigationBarHidden = false
        topViewHeight.constant = topDistance + 8
        DispatchQueue.main.async {
            self.navView.roundCorners([.bottomLeft, .bottomRight], radius: 16)
            self.viewAcceptTandC.applyGradient(withColours: [#colorLiteral(red: 0.5019607843, green: 0.7647058824, blue: 0.9529411765, alpha: 1), #colorLiteral(red: 0, green: 0.4274509804, blue: 0.9294117647, alpha: 1)], gradientOrientation: .horizontal)
            self.viewAcceptTandC.cornerRadius = self.viewAcceptTandC.frame.height / 2
        }
        setString()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setNavigationBarImage(for: UIImage(), color: #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1))
        self.setBackButton(tintColor: .white, isImage: true)
        self.title = "Conditions particulières"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 16)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)]
    }
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionAcceptTandC(_ sender: UIControl) {
        let alert  = UIAlertController(title: "Avertissement !", message: "\nL’Emprunteur confirme avoir lu et accepté les conditions du prêt ci-avant.", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirmer", style: .default, handler: { _ in
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let contractAddSignVC = storyboard.instantiateViewController(withIdentifier: "ContractAddSignVC") as! ContractAddSignVC
            
            self.navigationController?.pushViewController(contractAddSignVC, animated: true)
        })
        alert.addAction(confirmAction)
        alert.preferredAction = confirmAction
        alert.addAction(UIAlertAction(title: "Lire les conditions", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
extension ContractAddConditionsVC {
    func setString() {
        let myString = "Le prêt du véhicule est consentit et accepté par l’Empreunteur aux conditions suivantes :\nL’Emprunteur s’engage à veiller, en bon père de famille (article 1880 du Code Civil), à la garde et à la conservation de véhicule prêté, lequel demeure la propriété exclusive et absolue du Prêteur. "
        let myString1 = "Notamment, l’Emprunteur s’engage :\n- À entretenir le véhicule à ses frais (entretien courant) et à prendre en charge toute réparation pendant la période de prêt ci-dessus consentie, y compris les frais de crevaison. À ne pas modifier, altérer ou transformer, en tout ou partie, le véhicule prêté ;\n- À ne pas prêter ce véhicule à une tierce personne sans l’accord du Prêteur. Dans tous les cas, ce véhicule sera conduit par une personne possédant un permis de conduire en cours de validité ;\n-  À faire vérifier, à intervalles réguliers, le niveau d’huile moteur et autres lubrifiants, le niveau du liquide de refroidissement, le cas échéant, et de la pression des pneumatiques ;\n- À signifier au Prêteur toute anomalie, vol ou accident affectant le véhicule prêté dans un délais de 48h suivant la découvert de l’anomalie ou du sinistre. Notamment, en cas de vol du véhicule ou de toute effraction, l’Emprunteur s’engage à faire une déclaration dans les 48h heures auprès de l’autorité de Police compétente suivant la découverte du sinistre. L’Emprunteur restera responsable civilement et pénalement dudit véhicule et de toute infraction dans laquelle le véhicule prêté sera impliqué, en France comme à l’étranger. L’Emprunteur en supportera les conséquences tant juridiques de financières et s’engage à régler les contraventions ainsi que les dommages causés aux victimes des ses infractions ;\n- A ne pas fumer et à restituer le véhicule complet et dans un état de propreté satisfaisant à la date de fin du prêt ci-dessus établie (à default, inscrire la date de restitution effective du véhicule), avec le niveau de carburant initial, à ses frais."
        
        let myAttribute: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 13) as Any]
        let myAttribute1: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 13) as Any]
        
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
        
        let myAttrString1 = NSAttributedString(string: myString1, attributes: myAttribute1)
        
        let finalAttr = NSMutableAttributedString()
        finalAttr.append(myAttrString)
        finalAttr.append(myAttrString1)
        
        lblText.attributedText = finalAttr
    }
}
