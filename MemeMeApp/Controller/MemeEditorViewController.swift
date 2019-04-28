import UIKit

class MemeEditorViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    //TODO: Redo to use toolbar programmatically?
    @IBOutlet weak var toolBar: UIToolbar!
    
    let textAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .strokeWidth: -2.0,
        .foregroundColor: UIColor.white,
        // TODO: find the "Impact" Font for the version 2
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
    ]
    
    //TODO: - why do I need in here
    //var memes = [Meme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareImage))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.title = "New Meme"
        
        configureTextfield(topTextField, defaultText: "TOP")
        configureTextfield(bottomTextField, defaultText: "BOTTOM")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
        configureBarButtonItems()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        presentImagePicker(with: .photoLibrary)
    }
    
    @IBAction func getAnImageFromCamera(_ sender: Any) {
        presentImagePicker(with: .camera)
    }
    
    func presentImagePicker(with sourceType: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = sourceType
        present(pickerController, animated: true, completion: nil)
    }
    
    func configureTextfield(_ textfield: UITextField, defaultText: String) {
        textfield.delegate = self
        textfield.defaultTextAttributes = textAttributes
        textfield.textAlignment = .center
        textfield.text = defaultText
    }
    
    func configureBarButtonItems() {
        if imageView.image == nil {
            navigationItem.leftBarButtonItem?.isEnabled = false
            //navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.leftBarButtonItem?.isEnabled = true
            //navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    //MARK: - Keyboard adjustments
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
    
    func saveMeme() {
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: generateMemedImage())
        
        // saving to AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func hideBars(_ isHidden: Bool) {
        navigationController?.isNavigationBarHidden = isHidden
        toolBar.isHidden = isHidden
    }
    
    func generateMemedImage() -> UIImage {
        
        hideBars(true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        imageView.backgroundColor = .white
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        hideBars(false)
        
        return memedImage
    }
    
    @objc func shareImage() {
        
        let defaultText = "Look at this awesome meme!"
        let image = generateMemedImage()
        
        let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: [])
        
        activityController.completionWithItemsHandler = { (_, completed, _, _) in
            if !completed {
                return
            } else {
                self.saveMeme()                
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        // for iPad
        activityController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        self.present(activityController, animated: true, completion: nil)
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension MemeEditorViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

// navigation delegate doesn't have any required methods
extension MemeEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true) {
        }
    }
}
