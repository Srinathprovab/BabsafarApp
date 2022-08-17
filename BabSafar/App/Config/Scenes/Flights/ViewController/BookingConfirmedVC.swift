//
//  BookingConfirmedVC.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit

class BookingConfirmedVC: BaseTableVC {
    
    
    @IBOutlet weak var navBar: NavBar!
    
    
    var tablerow = [TableRow]()
    static var newInstance: BookingConfirmedVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingConfirmedVC
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        navBar.titlelbl.text = "Booking Confirmed"
        navBar.backBtn.addTarget(self, action: #selector(didTapOnBackButton(_:)), for: .touchUpInside)
        
        commonTableView.registerTVCells(["BookingConfirmedTVCell","EmptyTVCell","LabelTVCell","ButtonTVCell","SearchFlightResultTVCell","BookedTravelDetailsTVCell"])
        setupTV()
    }
    
    
    func setupTV() {
        tablerow.removeAll()

        tablerow.append(TableRow(title:"Booking Confirmed",cellType:.BookingConfirmedTVCell))
        tablerow.append(TableRow(title:"Flight details",cellType:.LabelTVCell))
        tablerow.append(TableRow(key:"booked", text:"Fri 26 jul",tempText: "Sat 27 jul",cellType:.SearchFlightResultTVCell))
        tablerow.append(TableRow(key:"booked", text:"Fri 26 jul",tempText: "Sat 27 jul",cellType:.SearchFlightResultTVCell))
        tablerow.append(TableRow(title:"Traveller Details",cellType:.LabelTVCell))
        tablerow.append(TableRow(cellType:.BookedTravelDetailsTVCell))
        tablerow.append(TableRow(height:35,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Thank you for booking with bab safar Your attraction voucher has been shared on the confirmed email.",key: "booked",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Download E - Ticket",key:"booked",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:60,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    @objc func didTapOnBackButton(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    override func btnAction(cell: ButtonTVCell) {
        print("Download E - Ticket")
    }
    
}
