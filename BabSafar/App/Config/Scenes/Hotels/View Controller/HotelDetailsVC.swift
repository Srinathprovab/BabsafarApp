//
//  HotelDetailsVC.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit

class HotelDetailsVC: BaseTableVC, HotelDetailsViewModelDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var bookNowView: UIView!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    @IBOutlet weak var citynamelbl: UILabel!
    @IBOutlet weak var dateslbl: UILabel!
    
    var selectedCell: NewRoomDetailsTVCell?
    var imgArray = ["img1","img2","img3","img4","img2","img1","img4","img3","img1","img2","img3","img4","img2","img1","img4","img3"]
    var tablerow = [TableRow]()
    static var newInstance: HotelDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotels.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HotelDetailsVC
        return vc
    }
    
    var viewmodel:HotelDetailsViewModel?
    var payload = [String:Any]()
    var bookingsource = String()
    var hotelid = String()
    var searchid = String()
    var hotelDetails:Hotel_details?
    var kwdprice = String()
    var img = String()
    
    
    //MARK: - Loading function
    override func viewWillAppear(_ animated: Bool) {
        selectedCellStates = [:]
        addObserver()
       
        if callapibool == true{
            
//            bookNowView.isUserInteractionEnabled = false
//            bookNowView.alpha = 0.5
//
            holderView.isHidden = true
            callAPI()
        }
        
    }
    
    
    //MARK: - show BookNow Btn
    @objc func showBookNowBtn() {
        bookNowView.isUserInteractionEnabled = true
        bookNowView.alpha = 1
    }

    
    //MARK: - Loading function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        viewmodel = HotelDetailsViewModel(self)
        
    }
    
    
    
    //MARK: - setupUI
    func setupUI() {
        holderView.backgroundColor = .AppBorderColor
       
        setuplabels(lbl: citynamelbl, text: defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "", textcolor: .WhiteColor, font: .LatoMedium(size: 18), align: .center)
        setuplabels(lbl: dateslbl, text: "Checkin:\(defaults.string(forKey: UserDefaultsKeys.checkin) ?? "") | Checkout:\(defaults.string(forKey: UserDefaultsKeys.checkout) ?? "")", textcolor: .WhiteColor, font: .LatoBold(size: 14), align: .center)
        
     
        
        bookNowView.backgroundColor = .AppBtnColor
        setuplabels(lbl: kwdlbl, text: "Book Now", textcolor: .WhiteColor, font: .LatoMedium(size: 18), align: .right)
        bookNowBtn.setTitle("", for: .normal)
        bookNowBtn.addTarget(self, action: #selector(didTapOnBookNowBtn(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["HotelImagesTVCell","EmptyTVCell","RoomsTVcell"])
        
    }
    
    
    
    //MARK: - setuptv
    func setuptv() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:hotelDetails?.name ?? "",
                                 subTitle: "\(hotelDetails?.address ?? "")|\(hotelDetails?.city_name ?? "")",
                                 data:imgArray,
                                 image:img,
                                 cellType:.HotelImagesTVCell))
        
        
        tablerow.append(TableRow(title:hotelDetails?.latitude ?? "",
                                 subTitle: hotelDetails?.longitude ?? "",
                                 buttonTitle: hotelDetails?.name ?? "",
                                 moreData:roomsDetails,
                                 cellType:.RoomsTVcell))
        
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    //MARK: - didTapOnBookNowBtn
    @objc func didTapOnBookNowBtn(_ sender: UIButton) {
        
        if hotelDetailsTapBool == true {
            if selectedrRateKeyArray.isEmpty == false {
                gotoAddContactAndGuestDetailsVC()
            }else {
                showToast(message: "Select Room")
            }
        }else {
            NotificationCenter.default.post(name: NSNotification.Name("gotoroom"), object: false)
        }
        
    }
    
    
    func gotoAddContactAndGuestDetailsVC(){
        guard let vc = AddContactAndGuestDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        vc.kwdprice = kwdprice
        self.present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnRoomsBtn
    override func didTapOnRoomsBtn(cell: RoomsTVcell) {
        cell.key = "rooms"
        hotelDetailsTapBool = true
        cell.roomDetailsTV.reloadData()
    }
    
    
    //MARK: - didTapOnHotelsDetailsBtn
    override func didTapOnHotelsDetailsBtn(cell: RoomsTVcell) {
        cell.key = "hotels details"
        hotelDetailsTapBool = false
        cell.roomDetailsTV.reloadData()
    }
    
    
    //MARK: - didTapOnAmenitiesBtn
    override func didTapOnAmenitiesBtn(cell: RoomsTVcell) {
        cell.key = "amenities"
        hotelDetailsTapBool = false
        cell.roomDetailsTV.reloadData()
    }
    
    //MARK: - didTapOnCancellationPolicyBtnAction
    
    override func didTapOnCancellationPolicyBtnAction(cell:NewRoomDetailsTVCell){
        
        guard let vc = CancellationPolicyPopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.amount = cell.CancellationPolicyAmount
        vc.datetime = cell.CancellationPolicyFromDate
        vc.fartType = cell.fareTypeString
        vc.CancellationPolicyArray = cell.CancellationPolicyArray
        self.present(vc, animated: false)
        
    }
    
    
    //MARK: - didTapOnSelectRoomBtnAction
    
    override func didTapOnSelectRoomBtnAction(cell:NewRoomDetailsTVCell){
        
      //  CancellationPolicyArray = cell.CancellationPolicyArray
        
        bookNowlbl.isHidden = false
        
        // Toggle the selected state
        cell.isSelectedCell.toggle()
        
        // Update the button color
        cell.updateButtonColor()
        
        // Check if a different cell was previously selected
        if let previouslySelectedCell = selectedCell {
            // Deselect the previously selected cell
            previouslySelectedCell.isSelectedCell = false
            previouslySelectedCell.updateButtonColor()
        }
        
        // Select the tapped cell
        cell.isSelectedCell = true
        cell.updateButtonColor()
        
        // Update the selectedCell reference
        selectedCell = cell
        
        bookNowView.isUserInteractionEnabled = true
        bookNowView.alpha = 1
        grandTotal = cell.pricelbl.text ?? ""
        setuplabels(lbl: bookNowlbl, text: cell.pricelbl.text ?? "" , textcolor: .WhiteColor, font: .LatoMedium(size: 18), align: .left)
        
        selectedrRateKeyArray = cell.ratekey
        
       setAttributedTextnew(str1: "\(cell.currency )",
                                                str2: "\(cell.exactprice )",
                                                lbl: bookNowlbl,
                                                str1font: .LatoBold(size: 12),
                                                str2font: .LatoBold(size: 18),
                                                str1Color: .WhiteColor,
                                                str2Color: .WhiteColor)
        
        
        roomselected = cell.selectedRoom
       
        
        
    }
    
    
    
    @IBAction func didTaponbackBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    
}



extension HotelDetailsVC {
    
    
    //MARK: - CALL HOTEL DETAILS API
    func callAPI() {
        payload["booking_source"] = bookingsource
        payload["hotel_id"] = hotelid
        payload["search_id"] = hotelSearchId
        viewmodel?.CALL_HOTEL_DETAILS_API(dictParam: payload)
    }
    
    func hotelDetails(response: HotelSelectedDetailsModel) {
        holderView.isHidden = false
        hsearchid = response.params?.search_id ?? ""
        htoken = response.hotel_details?.token ?? ""
        htokenkey = response.hotel_details?.tokenKey ?? ""
        hbookingsource = response.hotel_details?.booking_source ?? ""
        
        
        hotelDetails = response.hotel_details
        roomsDetails = response.hotel_details?.rooms ?? [[]]
        images = response.hotel_details?.images ?? []
        formatAmeArray = response.hotel_details?.format_ame ?? []
        formatDesc = response.hotel_details?.format_desc ?? []
        img = response.hotel_details?.image ?? ""
        
        bookNowlbl.isHidden = true
        
        DispatchQueue.main.async {[self] in
            setuptv()
        }
    }
    
}

extension HotelDetailsVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(roomtapbool), name: Notification.Name("roomtapbool"), object: nil)

    }
    
    @objc func roomtapbool(notify:NSNotification) {
        if let tapbool = notify.object as? Bool {
            if tapbool == true {
                kwdlbl.text = "Book Now"
            }else {
                kwdlbl.text = "Select Now"
            }
        }
    }
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            callAPI()
        }
    }
    
    //MARK: - resultnil
    @objc func resultnil() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "noresult"
        self.present(vc, animated: true)
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "nointernet"
        self.present(vc, animated: true)
    }
    
}
