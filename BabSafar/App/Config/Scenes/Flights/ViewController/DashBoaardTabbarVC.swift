//
//  DashBoaardTabbarVC.swift
//  BabSafar
//
//  Created by MA673 on 19/07/22.
//

import UIKit

class DashBoaardTabbarVC: UITabBarController {
    
    
    // @IBOutlet weak var myTabBar: UITabBar?
    
    static var newInstance: DashBoaardTabbarVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? DashBoaardTabbarVC
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // myTabBar?.tintColor = UIColor.white
        //  tabBarItem.title = ""
        
        setTabBarItems()
    }
    
    
    func setTabBarItems(){
        
    
        
        let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        myTabBarItem1.image = UIImage(named: "tab1")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(HexColor("#000000", alpha: 0.4))
        myTabBarItem1.selectedImage = UIImage(named: "tab1")
        myTabBarItem1.title = "Home"
        myTabBarItem1.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: -6, right: 0)
                
        
        
        let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        myTabBarItem2.image = UIImage(named: "tab2")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.selectedImage = UIImage(named: "tab2")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(HexColor("#ED1654"))
        myTabBarItem2.title = "My Booking"
        myTabBarItem2.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: -6, right: 0)
        
        
        let myTabBarItem3 = (self.tabBar.items?[2])! as UITabBarItem
        myTabBarItem3.image = UIImage(named: "tab3")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem3.selectedImage = UIImage(named: "tab3")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(HexColor("#ED1654"))
        myTabBarItem3.title = "My Account"
        myTabBarItem3.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: -6, right: 0)
        
        let myTabBarItem4 = (self.tabBar.items?[3])! as UITabBarItem
        myTabBarItem4.image = UIImage(named: "tab4")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem4.selectedImage = UIImage(named: "tab4")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(HexColor("#ED1654"))
        myTabBarItem4.title = "More"
        myTabBarItem4.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: -6, right: 0)
        
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        
    }
    
    
}
