//
//  ColorManager.swift
//  DoorcastRebase
//
//  Created by Codebele 07 on 04/05/2022.
//

import Foundation
import UIKit

extension UIColor {
    
    public static var WhiteColor: UIColor {
        get {
            return UIColor(named: "WhiteColor")!
        }
    }
    
   
    
    public static var AppBorderColor: UIColor {
        get {
           // return UIColor(named: "AppBorderColor")!
            return UIColor.black.withAlphaComponent(0.2)
        }
    }
    
    public static var AppBtnColor: UIColor {
        get {
           // return UIColor(named: "AppBtnColor")!
            return HexColor("#e82a5e")
        }
    }
    
    public static var IttenarySelectedColor: UIColor {
        get {
            return UIColor(named: "IttenarySelectedColor")!
        }
    }
    
    
    public static var AppCalenderDateSelectColor: UIColor {
        get {
            return UIColor(named: "AppCalenderDateSelectColor")!
        }
    }
    
    
    public static var AppHolderViewColor: UIColor {
        get {
            return UIColor(named: "AppHolderViewColor")!
        }
    }
    
    
    public static var AppImageDefaultColor: UIColor {
        get {
            return UIColor(named: "AppImageDefaultColor")!
        }
    }
    
    public static var AppLabelColor: UIColor {
        get {
            return UIColor(named: "AppLabelColor")!
        }
    }
    
    
    public static var AppTabbarItemSelectColor: UIColor {
        get {
            return UIColor(named: "AppTabbarItemSelectColor")!
        }
    }
    
    
    public static var AppTabSelectColor: UIColor {
        get {
            return UIColor(named: "AppTabSelectColor")!
        }
    }
    
    
    public static var AppHeadderBackColor: UIColor {
        get {
            return UIColor(named: "AppHeadderBackColor")!
        }
    }
    
    public static var SubTitleColor: UIColor {
        get {
            return UIColor(named: "SubTitleColor")!
        }
    }
    
    
    public static var RefundableColor: UIColor {
        get {
            return UIColor(named: "RefundableColor")!
        }
    }
    
    
    public static var AddAdultBtnColor: UIColor {
        get {
            return UIColor(named: "AddAdultBtnColor")!
        }
    }
    
    
    
}
