
import UIKit
import PDFKit

class ContractAddSignVC: UIViewController {
    
    @IBOutlet weak var pdfContainer: UIView!
    @IBOutlet weak var viewAcceptTandC: UIControl!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    let pdfView = PDFView()
    
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
        
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfContainer.addSubview(pdfView)
        pdfView.backgroundColor = .clear
        pdfView.autoScales = true
        pdfView.leadingAnchor.constraint(equalTo: pdfContainer.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: pdfContainer.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: pdfContainer.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: pdfContainer.bottomAnchor).isActive = true
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setNavigationBarImage(for: UIImage(), color: #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1))
        self.setBackButton(tintColor: .white, isImage: true)
        self.title = "Conditions particulières"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 16)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)]
        
        guard let path = Bundle.main.url(forResource: "PDF", withExtension: "pdf") else { return }

        if let document = PDFDocument(url: path) {
            pdfView.document = document
        }
    }
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionAcceptTandC(_ sender: UIControl) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let contractSuccessVC = storyboard.instantiateViewController(withIdentifier: "ContractSuccessVC") as! ContractSuccessVC
        self.navigationController?.pushViewController(contractSuccessVC, animated: true)
    }
}
