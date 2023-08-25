//
//  BookingSucessVC.swift
//  BabSafar
//
//  Created by FCI on 25/08/23.
//

import UIKit

class BookingSucessVC: UIViewController {
    
    
    
    @IBOutlet weak var gifImageView: UIImageView!
    
    
    static var newInstance: BookingSucessVC? {
        let storyboard = UIStoryboard(name: Storyboard.Calender.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingSucessVC
        return vc
    }
    
    
    var voucherUrl = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Load the GIF image
        if let gifImage = UIImage(named: "loderimg") {
            // Set the image of the UIImageView to the loaded GIF
            gifImageView.image = gifImage
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0, execute: {
            self.goto()
        })
    }
    
    func goto() {
        print(voucherUrl)
    }
    
    
    
}
