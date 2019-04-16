import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //var memes = [Meme]()
    var memes: [Meme] = [
        Meme(topText: "", bottomText: "", originalImage: UIImage(named: "meme1")!, memedImage: UIImage(named: "meme1")!),
        Meme(topText: "", bottomText: "", originalImage: UIImage(named: "meme2")!, memedImage: UIImage(named: "meme2")!),
        Meme(topText: "", bottomText: "", originalImage: UIImage(named: "meme3")!, memedImage: UIImage(named: "meme3")!),
        Meme(topText: "", bottomText: "", originalImage: UIImage(named: "meme4")!, memedImage: UIImage(named: "meme4")!),
        Meme(topText: "", bottomText: "", originalImage: UIImage(named: "meme5")!, memedImage: UIImage(named: "meme5")!)]
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
}

