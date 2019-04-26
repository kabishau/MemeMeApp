import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //var memes = [Meme]()
    var memes: [Meme] = [
        Meme(topText: "Top1", bottomText: "Bottom1", originalImage: UIImage(named: "But-Thats-None-Of-My-Business")!, memedImage: UIImage(named: "Meme-But-Thats-None-Of-My-Business")!),
        Meme(topText: "Top2", bottomText: "Bottom2", originalImage: UIImage(named: "Chuck-Norris-Guns")!, memedImage: UIImage(named: "Meme-Chuck-Norris-Guns")!),
        Meme(topText: "Top3", bottomText: "Bottom3", originalImage: UIImage(named: "Face-You-Make-Robert-Downey-Jr")!, memedImage: UIImage(named: "Meme-Face-You-Make-Robert-Downey-Jr")!),
        Meme(topText: "Top4", bottomText: "Bottom4", originalImage: UIImage(named: "Leonardo-Dicaprio-Cheers")!, memedImage: UIImage(named: "Meme-Leonardo-Dicaprio-Cheers")!),
        Meme(topText: "Top5", bottomText: "Bottom5", originalImage: UIImage(named: "Skeptical-Baby")!, memedImage: UIImage(named: "Meme-Skeptical-Baby")!),
        Meme(topText: "Top5", bottomText: "Bottom5", originalImage: UIImage(named: "Waiting-Skeleton")!, memedImage: UIImage(named: "Meme-Waiting-Skeleton")!)        
    ]
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
}

