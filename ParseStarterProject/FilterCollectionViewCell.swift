//
//  FilterCollectionViewCell.swift
//  Sortogram
//
//  Created by Regular User on 1/7/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
   
        
        var image: UIImage? {
            didSet {
                if let image = image {
                    self.filteredImage.image = image
                }
            }
        }
        
        
        class func identifier() -> String {
            return "FilteredCollectionViewCell"
        }
        
        
    }

