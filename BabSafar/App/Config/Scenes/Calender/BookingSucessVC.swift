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
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Do any additional setup after loading the view.
        if let gifPath = Bundle.main.path(forResource: "sucessful", ofType: "gif") {
            if let gifData = try? Data(contentsOf: URL(fileURLWithPath: gifPath)) {
                
                let jeremyGif = UIImage.animatedGif(from: gifData)
                self.gifImageView.image = jeremyGif
                
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            self.gotoBookingConfirmedVC()
        }
       
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
       
    }
    
    func gotoBookingConfirmedVC() {
        guard let vc = BookingConfirmedVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.urlString = self.voucherUrl
        callapibool = true
        present(vc, animated: true)
    }
    
    
    
}
