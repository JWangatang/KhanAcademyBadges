//
//  Badge.swift
//  KhanAcademyBadges
//
//  Created by Jonathan Wang on 1/13/17.
//  Copyright © 2017 JonathanWang. All rights reserved.
//

import UIKit

class Badge: NSObject {
    
    var name : String
    var badgeDescription : String
    var points : Int
    var url : String
    var imageUrl : String
    var category : Category
    //var image : UIImage

    init (name : String, description : String, points : Int, category : Category, url : String, imageUrl : String) {
        self.name = name
        self.badgeDescription = description
        self.points = points
        self.category = category
        self.url = url
        self.imageUrl = imageUrl
//        let data = try? Data(contentsOf: URL(string: self.imageUrl)!)
//        self.image = UIImage (data : data!)!
    }

}
