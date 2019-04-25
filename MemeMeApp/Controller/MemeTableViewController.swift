import UIKit

class MemeTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var memes: [Meme] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        title = "Sent Memes"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func addButtonTapped() {
        guard let memeEditorViewController = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as? MemeEditorViewController else {
            return
        }
        navigationController?.pushViewController(memeEditorViewController, animated: true)
        
        //present(memeEditorViewController, animated: true, completion: nil)
    }
}

extension MemeTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = memes[indexPath.row].topText
        cell.imageView?.image = memes[indexPath.row].originalImage
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        detailViewController.memedImage = memes[indexPath.row].memedImage
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
