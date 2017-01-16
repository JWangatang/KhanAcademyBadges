//
//  Category.swift
//  KhanAcademyBadges
//
//  Created by Jonathan Wang on 1/13/17.
//  Copyright © 2017 JonathanWang. All rights reserved.
//

import UIKit

class Category: NSObject {
    var name : String
    var categoryDescription : String
    var imageUrl : String
    
    init (name : String, description : String, url : String) {
        self.name = name
        self.categoryDescription = description
        self.imageUrl = url
    }
}
