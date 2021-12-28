
import UIKit

class GalleryImageVC: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var zoomImageView: UIImageView!
    
    //MARK: Properties
    var imgStr = ""
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackButton(tintColor: #colorLiteral(red: 0.05490196078, green: 0.1411764706, blue: 0.3176470588, alpha: 1), isImage: true, #imageLiteral(resourceName: "back_arrow_blue"))
        self.navigationController?.isNavigationBarHidden = false
        configureNavigationBar()
    }
    
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func scaleImage(_ sender: UIPinchGestureRecognizer) {
        zoomImageView.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
    }
    
    func configureNavigationBar() {
        self.setNavigationBarImage(for: UIImage(), color: .clear)
    }
    
}
