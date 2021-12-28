
import UIKit

class StaticsVC: UIViewController {
    @IBOutlet weak var imgYearly: UIImageView!
    @IBOutlet weak var lblCalender: UILabel!
    @IBOutlet weak var lblYearly: UILabel!
    @IBOutlet weak var lblWeekly: UILabel!
    @IBOutlet weak var imgWeekly: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isWeekly = true
    
    let arrWeekName = ["Lu","Ma","Me","Je","Ve","Sa","Di"]
    let arrMonthName = ["Ja","Fe","Ma","Av","Mai","Jun","Juil","Ao","Se","Oc","No","Dé"]
    
    var pickerView = UIPickerView()
    var toolBar = UIToolbar()
    
    var isPickerOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.setNavigationBarImage(for: UIImage(), color: #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1))
        setBackButton(tintColor: #colorLiteral(red: 0.05490196078, green: 0.1411764706, blue: 0.3176470588, alpha: 1), isImage: true, #imageLiteral(resourceName: "back_arrow_blue"))
        
        self.title = "Mon évolution"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 16)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.05490196078, green: 0.1411764706, blue: 0.3176470588, alpha: 1)]
        configPickerView()
    }
    @IBAction func actionOpenPickerView(_ sender: UIControl) {
        self.view.addSubview(pickerView)
        self.view.addSubview(toolBar)
        self.pickerView.reloadAllComponents()
        isPickerOpen = true
    }
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func actionWeekly(_ sender: UIControl) {
        if !isWeekly && isPickerOpen {
            onCancelButtonTapped()
        }
        tabSelected(true)
    }
    
    @IBAction func actionYearly(_ sender: UIControl) {
        if isWeekly && isPickerOpen {
            onCancelButtonTapped()
        }
        tabSelected(false)
    }
    
    func tabSelected(_ isWeeklySelected: Bool) {
        if isWeeklySelected {
            imgWeekly.isHidden = false
            imgYearly.isHidden = true
            lblYearly.textColor = #colorLiteral(red: 0.01568627451, green: 0.137254902, blue: 0.3764705882, alpha: 1)
            lblWeekly.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            isWeekly = true
            let row = self.pickerView.selectedRow(inComponent: 0)
            self.lblCalender.text = isWeekly ? "Semaine \(row + 1) (2020)" : "Année (\(2000 + (row + 1)))"
            
        } else {
            imgWeekly.isHidden = true
            imgYearly.isHidden = false
            lblYearly.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            lblWeekly.textColor = #colorLiteral(red: 0.01568627451, green: 0.137254902, blue: 0.3764705882, alpha: 1)
            isWeekly = false
            let row = self.pickerView.selectedRow(inComponent: 0)
            self.lblCalender.text = isWeekly ? "Semaine \(row + 1) (2020)" : "Année (\(2000 + (row + 1)))"
        }
        collectionView.reloadData()
    }
}

//MARK: Configuration of PickerView
extension StaticsVC {
    //Method for Configuration of PickerView
    @objc func configPickerView() {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.backgroundColor = .white
        self.pickerView.selectRow(3, inComponent: 0, animated: true)
        self.pickerView.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 250, width: UIScreen.main.bounds.size.width, height: 250)
        self.createToolbar()
    }
    
    //Method to create Toolbar
    func createToolbar() {
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 250, width: UIScreen.main.bounds.size.width, height: 44))
        toolBar.barStyle = .default
        let doneButton = UIBarButtonItem(title: "Valider", style: .plain, target: self, action: #selector(didTapDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancelButton = UIBarButtonItem(title: "Annuler", style:.plain, target: self, action: #selector(onCancelButtonTapped))
        toolBar.setItems([cancelButton, space, doneButton], animated: false)
    }
    
    @objc func onCancelButtonTapped() {
        toolBar.removeFromSuperview()
        pickerView.removeFromSuperview()
        isPickerOpen = false
    }
    
    @objc func didTapDone() {
        let row = self.pickerView.selectedRow(inComponent: 0)
        self.lblCalender.text = isWeekly ? "Semaine \(row + 1) (2020)" : "Année (\(2000 + (row + 1)))"
        onCancelButtonTapped()
    }
}
//MARK: UIPickerViewDelegate, UIPickerViewDataSource
extension StaticsVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return isWeekly ? 65 : 20
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return isWeekly ? "Semaine \(row + 1) (2020)" : "Année (\(2000 + (row + 1)))"
    }
}

extension StaticsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isWeekly ? arrWeekName.count : arrMonthName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StaticsCell", for: indexPath) as! StaticsCell
        if isWeekly {
            cell.lblName.text = arrWeekName[indexPath.row]
        } else {
            cell.lblName.text = arrMonthName[indexPath.row]
        }
        return cell
    }
}

extension StaticsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 64, height: self.collectionView.frame.height)
    }
}

extension StaticsVC: UICollectionViewDelegate {
    
}

class StaticsCell: UICollectionViewCell {
    
    @IBOutlet weak var sliceHeight: NSLayoutConstraint!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var lblName: UILabel!
}
