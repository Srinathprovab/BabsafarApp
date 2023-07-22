//
//  HotelDetailsVC.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit

class HotelDetailsVC: BaseTableVC, HotelDetailsViewModelDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navView: NavBar!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var bookNowView: UIView!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    
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
        bookNowView.isUserInteractionEnabled = false
        bookNowView.alpha = 0.5
        
        if screenHeight < 835 {
            navHeight.constant = 130
        }
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showBookNowBtn), name: Notification.Name("showBookNowBtn"), object: nil)
        
        
        if callapibool == true{
            holderView.isHidden = true
            callAPI()
        }
        
    }
    
    
    //MARK: - show BookNow Btn
    @objc func showBookNowBtn() {
        bookNowView.isUserInteractionEnabled = true
        bookNowView.alpha = 1
    }
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
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
        
        
        
        
        DispatchQueue.main.async {[self] in
            setuptv()
        }
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
        navView.titlelbl.text = ""
        navView.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        navView.titlelbl.text = ""
        setuplabels(lbl: navView.lbl1, text: defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "", textcolor: .WhiteColor, font: .LatoMedium(size: 18), align: .center)
        setuplabels(lbl: navView.lbl2, text: "Checkin:\(defaults.string(forKey: UserDefaultsKeys.checkin) ?? "") | Checkout:\(defaults.string(forKey: UserDefaultsKeys.checkout) ?? "")", textcolor: .WhiteColor, font: .LatoLight(size: 14), align: .center)
        
        navView.lbl1.isHidden = false
        navView.lbl2.isHidden = false
        navView.filterBtnView.isHidden = true
        navView.editBtnView.isHidden = true
        
        bookNowView.backgroundColor = .AppBtnColor
        setuplabels(lbl: bookNowlbl, text: kwdprice , textcolor: .WhiteColor, font: .LatoMedium(size: 18), align: .left)
        setuplabels(lbl: kwdlbl, text: "Book Now", textcolor: .WhiteColor, font: .LatoMedium(size: 18), align: .right)
        bookNowBtn.setTitle("", for: .normal)
        bookNowBtn.addTarget(self, action: #selector(didTapOnBookNowBtn(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["HotelImagesTVCell","TitleLabelTVCell","EmptyTVCell","RoomsTVcell"])
        
    }
    
    
    
    //MARK: - setuptv
    func setuptv() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(data:imgArray, image:img,cellType:.HotelImagesTVCell))
        tablerow.append(TableRow(title:hotelDetails?.name ?? "",
                                 subTitle: "\(hotelDetails?.address ?? "")|\(hotelDetails?.city_name ?? "")",
                                 key: "hotel",
                                 cellType:.TitleLabelTVCell))
        
        tablerow.append(TableRow(height:20,bgColor: HexColor("#E6E8E7"),cellType:.EmptyTVCell))
        tablerow.append(TableRow(moreData:roomsDetails,cellType:.RoomsTVcell))
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
        guard let vc = AddContactAndGuestDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        vc.kwdprice = kwdprice
        self.present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnRoomsBtn
    override func didTapOnRoomsBtn(cell: RoomsTVcell) {
        cell.key = "rooms"
        cell.roomDetailsTV.reloadData()
    }
    
    
    //MARK: - didTapOnHotelsDetailsBtn
    override func didTapOnHotelsDetailsBtn(cell: RoomsTVcell) {
        cell.key = "hotels details"
        cell.roomDetailsTV.reloadData()
    }
    
    
    
    
    //MARK: - didTapOnAmenitiesBtn
    override func didTapOnAmenitiesBtn(cell: RoomsTVcell) {
        cell.key = "amenities"
        cell.roomDetailsTV.reloadData()
    }
    
    //MARK: - didTapOnViewMapBtnAction
    override func didTapOnViewMapBtnAction(cell: TitleLabelTVCell) {
        guard let vc = MapViewVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        vc.lat = Double(hotelDetails?.latitude ?? "") ?? 0.0
        vc.long = Double(hotelDetails?.longitude ?? "") ?? 0.0
        vc.annotationtitle = hotelDetails?.name ?? ""
        present(vc, animated: true)
    }
    
}


