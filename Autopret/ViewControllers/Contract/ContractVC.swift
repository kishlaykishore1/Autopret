
import UIKit
import IQKeyboardManagerSwift

class ContractVC: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imgRestored: UIImageView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var lblRestored: UILabel!
    @IBOutlet weak var lblInProgress: UILabel!
    @IBOutlet weak var imgProgress: UIImageView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var isProgress = true
    var homeVC: HomeVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Annuler"
        tableView.tableFooterView = UIView()
        dataView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchBar.delegate = self
        searchBar.searchTextField.autocapitalizationType = .none
        self.navigationController?.isNavigationBarHidden = false
        self.setNavigationBarImage(for: UIImage(), color: #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1))
        setBackButton(tintColor: #colorLiteral(red: 0.05490196078, green: 0.1411764706, blue: 0.3176470588, alpha: 1), isImage: true, #imageLiteral(resourceName: "back_arrow_blue"))
        setRightButton(tintColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), isImage: true, image: #imageLiteral(resourceName: "add-plus-button"))
        self.title = "Mes prêts"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 16)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.05490196078, green: 0.1411764706, blue: 0.3176470588, alpha: 1)]
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        IQKeyboardManager.shared.enableAutoToolbar = true
        self.view.endEditing(true)
    }
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    override func rightBtnTapAction(sender: UIButton) {
        self.dismiss(animated: true) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let addContarctVC = storyboard.instantiateViewController(withIdentifier: "AddContarctVC") as! AddContarctVC
            self.homeVC?.navigationController?.pushViewController(addContarctVC, animated: true)
        }
    }
    
    @IBAction func actionInProgress(_ sender: UIControl) {
        tabSelected(true)
    }
    
    @IBAction func actionRestored(_ sender: UIControl) {
        tabSelected(false)
    }
    
    func tabSelected(_ isProgressSelected: Bool) {
        dataView.isHidden = false
        if isProgressSelected {
            imgProgress.isHidden = false
            imgRestored.isHidden = true
            lblRestored.textColor = #colorLiteral(red: 0.01568627451, green: 0.137254902, blue: 0.3764705882, alpha: 1)
            lblInProgress.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            isProgress = true
        } else {
            imgProgress.isHidden = true
            imgRestored.isHidden = false
            lblRestored.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            lblInProgress.textColor = #colorLiteral(red: 0.01568627451, green: 0.137254902, blue: 0.3764705882, alpha: 1)
            isProgress = false
        }
        tableView.reloadData()
    }
    
    @IBAction func actionAddClient(_ sender: UIControl) {
        self.dismiss(animated: true) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let addContarctVC = storyboard.instantiateViewController(withIdentifier: "AddContarctVC") as! AddContarctVC
            self.homeVC?.navigationController?.pushViewController(addContarctVC, animated: true)
        }
    }
}

extension ContractVC: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.searchBar.setShowsCancelButton(true, animated: true)
        return true
        
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(false, animated: true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}

extension ContractVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoanCell", for: indexPath) as! LoanCell
        if indexPath.row == 0 && !isProgress {
            cell.SoldView.isHidden = false
        } else {
            cell.SoldView.isHidden = true
        }
        return cell
    }
}

extension ContractVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let contractDetailsVC = storyboard.instantiateViewController(withIdentifier: "ContractDetailsVC") as! ContractDetailsVC
            guard let getNav =  UIApplication.topViewController()?.navigationController else {
                return
            }
            let rootNavView = UINavigationController(rootViewController: contractDetailsVC)
            getNav.present( rootNavView, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

class LoanCell: UITableViewCell {
    @IBOutlet weak var SoldView: UIView!
    
}
