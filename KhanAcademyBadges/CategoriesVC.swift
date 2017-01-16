//
//  CategoriesVC.swift
//  KhanAcademyBadges
//
//  Created by Jonathan Wang on 1/6/17.
//  Copyright © 2017 JonathanWang. All rights reserved.
//

import UIKit
import MBProgressHUD

private let reuseIdentifier = "Category Cell"

class CategoriesVC: UICollectionViewController {
    
    var categories = [Category] ()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCategories()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        
        // Do any additional setup after loading the view.
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
                    self.collectionView?.reloadData()

                    MBProgressHUD.hide(for: self.view, animated: true)

                }
            } else {
                print (error.debugDescription)
            }
        })
        task.resume()
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if (segue.identifier == "Category Details") {
            let dest = segue.destination as! CategoryDetailsVC
            dest.category = categories[(self.collectionView?.indexPath(for: sender as! CategoryCell)?.row)!]
        }
        
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCell
        
        // Configure the cell
        
        cell.nameLabel.text = categories[indexPath.row].name
        let data = try? Data(contentsOf: URL(string: self.categories[indexPath.row].imageUrl)!)

        cell.imageView.image = UIImage (data: data!)

    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
