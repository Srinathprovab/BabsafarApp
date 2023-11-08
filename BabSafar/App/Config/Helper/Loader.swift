//
//  Loader.swift
//  DoorcastRebase
//
//  Created by U Dinesh Kumar Reddy on 05/05/22.
//

import Foundation
import MBProgressHUD
import SDWebImage

class Loader {
    
    static func showAdded(to view: UIView, animated: Bool) {
        DispatchQueue.main.async {
            
            
            if loderBool == false {
               
                DispatchQueue.main.async {
                    ProgressHUD.animationType = .lineSpinFade
                    ProgressHUD.colorAnimation = .AppBtnColor
                    ProgressHUD.show()
                }
                
            }else {
                
                let HUD = MBProgressHUD.showAdded(to: view, animated: true)
                let imageViewAnimatedGif = UIImageView()
                //The key here is to save the GIF file or URL download directly into a NSData instead of making it a UIImage. Bypassing UIImage will let the GIF file keep the animation.
                let filePath = Bundle.main.path(forResource: "loderimg", ofType: "gif")
                let gifData = NSData(contentsOfFile: filePath ?? "") as Data?
                imageViewAnimatedGif.image = UIImage.sd_image(withGIFData: gifData)
                HUD.customView = UIImageView(image: imageViewAnimatedGif.image)
                var rotation: CABasicAnimation?
                rotation = CABasicAnimation(keyPath: "transform.rotation")
                rotation?.fromValue = nil
                // If you want to rotate Gif Image Uncomment
                //  rotation?.toValue = CGFloat.pi * 2
                rotation?.duration = 0.7
                rotation?.isRemovedOnCompletion = false
                HUD.customView?.layer.add(rotation!, forKey: "Spin")
                HUD.mode = MBProgressHUDMode.customView
                // Change hud bezelview Color and blurr effect
                HUD.bezelView.color = UIColor.clear
                HUD.bezelView.tintColor = UIColor.clear
                HUD.bezelView.style = .solidColor
                HUD.bezelView.blurEffectStyle = .dark
                // Speed
                rotation?.repeatCount = .infinity
                HUD.show(animated: true)
            }
            
        }
    }
    
    static func hide(for view: UIView, animated: Bool) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: view, animated: true)
            ProgressHUD.dismiss()
        }
    }
    
    
}


extension UIImage {
    static func animatedGif(named: String, framesPerSecond: Double = 10) -> UIImage? {
        guard let asset = NSDataAsset(name: named) else { return nil }
        return animatedGif(from: asset.data, framesPerSecond: framesPerSecond)
    }
    
    static func animatedGif(from data: Data, framesPerSecond: Double = 10) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        let imageCount = CGImageSourceGetCount(source)
        var images: [UIImage] = []
        for i in 0 ..< imageCount {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: cgImage))
            }
        }
        return UIImage.animatedImage(with: images, duration: Double(images.count) / framesPerSecond)
    }
}
