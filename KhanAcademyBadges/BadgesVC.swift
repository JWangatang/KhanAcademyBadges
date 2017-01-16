//
//  BadgesVC.swift
//  KhanAcademyBadges
//
//  Created by Jonathan Wang on 1/6/17.
//  Copyright © 2017 JonathanWang. All rights reserved.
//

import UIKit
import MBProgressHUD

class BadgesVC: UITableViewController, UISearchBarDelegate{
    
    @IBOutlet var searchBar: UISearchBar!
    
   // var badgeModel: BadgeModel!
    var badges = [Badge] ()
    var categories = [Category] ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getCategories()
        
        
        self.searchBar.delegate = self
        
//        self.badgeModel = BadgeModel.sharedInstance
//        print (badgeModel.badges.count)
//        print(badgeModel.categories.count)
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCategories () {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let categoriesUrl = NSURL (string: "https://www.khanacademy.org/api/v1/badges/categories")
        
        //Get Categories
        let request = NSURLRequest(
            url: categoriesUrl as! URL,
            cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )
        
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest, completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let array = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSArray{
                    for i in 0...array.count-1 {
                        let dict = array[i] as! [String : Any]
                        let newCategory = Category (name: dict["type_label"] as! String, description: dict["description"] as! String, url: dict["large_icon_src"] as! String)
                        self.categories.append(newCategory)
                    }
                    
                    self.getBadges()
                    
                }
            } else {
                print (error.debugDescription)
            }
        })
        task.resume()
        
    }
    
    func getBadges () {
        let badgesUrl = NSURL (string: "https://www.khanacademy.org/api/v1/badges")
        
        let request = NSURLRequest(
            url: badgesUrl as! URL,
            cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )
        
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest, completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let array = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSArray{
                    for i in 0...array.count-1 {
                        let dict = array[i] as! [String : Any]
                        let badge = Badge (name: dict["description"] as! String, description: dict["safe_extended_description"] as! String, points: dict["points"] as! Int, category: self.categories[dict["badge_category"] as! Int], url: dict["absolute_url"] as! String, imageUrl: (dict["icons"] as! NSDictionary)["email"] as! String)
                        self.badges.append(badge)
                    }
                    self.tableView.reloadData()
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            } else {
                print (error.debugDescription)
            }
        })
        task.resume()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.badges.count
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //start searching
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Badge Cell") as! BadgeCell

        cell.nameLabel.text = self.badges[indexPath.row].name
        let data = try? Data(contentsOf: URL(string: self.badges[indexPath.row].imageUrl)!)
        
        cell.icon.image = UIImage (data: data!)
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "Badge Details") {
            let dest = segue.destination as! BadgeDetailsVC
            dest.badge = self.badges[(self.tableView.indexPathForSelectedRow?.row)!]
        }
    }
    

}
