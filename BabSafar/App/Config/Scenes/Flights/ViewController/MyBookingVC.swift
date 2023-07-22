//
//  MyBookingVC.swift
//  BabSafar
//
//  Created by MA673 on 27/07/22.
//

import UIKit

class MyBookingVC: BaseTableVC, UPComingFlightsViewModelDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var buttonsHolderView: UIView!
    @IBOutlet weak var upCommingView: UIView!
    @IBOutlet weak var completedView: UIView!
    @IBOutlet weak var cancelledView: UIView!
    @IBOutlet weak var upComminglbl: UILabel!
    @IBOutlet weak var upCommingBtn: UIButton!
    @IBOutlet weak var completedlbl: UILabel!
    @IBOutlet weak var completedBtn: UIButton!
    @IBOutlet weak var cancelledlbl: UILabel!
    @IBOutlet weak var cancelledBtn: UIButton!
    @IBOutlet weak var upcomingUL: UIView!
    @IBOutlet weak var completedUL: UIView!
    @IBOutlet weak var cancelledUL: UIView!
    
    var viewmodel:UPComingFlightsViewModel?
    var payload = [String:Any]()
    var tablerow = [TableRow]()
    var buttonTapKey = String()
    var mybookings :UPComingFlightsModel?
    var resultData = [Res_data]()
    var vocherUrl = String()
    var app_reference = String()
    var booking_source = String()
    var booking_status = String()
    var flightdata = [Flight_data]()
    var tabtapkey = String()
    
    static var newInstance: MyBookingVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? MyBookingVC
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        tabtapkey = "flight"
        callAPI()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        viewmodel = UPComingFlightsViewModel(self)
    }
    
    
    func setupUI() {
        nav.titlelbl.text = "My Bookings"
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        nav.mainTabBtnsView.isHidden = false
        nav.backBtnView.isHidden = true
        nav.flightBtn.addTarget(self, action: #selector(didTapOnFlightButtonAction(_:)), for: .touchUpInside)
        nav.hotelBtn.addTarget(self, action: #selector(didTapOnHoteltButtonAction(_:)), for: .touchUpInside)
        nav.visaBtn.addTarget(self, action: #selector(didTapOnVisaButtonAction(_:)), for: .touchUpInside)
        
        setupViews(v: buttonsHolderView, radius: 0, color: .WhiteColor)
        setupViews(v: upCommingView, radius: 0, color: .WhiteColor)
        setupViews(v: completedView, radius: 0, color: .WhiteColor)
        setupViews(v: cancelledView, radius: 0, color: .WhiteColor)
        buttonTapKey = "upcoming"
        upcomingUL.backgroundColor = .AppLabelColor
        completedUL.backgroundColor = .WhiteColor
        cancelledUL.backgroundColor = .WhiteColor
        
        setuplabels(lbl: upComminglbl, text: "Up Coming", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .center)
        setuplabels(lbl: completedlbl, text: "Completed", textcolor: .AppLabelColor.withAlphaComponent(0.50), font: .LatoRegular(size: 16), align: .center)
        setuplabels(lbl: cancelledlbl, text: "Cancelled", textcolor: .AppLabelColor.withAlphaComponent(0.50), font: .LatoRegular(size: 16), align: .center)
        
        upCommingBtn.setTitle("", for: .normal)
        completedBtn.setTitle("", for: .normal)
        cancelledBtn.setTitle("", for: .normal)
        
        commonTableView.registerTVCells(["SearchFlightResultTVCell","EmptyTVCell","VocherFlightDetailsTVCell"])
        
    }
    
    
    
    
    func callAPI() {
        DispatchQueue.main.async {[self] in
            
            if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == false {
                TableViewHelper.EmptyMessage(message: "Please Login To View Your Flight Details", tableview: commonTableView, vc: self)
                gotoLoginVC()
            }else {
                TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
                
                callTabSelectedAPI()
            }
        }
    }
    
    
    func gotoLoginVC() {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        callapibool = true
        present(vc, animated: true)
    }
    
    
    
    
    func callTabSelectedAPI() {
        
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "2738"
        
        switch buttonTapKey {
        case "upcoming":
            
            if tabtapkey == "flight" {
                DispatchQueue.main.async {
                    self.callUpComingMobileBookingAPI()
                }
            }else if tabtapkey == "hotel"{
                callHotelAPI()
            }else {
                callVisaAPI()
            }
            
            break
            
            
        case "completed":
            if tabtapkey == "flight" {
                DispatchQueue.main.async {
                    self.callcompletedMobileBookingAPI()
                }
            }else if tabtapkey == "hotel"{
                callHotelAPI()
            }else {
                callVisaAPI()
            }
            
            break
            
        case "cancelled":
            if tabtapkey == "flight" {
                DispatchQueue.main.async {
                    self.callcancelledMobileBookingAPI()
                }
            }else if tabtapkey == "hotel"{
                callHotelAPI()
            }else {
                callVisaAPI()
            }
            
            break
            
        default:
            break
        }
    }
    
    //MARK: - callUpComingMobileBookingAPI
    func callUpComingMobileBookingAPI() {
        resultData.removeAll()
        flightdata.removeAll()
        viewmodel?.CALL_UPCOMING_MOBIL_BOOKING(dictParam: payload)
    }
    
    //MARK: - callcompletedMobileBookingAPI
    func callcompletedMobileBookingAPI() {
        resultData.removeAll()
        flightdata.removeAll()
        viewmodel?.CALL_COMPLETED_MOBIL_BOOKING(dictParam: payload)
    }
    
    //MARK: - callcancelledMobileBookingAPI
    func callcancelledMobileBookingAPI() {
        resultData.removeAll()
        flightdata.removeAll()
        viewmodel?.CALL_CANCELLED_MOBIL_BOOKING(dictParam: payload)
    }
    
    
    
    
    func upcomingFlightsDetails(response: UPComingFlightsModel) {
        tablerow.removeAll()
        
        if response.flight_data?.count == 0 || response.status == false{
            TableViewHelper.EmptyMessage(message: "No Data Avaliable", tableview: commonTableView, vc: self)
            commonTVData = tablerow
            commonTableView.reloadData()
        }else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            
            mybookings = response
            resultData = response.res_data ?? []
            flightdata = mybookings?.flight_data ?? []
            DispatchQueue.main.async {[self] in
                setuptv()
            }
        }
        
    }
    
    
    
    func cancelledFlightsDetails(response: UPComingFlightsModel) {
                
        if response.flight_data?.count == 0 {
            TableViewHelper.EmptyMessage(message: "No Data Avaliable", tableview: commonTableView, vc: self)
            commonTVData = tablerow
            commonTableView.reloadData()
        }else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            resultData = response.res_data ?? []
            flightdata = mybookings?.flight_data ?? []
            mybookings = response
            DispatchQueue.main.async {[self] in
                setuptv()
            }
        }
        
    }
    
    func completedFlightsDetails(response: UPComingFlightsModel) {
        tablerow.removeAll()
       
        if response.flight_data?.count == 0 {
            
            TableViewHelper.EmptyMessage(message: "No Data Avaliable", tableview: commonTableView, vc: self)
            commonTVData = tablerow
            commonTableView.reloadData()
        }else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            mybookings = response
            resultData = response.res_data ?? []
            flightdata = mybookings?.flight_data ?? []
            resultData.forEach { i in
                booking_status = i.booking_status ?? ""
                booking_source = i.booking_source ?? ""
                app_reference = i.app_reference ?? ""
            }
            
            DispatchQueue.main.async {[self] in
                setuptv()
            }
        }
        
    }
    
    
    
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    @objc func reloadTV() {
        commonTableView.reloadData()
    }
    
    
    
    @objc func didTapOnFlightButtonAction(_ sender:UIButton){
        tabtapkey = "flight"
        callAPI()
    }
    
    @objc func didTapOnHoteltButtonAction(_ sender:UIButton){
        tabtapkey = "hotel"
        tablerow.removeAll()
        TableViewHelper.EmptyMessage(message: "No Data Avaliable", tableview: commonTableView, vc: self)
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnVisaButtonAction(_ sender:UIButton){
        tabtapkey = "visa"
        
    }
    
    
    func callHotelAPI() {
        tablerow.removeAll()
        TableViewHelper.EmptyMessage(message: "No Data Avaliable", tableview: commonTableView, vc: self)
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    func callVisaAPI() {
        tablerow.removeAll()
        TableViewHelper.EmptyMessage(message: "No Data Avaliable", tableview: commonTableView, vc: self)
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    func setuptv() {
        tablerow.removeAll()
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        
        resultData.forEach { i in
            vocherUrl = i.uRL ?? ""
        }
        
        
        flightdata.forEach { j in
            j.summary?.forEach({ i in
                tablerow.append(TableRow(title:vocherUrl,
                                         fromTime:i.origin?.time,
                                         toTime: i.destination?.time,
                                         fromCity:"\(i.origin?.city ?? "")(\(i.origin?.loc ?? "")",
                                         fromDate: i.origin?.date,
                                         toCity: "\(i.destination?.city ?? "")(\(i.destination?.loc ?? "")",
                                         toDate: i.destination?.date,
                                         noosStops: "\(i.no_of_stops ?? 0)",
                                         airlineslogo: i.operator_image,
                                         airlinesname:i.operator_name,
                                         airlinesCode: "(\(i.operator_code ?? "")\(i.flight_number ?? ""))",
                                         price: "\(j.transaction?.currency ?? ""):\(Double(j.transaction?.fare ?? "")?.roundToDecimal(2) ?? 0.0)",
                                         travelTime: i.duration,
                                         key:buttonTapKey,
                                         cellType:.VocherFlightDetailsTVCell))
            })
            
        }
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    override func didTapOnViewVoucherBtn(cell: SearchFlightResultTVCell) {
        print("didTapOnViewVoucherBtn")
    }
    
    
    
    
    @IBAction func didTapOnUpComingBtn(_ sender: Any) {
        buttonTapKey = "upcoming"
        upComminglbl.textColor = .AppLabelColor
        upcomingUL.backgroundColor = .AppLabelColor
        
        completedlbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        completedUL.backgroundColor = .WhiteColor
        
        cancelledlbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        cancelledUL.backgroundColor = .WhiteColor
        callAPI()
    }
    
    @IBAction func didTapCompletedBtn(_ sender: Any) {
        buttonTapKey = "completed"
        tablerow.removeAll()
        commonTableView.reloadData()
        upComminglbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        upcomingUL.backgroundColor = .WhiteColor
        
        completedlbl.textColor = .AppLabelColor
        completedUL.backgroundColor = .AppLabelColor
        
        cancelledlbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        cancelledUL.backgroundColor = .WhiteColor
        callAPI()
    }
    
    @IBAction func didTapOnCancelledBtn(_ sender: Any) {
        tablerow.removeAll()
        commonTableView.reloadData()
        buttonTapKey = "cancelled"
        upComminglbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        upcomingUL.backgroundColor = .WhiteColor
        
        completedlbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        completedUL.backgroundColor = .WhiteColor
        
        cancelledlbl.textColor = .AppLabelColor
        cancelledUL.backgroundColor = .AppLabelColor
        callAPI()
    }
    
    override func didTapOnViewVocherBtn(cell: VocherFlightDetailsTVCell) {
        
        print(resultData.count)
        print(flightdata.count)
        
        let vocherPdf = "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/voucher/flight/\(resultData[(cell.indexPath?.row ?? 0)].app_reference ?? "")/\(resultData[(cell.indexPath?.row ?? 0)].booking_source ?? "")/\(resultData[(cell.indexPath?.row ?? 0)].booking_status ?? "")/show_pdf"
        
        
        print(vocherPdf)
        gotoAboutUsVC(title: "Vocher Details", url: vocherPdf)
    }
    func gotoAboutUsVC(title:String,url:String) {
        guard let vc = AboutUsVC.newInstance.self else {return}
        vc.urlString = url
        vc.titleString = title
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
}



extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
