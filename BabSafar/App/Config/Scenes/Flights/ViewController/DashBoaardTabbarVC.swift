//
//  DashBoaardTabbarVC.swift
//  BabSafar
//
//  Created by MA673 on 19/07/22.
//

import UIKit

class DashBoaardTabbarVC: UITabBarController {
    
    
    
    static var newInstance: DashBoaardTabbarVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? DashBoaardTabbarVC
        return vc
    }
  
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItems()
    }
    
    
    func setTabBarItems(){

        let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        myTabBarItem1.image = UIImage(named: "tab1")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(.ImageUnSelectColor)
        myTabBarItem1.selectedImage = UIImage(named: "tab1")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(.AppBtnColor)
        myTabBarItem1.title = "Home"
        myTabBarItem1.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: -6, right: 0)
        
        
        
        let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        myTabBarItem2.image = UIImage(named: "tab2")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.selectedImage = UIImage(named: "tab2")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(.AppBtnColor)
        myTabBarItem2.title = "My Booking"
        myTabBarItem2.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: -6, right: 0)
        
        
        let myTabBarItem3 = (self.tabBar.items?[2])! as UITabBarItem
        myTabBarItem3.image = UIImage(named: "tab3")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem3.selectedImage = UIImage(named: "tab3")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(.AppBtnColor)
        myTabBarItem3.title = "My Account"
        myTabBarItem3.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: -6, right: 0)
        
        let myTabBarItem4 = (self.tabBar.items?[3])! as UITabBarItem
        myTabBarItem4.image = UIImage(named: "tab4")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem4.selectedImage = UIImage(named: "tab4")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(.AppBtnColor)
        myTabBarItem4.title = "More"
        myTabBarItem4.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: -6, right: 0)
        
    }
    
   
}
