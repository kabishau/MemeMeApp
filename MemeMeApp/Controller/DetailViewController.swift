import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var memedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = memedImage {
            imageView.image = image
        }
    }
}
