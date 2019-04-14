import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //var memes = [Meme]()
    var memes: [Meme] = [Meme(topText: "TopText", bottomText: "BottomText", originalImage: UIImage(named: "nssl0045")!, memedImage: UIImage(named: "nssl0045")!)]
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
}

