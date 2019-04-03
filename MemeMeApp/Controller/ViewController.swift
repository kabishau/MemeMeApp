import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    // is there any other convenient way to customize the text in text field?
    // need to play with this in order to make it perfect
    let textAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .strokeWidth: 3.0,
        .foregroundColor: UIColor.white,
        // TODO: find the "Impact" Font - requirements
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
    ]
    
    var memes = [Meme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // these items should be disabled until it makes sense to become active
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareImage))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(clearImage))
        navigationItem.title = "MemeMe"
        
        
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        
        // TODO: make it all CAPS
        topTextField.text = "TOP"
        topTextField.defaultTextAttributes = textAttributes
        topTextField.textAlignment = .center
        topTextField.layer.backgroundColor = UIColor.clear.cgColor
        //topTextField.borderStyle = .none
        
        bottomTextField.text = "BOTTOM"
        bottomTextField.defaultTextAttributes = textAttributes
        bottomTextField.textAlignment = .center
    }
    
    func setNavigationBar() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    
    //TODO: - Make it correct
    func configureBarButtonItems() {
        if imageView.image == nil {
            navigationItem.leftBarButtonItem?.isEnabled = false
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    //MARK: - Keyboard adjustments
    // how does that guy handle this. I think I need deeper understanding of notifications
    // how not to move view when user taps the top text field???
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isEditing {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    //MARK: Saving Meme
    
    func save() {
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: generateMemedImage())
        memes.append(meme)
        
    }
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        
        return memedImage
    }
    
    @objc func shareImage() {
        // need to check for image to share
        let defaultText = "Look at this awesome meme"
        let image = generateMemedImage()
        
        let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: [])
        
        activityController.completionWithItemsHandler = { (actionType, completed, returnedItems, activityError) in
            if !completed {
                return
                
            } else {
                self.save()
                print(self.memes)
            }
        }
        
        // without this code iPad crashes - needs to be tested
        //activityController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        self.present(activityController, animated: true, completion: nil)
    }
    
    @objc func clearImage() {
        self.imageView.image = nil
        bottomTextField.text = "BOTTOM"
        topTextField.text = "TOP"
        
    }
    
}

// add shared button with activity view that allow sharing +/-
// enable shared button until meme is finished (check imageView has image)

//generate a memed image
//define an instance of the ActivityViewController
//pass the ActivityViewController a memedImage as an activity item
//present the ActivityViewController
//call save meme method in completionHandler of ActivityVC
//dismiss Activity View?
//allow to save image in galery in plist


extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

// navigation delegate doesn't have any required methods
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        
        dismiss(animated: true, completion: { print("picked") })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true) {
        }
    }
}
