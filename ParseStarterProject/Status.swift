//
//  Status.swift
//  Sortogram
//
//  Created by Regular User on 11/3/15.
//  Copyright © 2015 Parse. All rights reserved.
//


// Collect the statuses posted on Sortogram (Like Facebook status posts)

import Foundation
import UIKit

class Status {
    var image:UIImage
    var thumbnail:UIImage?
    var status:String
    
    init(image:UIImage, status:String, thumbnail:UIImage?){
        self.image = image
        self.status = status
        self.thumbnail = thumbnail
    }
}