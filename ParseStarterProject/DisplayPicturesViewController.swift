//
//  DisplayPicturesViewController.swift
//  Sortogram
//
//  Created by Regular User on 11/4/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class DisplayPicturesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var itemView: UICollectionView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var parseObjects = [PFObject]() {
        didSet {
            
            print(parseObjects)
            
            self.itemView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemView.delegate = self
        self.itemView.dataSource = self

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Status")
        query.whereKeyExists("image")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            
            
            if error == nil {
                if let objects = objects {
                    self.parseObjects = objects
                }
            }
            
        }
    }
    
    
    
    
    
        // MARK: UICollectionView
        
        func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            print(self.parseObjects.count)
            
           return self.parseObjects.count
}
        
        func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(DisplayCollectionViewCell.identifier(), forIndexPath: indexPath) as! DisplayCollectionViewCell
            
            let parseObject = self.parseObjects[indexPath.row]
            
            if let file = parseObject["image"] as? PFFile {
                file.getDataInBackgroundWithBlock({ (imageData, error) -> Void in
                    if let imageData = imageData, image = UIImage(data: imageData) {
                        cell.imageView.image = image
                    }
                })
            }
            
//            cell.imageView.image = image
            
            return cell
        }

/*
        func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
           
            let screenSize: CGRect = UIScreen.mainScreen().bounds
            
            //        let screenWidth = screenSize.width
            //        let screenHeight = screenSize.height
            
            let size = (screenSize.width / 3) - 7
            
            return CGSizeMake(size, size)
        }
*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
