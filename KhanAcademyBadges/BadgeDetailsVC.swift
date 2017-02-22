//
//  BadgeDetailsVC.swift
//  KhanAcademyBadges
//
//  Created by Jonathan Wang on 1/6/17.
//  Copyright © 2017 JonathanWang. All rights reserved.
//

import UIKit

class BadgeDetailsVC: UIViewController {
    
    var badge : Badge?

    @IBOutlet var categoryButton: UIButton!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(badge != nil) {
            self.titleLabel.text = badge!.name
            self.categoryButton.setTitle("Category: " + self.badge!.category.name, for: .normal)
            self.pointsLabel.text = "Points: " + self.badge!.points.description
            
            let data = try? Data(contentsOf: URL(string: self.badge!.imageUrl)!)
            self.imageView.image = UIImage(data: data!)
            self.descriptionLabel.text =  "Description: " +
                (self.badge?.badgeDescription)!
        } else {
            print("Badge is nil")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func moreInfo(_ sender: Any) {
        UIApplication.shared.open(URL(string: badge!.url)!, options: [:], completionHandler: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "Category") {
            let dest = segue.destination as! CategoryDetailsVC
            dest.category = badge?.category
        }
    }
    

}
