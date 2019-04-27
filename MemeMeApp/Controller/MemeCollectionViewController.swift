import UIKit

class MemeCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    //TODO: is this a best practice?
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        title = "Sent Memes"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    @objc func addButtonTapped() {
        guard let memeEditorViewController = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as? MemeEditorViewController else {
            return
        }
        let navigationContoller = UINavigationController(rootViewController: memeEditorViewController)
        present(navigationContoller, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //TODO: not efficient to reload
        collectionView.reloadData()
        
        tabBarController?.tabBar.isHidden = false
    }
    
}

extension MemeCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.imageView.image = memes[indexPath.item].memedImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        detailViewController.memedImage = memes[indexPath.item].memedImage
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
