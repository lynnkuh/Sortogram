//
//  PhotoFilterViewController.swift
//  Sortogram
//
//  Created by Regular User on 12/12/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

protocol PhotoFilterViewControlDelegate {
    func photoFilterViewControllerDidFinish(image: UIImage)
}

class PhotoFilterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var delegate : PhotoFilterViewControlDelegate?
    var image: UIImage?
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.collectionViewLayout = PhotoFilterFlowLayout(columns: 3.0)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // put filters in an array for the CollectionView
    
    var photoFilters = [FilterService.applyBWEffect, FilterService.applyChromeEffect, FilterService.applyVintageEffect, FilterService.applyBloomEffect, FilterService.applySepiaEffect]
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoFilters.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let photoFilterCell =
        collectionView.dequeueReusableCellWithReuseIdentifier("PhotoFilterCell", forIndexPath: indexPath) as! PhotoFilterCollectionViewCell
       
        let photoFilterFunction = self.photoFilters[indexPath.row]
        
        if let image = self.image {
            
            photoFilterFunction(image, completion: {(photoFilteredImage, name) -> Void in
                photoFilterCell.imageView.image = photoFilteredImage
            })
        }
        
        return photoFilterCell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
          // this function is fired when a collection view cell is selected
        
        if let delegate = self.delegate {
            
            let photoCell = collectionView.cellForItemAtIndexPath(indexPath) as!
            PhotoFilterCollectionViewCell
            
            delegate.photoFilterViewControllerDidFinish(photoCell.imageView.image!)
         }
    }

}


