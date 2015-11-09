//
//  DisplayPicturesViewController.swift
//  Sortogram
//
//  Created by Regular User on 11/4/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse


    
    protocol PassImageFromGalleryDelegate {
        func didSelectImageFromGallery(image: UIImage) -> ()
    }


class DisplayPicturesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var itemView: UICollectionView!
    
    
    
    let defaultImage = UIImage(named: "Image")
    
    var delegate: PassImageFromGalleryDelegate?
    
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
        
        
        let gestureRecognizer: UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: "pinchGesture:")
          itemView.addGestureRecognizer(gestureRecognizer)
        
    
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
    func pinchGesture(gestureRecognizer: UIPinchGestureRecognizer) {
        print("gesture called")
        // Create two custom flow layout cells
        // One is from small to medium size
        // One is from medium to large
        // to pinch use option and my mouse
        
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
   
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cellSelected = collectionView.cellForItemAtIndexPath(indexPath) as? DisplayCollectionViewCell {
            cellSelected.backgroundColor = UIColor.whiteColor()
            
            
            
            //This is needed for Delegate method
            
            let imageSelected = cellSelected.imageView.image
            print(imageSelected)
            if let imageSelected = imageSelected {
                self.delegate?.didSelectImageFromGallery(imageSelected)
            }
        }
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
