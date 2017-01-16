//
//  CategoryDetailsVC.swift
//  KhanAcademyBadges
//
//  Created by Jonathan Wang on 1/15/17.
//  Copyright © 2017 JonathanWang. All rights reserved.
//

import UIKit

class CategoryDetailsVC: UIViewController {
    
    var category : Category?

    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(category != nil) {
            self.descriptionLabel.text = category!.categoryDescription
            self.titleLabel.text = category!.name
            let data = try? Data(contentsOf: URL(string: self.category!.imageUrl)!)
            self.imageView.image = UIImage(data: data!)
            
        } else {
            print ("Category is nil")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
