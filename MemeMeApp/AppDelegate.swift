import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var memes: [Meme] = [
        Meme(topText: "THAT KIDS GETTING HARRASED", bottomText: "BUT THAT'S NONE OF MY BUSINESS", originalImage: UIImage(named: "But-Thats-None-Of-My-Business")!, memedImage: UIImage(named: "Meme-But-Thats-None-Of-My-Business")!),
        Meme(topText: "I ONCE SHOT 11 OUT OF 10", bottomText: "TARGETS WITH 9 BULLETS", originalImage: UIImage(named: "Chuck-Norris-Guns")!, memedImage: UIImage(named: "Meme-Chuck-Norris-Guns")!),
        Meme(topText: "WHEN YOU SEE A 30 SECOND YOUTUBE AD", bottomText: "WITHOUT SKIP BUTTON", originalImage: UIImage(named: "Face-You-Make-Robert-Downey-Jr")!, memedImage: UIImage(named: "Meme-Face-You-Make-Robert-Downey-Jr")!),
        Meme(topText: "HEY YOU", bottomText: "WANNA GO TO MCDONALDS?", originalImage: UIImage(named: "Leonardo-Dicaprio-Cheers")!, memedImage: UIImage(named: "Meme-Leonardo-Dicaprio-Cheers")!),
        Meme(topText: "OHHH", bottomText: "SO YOU THINK I DON'T SEE YOU EH?", originalImage: UIImage(named: "Skeptical-Baby")!, memedImage: UIImage(named: "Meme-Skeptical-Baby")!),
        Meme(topText: "WHEN YOUR MOM", bottomText: "FORGOT TO PICK YOU UP", originalImage: UIImage(named: "Waiting-Skeleton")!, memedImage: UIImage(named: "Meme-Waiting-Skeleton")!)        
    ]
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
}

