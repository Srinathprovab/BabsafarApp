//
//  HotelBookingConfirmedVC.swift
//  BabSafar
//
//  Created by MA673 on 02/08/22.
//

import UIKit

class HotelBookingConfirmedVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    
    
    var tablerow = [TableRow]()
    static var newInstance: HotelBookingConfirmedVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotels.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HotelBookingConfirmedVC
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        nav.titlelbl.text = "Booking Confirmed"
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        
        commonTableView.backgroundColor = .AppBorderColor
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["BookingConfirmedTVCell","EmptyTVCell","LabelTVCell","ButtonTVCell","SearchFlightResultTVCell","BookedTravelDetailsTVCell","HotelDetailsTVCell"])
        
        setuptv()
        
    }
    
    
    
    func setuptv() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Booking Confirmed",key: "booksucess",cellType:.BookingConfirmedTVCell))
        tablerow.append(TableRow(title:"Majestic City Retreat Hotel",subTitle: "Bur Dubai, Dubai | 700 m from Al Fahidi Metro Station",key:"booksucess", text: "26-07-2022",buttonTitle:"1", tempText: "27-07-2022",tempInfo: "1",cellType:.HotelDetailsTVCell))
        
        tablerow.append(TableRow(title:"Room/ Guest details",cellType:.LabelTVCell))
        tablerow.append(TableRow(key:"hotel",cellType:.BookedTravelDetailsTVCell))
        tablerow.append(TableRow(height:35,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Thank you for booking with bab safar Your attraction voucher has been shared on the confirmed email.",key: "booked",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Download E - Ticket",key:"booked",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:60,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    override func btnAction(cell: ButtonTVCell) {
        print("Download E - Ticket")
    }
    
    
}
