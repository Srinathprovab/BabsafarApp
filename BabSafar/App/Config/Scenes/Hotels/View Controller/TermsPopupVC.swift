//
//  TermsPopupVC.swift
//  BabSafar
//
//  Created by FCI on 25/08/23.
//

import UIKit

class TermsPopupVC: BaseTableVC {
    
    
    @IBOutlet weak var hotelNamelbl: UILabel!
    
    
    
    var titlestr = String()
    var disc:Hotel_desc?
    var hotel_desc = String()
    var tablerow = [TableRow]()
    
    static var newInstance: TermsPopupVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotels.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? TermsPopupVC
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(titlestr)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        hotelNamelbl.text = titlestr
        commonTableView.registerTVCells(["HotelDesclblTVCell"])
        setupTV()
    }
    
    func setupTV() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(moreData: disc,
                                 cellType:.HotelDesclblTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}
