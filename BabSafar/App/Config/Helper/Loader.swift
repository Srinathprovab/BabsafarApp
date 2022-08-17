//
//  Loader.swift
//  DoorcastRebase
//
//  Created by U Dinesh Kumar Reddy on 05/05/22.
//

import Foundation
import MBProgressHUD

class Loader {
    
    static func showAdded(to view: UIView, animated: Bool) {
        DispatchQueue.main.async {
//            let loadingMBProgress = MBProgressHUD.showAdded(to: view, animated: true)
//            loadingMBProgress.mode = MBProgressHUDMode.indeterminate
//           // loadingMBProgress.customView =  UIImageView(image: UIImage(named: "icon"))
//            loadingMBProgress.contentColor = UIColor(named: "CommonButtonColor") ?? .red
//            loadingMBProgress.label.text = "Loading..."
//            loadingMBProgress.label.textColor = .AppLabelColor
//            loadingMBProgress.customView?.backgroundColor = .black.withAlphaComponent(0.5)
//
//            loadingMBProgress.bezelView.color = UIColor.black.withAlphaComponent(0.5) // Your backgroundcolor
//            loadingMBProgress.bezelView.style = .solidColor
            
            ProgressHUD.animationType = .lineSpinFade
            ProgressHUD.colorAnimation = UIColor(named: "CommonButtonColor") ?? .red
            ProgressHUD.show()
            
        }
    }

    static func hide(for view: UIView, animated: Bool) {
        DispatchQueue.main.async {
            ProgressHUD.dismiss()
           // MBProgressHUD.hide(for: view, animated: true)
        }
    }
}
