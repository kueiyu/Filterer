//
//  ViewController.swift
//  Filterer
//
//  Created by Kyo.L on 2/28/16.
//  Copyright © 2016 Kyo.L. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
//Backbone of apps
    
    var filteredImage:UIImage? // not exist until we let it be defined
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var filterView: UIImageView!
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var originLabel: UILabel!
    
    @IBOutlet var originView: UIImageView!
    @IBOutlet var bottomMenu: UIView!

    
    @IBOutlet var blackView: UIImageView!
    
    @IBOutlet var compareView: UIView!
    @IBOutlet var filterButton: UIButton!
    
    @IBOutlet weak var longPress: UILongPressGestureRecognizer!
    
    let originImage = UIImage(named:"scenery")!

    let image = UIImage(named: "scenery")!
    
    //Filter Buttons Area Start
    @IBOutlet var RedFilter: UIButton!
    @IBOutlet var GreenFilter: UIButton!
    @IBOutlet var BlueFilter: UIButton!
    @IBOutlet var YellowFilter: UIButton!
    @IBOutlet var PurpleFilter: UIButton!
    //Filter Buttons End
    
    @IBAction func onRedFilter(sender: UIButton) {
        hideOriginalLabel()
        let rgbaImage = RGBAImage(image: image)!
        
//      let originImage = RGBAImage(image: imageView.image!)!
        
        let pixelCount = rgbaImage.width * rgbaImage.height
        let avgRed = 107
        let avgGreen = 109
        let avgBlue = 110
        let sum = avgRed + avgGreen + avgBlue
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                
                var pixel = rgbaImage.pixels[index]
//              var originPixel = originImage.pixels[index]
                let redDelta = Int(pixel.red) - avgRed
                let greenDelta = Int(pixel.green) - avgGreen
                let blueDelta = Int(pixel.blue) - avgBlue
                
                
                var modifier = 1 + 4 * (Double(y) / Double(rgbaImage.height))
                if (Int(pixel.red) < avgRed) {
                    modifier = 1
                }
                
                rgbaImage.pixels[index].red = UInt8(max(min(255, Int(round(Double(avgRed) + modifier * Double(redDelta)))), 0))
                pixel.green = UInt8(max(min(255, Int(round(Double(avgGreen) + modifier * Double(greenDelta)))), 0))
                pixel.blue = UInt8(max(min(255, Int(round(Double(avgBlue) + modifier * Double(blueDelta)))), 0))
//                NSLog("new: %d, origin: %d", rgbaImage.pixels[index].red, originPixel.red)
            }
        }
        filteredImage = rgbaImage.toUIImage()
        
//        NSLog("on red filter")
        
        imageView.image = filteredImage
        
            }
    
    @IBAction func onGreenFilter(sender: UIButton) {
        hideOriginalLabel()

        let rgbaImage = RGBAImage(image: image)!
        
        let pixelCount = rgbaImage.width * rgbaImage.height
        let avgRed = 107
        let avgGreen = 109
        let avgBlue = 110
        let sum = avgRed + avgGreen + avgBlue
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                
                var pixel = rgbaImage.pixels[index]

                let redDelta = Int(pixel.red) - avgRed
                let greenDelta = Int(pixel.green) - avgGreen
                let blueDelta = Int(pixel.blue) - avgBlue
                
                var modifier = 1 + 4 * (Double(y) / Double(rgbaImage.height))
                if (Int(pixel.green) < avgGreen) {
                    modifier = 1
                }
                
                pixel.red = UInt8(max(min(255, Int(round(Double(avgRed) + modifier * Double(redDelta)))), 0))
                rgbaImage.pixels[index].green = UInt8(max(min(255, Int(round(Double(avgGreen) + modifier * Double(greenDelta)))), 0))
                pixel.blue = UInt8(max(min(255, Int(round(Double(avgBlue) + modifier * Double(blueDelta)))), 0))
            }
        }
        filteredImage = rgbaImage.toUIImage()
        blackView.image = filteredImage
        let crossFade = CABasicAnimation(keyPath: "contents")
        crossFade.duration = 0.5
        crossFade.fromValue = imageView.image
        crossFade.toValue = nil
        imageView.image!.animationDidStart(crossFade)
        blackView.hidden = true
        imageView.image = filteredImage
        
    }
    
    @IBAction func onBlueFilter(sender: UIButton) {
        hideOriginalLabel()

        let rgbaImage = RGBAImage(image: image)!
        
        let pixelCount = rgbaImage.width * rgbaImage.height
        let avgRed = 107
        let avgGreen = 109
        let avgBlue = 110
        let sum = avgRed + avgGreen + avgBlue
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                
                var pixel = rgbaImage.pixels[index]
                
                let redDelta = Int(pixel.red) - avgRed
                let greenDelta = Int(pixel.green) - avgGreen
                let blueDelta = Int(pixel.blue) - avgBlue
                
                var modifier = 1 + 4 * (Double(y) / Double(rgbaImage.height))
                if (Int(pixel.blue) < avgBlue) {
                    modifier = 1
                }
                
                pixel.red = UInt8(max(min(255, Int(round(Double(avgRed) + modifier * Double(redDelta)))), 0))
                pixel.green = UInt8(max(min(255, Int(round(Double(avgGreen) + modifier * Double(greenDelta)))), 0))
                rgbaImage.pixels[index].blue = UInt8(max(min(255, Int(round(Double(avgBlue) + modifier * Double(blueDelta)))), 0))
            }
        }
        filteredImage = rgbaImage.toUIImage()
        
        imageView.image = filteredImage
    }
    
    @IBAction func onYellowFilter(sender: UIButton) {
        hideOriginalLabel()

        let rgbaImage = RGBAImage(image: image)!
        
        let pixelCount = rgbaImage.width * rgbaImage.height
        let avgRed = 107
        let avgGreen = 109
        let avgBlue = 110
        let sum = avgRed + avgGreen + avgBlue
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                
                var pixel = rgbaImage.pixels[index]
                
                let redDelta = Int(pixel.red) - avgRed
                let greenDelta = Int(pixel.green) - avgGreen
                let blueDelta = Int(pixel.blue) - avgBlue
                
                
                var modifier = 1 + 4 * (Double(y) / Double(rgbaImage.height))
                if (Int(pixel.red) < avgRed) {
                    modifier = 1
                }
                
                pixel.red = UInt8(max(min(255, Int(round(Double(avgRed) + modifier * Double(redDelta)))), 0))
                rgbaImage.pixels[index].green = UInt8(max(min(255, Int(round(Double(avgGreen) + modifier * Double(greenDelta)))), 0))
                rgbaImage.pixels[index].blue = UInt8(max(min(255, Int(round(Double(avgBlue) + modifier * Double(blueDelta)))), 0))
            }
        }
        filteredImage = rgbaImage.toUIImage()
        
        imageView.image = filteredImage

    }
    
    @IBAction func onPurpleFilter(sender: UIButton) {
        hideOriginalLabel()

        let rgbaImage = RGBAImage(image: image)!
        
        let pixelCount = rgbaImage.width * rgbaImage.height
        let avgRed = 107
        let avgGreen = 109
        let avgBlue = 110
        let sum = avgRed + avgGreen + avgBlue
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                
                var pixel = rgbaImage.pixels[index]
                
                let redDelta = Int(pixel.red) - avgRed
                let greenDelta = Int(pixel.green) - avgGreen
                let blueDelta = Int(pixel.green) - avgBlue
                
                var modifier = 1 + 4 * (Double(y) / Double(rgbaImage.height))
                if (Int(pixel.red) < avgRed) {
                    modifier = 1
                }
                
                rgbaImage.pixels[index].red = UInt8(max(min(255, Int(round(Double(avgRed) + modifier * Double(redDelta)))), 0))
                pixel.green = UInt8(max(min(255, Int(round(Double(avgGreen) + modifier * Double(greenDelta)))), 0))
                rgbaImage.pixels[index].blue = UInt8(max(min(255, Int(round(Double(avgBlue) + modifier * Double(blueDelta)))), 0))
            }
        }
        filteredImage = rgbaImage.toUIImage()
        
        imageView.image = filteredImage

    }
    
    //  Compare Button
    @IBOutlet var Compare: UIButton!
    @IBAction func onCompare(sender: UIButton) {
        if filterButton.selected {
            if (sender.selected) {
                if (filteredImage == nil) {
                    imageView.image = image
                    showOriginLabel()
                    sender.selected = false
                } else {
                imageView.image = filteredImage
                hideOriginalLabel()
                sender.selected = false
                }
            } else {
                imageView.image = image
                showOriginLabel()
                sender.selected = true
            }
        } else {
            print("CompareButton not working")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(longPress)
        
        showOriginLabel()
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        //use it whenever you don't want the autoresizing func happen.
        compareView.backgroundColor = UIColor.blackColor()
        compareView.translatesAutoresizingMaskIntoConstraints = false
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: ["Check out our really cool app", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    @IBAction func onNewPhoto(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "NewPhoto", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: {
            action in
            self.showCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: {
            action in
            self.showAlbum()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil )
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil )
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        
        presentViewController(cameraPicker, animated: true, completion: nil )
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            hideOriginalLabel()
            showBlackView()
            self.blackView.alpha = 0
            UIView.animateWithDuration(0.4) {
                self.blackView.alpha = 1.0
            }
            blackView.removeFromSuperview()

        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
            }
    
    @IBAction func onFilter(sender: UIButton) {
        if (sender.selected) {
            hideSecondaryMenu()
            sender.selected = false
        }
        else {
            showSecondaryMenu()
            sender.selected = true
        }
    }
    
    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
            
        }
        
    }
    
    func hideSecondaryMenu() {
       
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
            }) { completed in
                if completed == true {
                self.secondaryMenu.removeFromSuperview()
                }
        }
    }
    
    func showOriginLabel() {
        view.addSubview(originLabel)
        self.originLabel.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.originLabel.alpha = 1.0
            
        }
        
    }
    
    func hideOriginalLabel() {
        UIView.animateWithDuration(0.4, animations: {
            self.originLabel.alpha = 0
        }) { completed in
            if completed == true {
                self.originLabel.removeFromSuperview()
            }
        }
    }
    
    func showBlackView() {
        view.addSubview(blackView)
        blackView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(1.0)
        self.blackView.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.blackView.alpha = 1.0
        }
    }
    
    @IBAction func longPressGesture(sender: UILongPressGestureRecognizer) {
        if filterButton.selected {
            if (filteredImage == nil) {
                NSLog("Filter Button selected but do nothing")
            } else {
            if (sender.state == .Ended) {
                imageView.image = filteredImage
                hideOriginalLabel()
            } else {
                imageView.image = image
                showOriginLabel()
            }
            }
        } else {
            NSLog("Do nothing")
        }
    }
}