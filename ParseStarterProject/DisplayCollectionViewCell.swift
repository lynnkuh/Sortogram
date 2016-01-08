//
//  DisplayCollectionViewCell.swift
//  Sortogram
//
//  Created by Regular User on 11/4/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class DisplayCollectionViewCell: UICollectionViewCell {
    
        
    @IBOutlet weak var imageView: UIImageView!
    
        
        var status: Status? {
            didSet {
                if let status = self.status {
                    self.imageView.image = status.image
                }
            }
        }
        
        class func identifier() -> String {
            return "DisplayCollectionViewCell"
        }
        
    }

