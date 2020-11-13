import Firebase
import UIKit
import Kingfisher

struct Repo: Codable {
    let data: [Park]
    
    struct Park: Codable {
        let name: String
        let designation: String
        let description: String
        let images: [Image]
        struct Image: Codable {
            let url: URL
        }
    }
}

class NationalParksTableViewController: UITableViewController {

    //database from fire
    var ref: DatabaseReference!
    var docRef: DocumentReference!
    
    
    var parks = [Repo.Park]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        refreshControl = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        tableView.refreshControl = refreshControl
        refreshControl?.addTarget(self, action: #selector(startRefreshing), for: .valueChanged)
        fetchNPSRepos()
        
        //firebase version
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        
        
    }
    

    
    
    
    @objc func startRefreshing() {
        refreshControl?.beginRefreshing()
        fetchNPSRepos()

    }
    
    private func fetchNPSRepos() {
        
        let urlString = "https://developer.nps.gov/api/v1/parks?api_key=qqYgju5RJUXJKc3O2sDdNKcZhichJO7n1B8bBz3K"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let decodedRepos = try? JSONDecoder().decode(Repo.self, from: data) {
                    self.parks = decodedRepos.data
                    self.parks = Array(self.parks[0...29])
                    
                    DispatchQueue.main.async {
                        self.refreshControl?.endRefreshing()
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let park = parks[indexPath.row]
           let cell = tableView.dequeueReusableCell(withIdentifier: "ParkCell", for: indexPath) as! ParkCell
           
           cell.titleLabel?.text = park.name
           cell.subtitleLabel?.text = park.designation
           cell.accessoryType = .disclosureIndicator
           cell.parkImageView?.kf.setImage(with: park.images[0].url)
           return cell
       }
       

        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //performSegue(withIdentifier: "ShowDetailViewController", sender: indexPath)
            
            let detailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            detailController.data = parks[indexPath.row]
            navigationController?.pushViewController(detailController, animated: true)
            
            
//            Firestore.firestore().collection("parks").document("\(indexPath.row)").getDocument{ (docSnapshot, error) in
//                        if let data = docSnapshot?.data() {
//                            self.data = data
//                        }
//                        self.performSegue(withIdentifier: "parkSegue", sender: nil)
//            }
        }
    
       
    
    
       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parks.count
       }
       
       override func numberOfSections(in tableView: UITableView) -> Int {
           return 30
       }
       
       override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100
       }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailViewController" {
            let index = (sender as? IndexPath)?.row ?? 0
            let detailController = segue.destination as! DetailViewController
            detailController.data = parks[index]
        }
    }


}

