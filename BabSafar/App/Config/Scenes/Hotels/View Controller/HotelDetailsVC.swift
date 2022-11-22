//
//  HotelDetailsVC.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit

class HotelDetailsVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navView: NavBar!
    
    var imgArray = ["img1","img2","img3","img4","img2","img1","img4","img3","img1","img2","img3","img4","img2","img1","img4","img3"]
    var tablerow = [TableRow]()
    static var newInstance: HotelDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotels.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HotelDetailsVC
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .AppBorderColor
        navView.titlelbl.text = ""
        navView.filterBtnView.isHidden = false
        navView.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        navView.titlelbl.text = ""
        navView.filterBtnView.isHidden = true
        navView.editBtnView.isHidden = true
        navView.lbl1.text = "dubai (DXB) - kuwait (kWI)"
        navView.lbl2.text = "26 jul - 27 jul | 26 jul - 27 jul"
        navView.lbl1.isHidden = false
        navView.lbl2.isHidden = false
        commonTableView.registerTVCells(["HotelImagesTVCell","TitleLabelTVCell","EmptyTVCell","RoomsTVcell"])
        setuptv()
    }
    
    func setuptv() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(data:imgArray,cellType:.HotelImagesTVCell))
        tablerow.append(TableRow(title:"Majestic City Retreat Hotel",subTitle: "Bur Dubai, Dubai | 700 m from Al Fahidi Metro Station",cellType:.TitleLabelTVCell))
        tablerow.append(TableRow(height:15,bgColor: .AppBorderColor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.RoomsTVcell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    
  
    
    @objc func didTapOnBookNowBtn(_ sender: UIButton) {
        guard let vc = AddContactAndGuestDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    override func didTapOnRoomsBtn(cell: RoomsTVcell) {
        cell.key = "rooms"
        cell.roomDetailsTV.reloadData()
    }
    
    override func didTapOnHotelsDetailsBtn(cell: RoomsTVcell) {
        cell.key = "hotels details"
        cell.roomDetailsTV.reloadData()
    }
    
    override func didTapOnAmenitiesBtn(cell: RoomsTVcell) {
        cell.key = "amenities"
        cell.roomDetailsTV.reloadData()
    }
    
}


extension HotelDetailsVC {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let myFooter =  Bundle.main.loadNibNamed("BookNowButtonsTVCell", owner: self, options: nil)?.first as! BookNowButtonsTVCell
        myFooter.bookNowBtn.addTarget(self, action: #selector(didTapOnBookNowBtn(_:)), for: .touchUpInside)
        return myFooter
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
}
