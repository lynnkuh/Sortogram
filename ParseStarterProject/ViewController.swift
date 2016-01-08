/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse



class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PassImageFromGalleryDelegate,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var filteredCollectionView: UICollectionView!
    
    
    @IBOutlet weak var selectedImageButton: UIButton!
    
    @IBOutlet weak var filteredImage: UIImageView!
    
    
    var filteredThumbnailImages = [UIImage]() {
        didSet{
            self.filteredCollectionView.reloadData()
        }
    }
    @IBAction func filterButtonPressed(sender: AnyObject) {
        
            print("yay")
            
            self.presentFilterAlertView()
        }
   
    
    
    @IBAction func presentImagePickerButton(sender: UIButton) {
        
        print("Button selected..")
        
    
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentActionSheet()
        } else {
            self.presentImagePickerFor(.PhotoLibrary)
        }
    }
    
    @IBAction func uploadImageButtonSelected(sender: UIButton) {
        
        
            sender.enabled = false
            
            if let image = self.imageView.image {
                API.uploadImage(image) { (success) -> () in
                    if success {
                        sender.enabled = true
                        self.presentAlertView()
                    }
                }
            }
    }
   
    
    
    
    func presentFilterAlertView() {
        
        let alertController = UIAlertController(title: "Filters", message: "Pick an awesome filter!", preferredStyle: .ActionSheet)
        
        let vintageFillerAction = UIAlertAction(title: "vintage", style: UIAlertActionStyle.Default) { (alert) -> Void in
        
        FilterService.applyVintageEffect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
            
            if let filteredImage = filteredImage {
                self.imageView.image = filteredImage
                print("Vintage Filter Applied")
            }
            
            })
        }
        
        
        
        let BWFillerAction = UIAlertAction(title: "Black and White Effect", style: UIAlertActionStyle.Default) { (alert) -> Void in
            
            FilterService.applyBWEffect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
                
                if let filteredImage = filteredImage {
                    self.imageView.image = filteredImage
                    print("Black and White Applied")
                }
                
            })
        }
        
        let chromeFillerAction = UIAlertAction(title: "Chrome Effect", style: UIAlertActionStyle.Default) { (alert) -> Void in
            
            FilterService.applyChromeEffect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
                
                if let filteredImage = filteredImage {
                    self.imageView.image = filteredImage
                    print("Chrome Filter Applied")
                }
                
            })
        }
        
        let sepiaFillerAction = UIAlertAction(title: "Sepia Effect", style: UIAlertActionStyle.Default) { (alert) -> Void in
            
            FilterService.applySepiaEffect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
                
                if let filteredImage = filteredImage {
                    self.imageView.image = filteredImage
                    print("Sepia Filter Applied")
                }
                
            })
        }
        
        let bloomFillerAction = UIAlertAction(title: "Bloom", style: UIAlertActionStyle.Default) { (alert) -> Void in
            
            FilterService.applyBloomEffect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
                
                if let filteredImage = filteredImage {
                    self.imageView.image = filteredImage
                    print("Bloom Filter Applied")
                }
                
            })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alertController.addAction(vintageFillerAction)
        alertController.addAction(BWFillerAction)
        alertController.addAction(chromeFillerAction)
        alertController.addAction(sepiaFillerAction)
        alertController.addAction(bloomFillerAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func presentAlertView() {let alertController = UIAlertController(title: "", message: "Image successfully uploaded.", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func presentFilterAlert() {let alertController = UIAlertController(title: "", message: "Filter  successfully applied.", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        
        if let tabBarController = self.tabBarController, viewControllers = tabBarController.viewControllers {
            if let galleryViewController = viewControllers[1] as? DisplayPicturesViewController {
                galleryViewController.delegate = self
                
                filteredCollectionView.delegate = self
                self.filteredCollectionView.dataSource = self
                self.createFilteredImages()
                self.filteredCollectionView.hidden = true
                
                
                let collectionViewBounds = CGRectGetWidth(UIScreen.mainScreen().bounds)
                let collectionViewHeight = CGRectGetHeight(self.filteredCollectionView.frame)
                let galleryLayout = PhotoGridLayout()
                galleryLayout.thumbnailsFlowLayout(collectionViewBounds, viewHeight: collectionViewHeight)
                self.filteredCollectionView.collectionViewLayout = galleryLayout
                
            }
        }
    }
        
    // Stuff for the collection view of filtered images
        
        func createFilteredImages() {
            self.filteredThumbnailImages.removeAll()
            if let image = self.imageView.image {
                FilterService.applyVintageEffect(image) { (filteredImage, name) -> Void in
                    if let filteredImage = filteredImage {
                        self.filteredThumbnailImages.append(filteredImage)
                    }
                }
                
                FilterService.applyBWEffect(image) { (filteredImage, name) -> Void in
                    if let filteredImage = filteredImage {
                        self.filteredThumbnailImages.append(filteredImage)
                    }
                }
                
                FilterService.applyChromeEffect(image) { (filteredImage, name) -> Void in
                    if let filteredImage = filteredImage {
                        self.filteredThumbnailImages.append(filteredImage)
                    }
                }
                
                FilterService.applySepiaEffect(image) { (filteredImage, name) -> Void in
                    if let filteredImage = filteredImage {                        self.filteredThumbnailImages.append(filteredImage)
                    }
                }
                
                
            }
        }
    

        func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return filteredThumbnailImages.count
        }
        
        func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(FilterCollectionViewCell.identifier(), forIndexPath: indexPath) as! FilterCollectionViewCell
            cell.image = self.filteredThumbnailImages[indexPath.row]
            
            return cell
            
        }
        
        func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
            let filteredImage = filteredThumbnailImages[indexPath.row]
            self.imageView.image = filteredImage
        }
        
        func collectionViewSelectedStatus(status: Status) {
            self.dismissViewControllerAnimated(true, completion: nil)
            self.imageView.image = status.image
            tabBarController!.selectedViewController = tabBarController!.viewControllers![0]
            createFilteredImages()
            self.filteredCollectionView.hidden = false
        }
        
       
        
  // Testing the parse backend (parse.com)
  /*
        
        let testObject = PFObject(className: "Status")
        testObject["text"] = "This is a new text."
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
    
*/
      


func presentActionSheet() {
    
    let alertController = UIAlertController(title: "", message: "Please choose your source.", preferredStyle: .ActionSheet)
    
    let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (action) -> Void in
        self.presentImagePickerFor(.Camera)
    }
    
    let photoLibraryAction = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.Default) { (action) -> Void in
        self.presentImagePickerFor(.PhotoLibrary)
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
    
    alertController.addAction(cameraAction)
    alertController.addAction(photoLibraryAction)
    alertController.addAction(cancelAction)
    
    self.presentViewController(alertController, animated: true, completion: nil)
}

func presentImagePickerFor(sourceType: UIImagePickerControllerSourceType) {
    let imagePickerController = UIImagePickerController()
    imagePickerController.sourceType = sourceType
    imagePickerController.delegate = self
    self.presentViewController(imagePickerController, animated: true, completion: nil)
}



    func setupAppearance() {
        self.imageView.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.imageView.layer.borderWidth = 0.6
    }


    

   
    
    // MARK: UIImagePickerController Delegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
       self.selectedImageButton.setImage(nil, forState: UIControlState.Normal)
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        createFilteredImages()
        self.filteredCollectionView.hidden = false
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    func didSelectImageFromGallery(image: UIImage) {
        self.imageView.image = image
        self.selectedImageButton.setImage(nil, forState: UIControlState.Normal)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
