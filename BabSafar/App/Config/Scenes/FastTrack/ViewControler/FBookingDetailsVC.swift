//
//  FBookingDetailsVC.swift
//  BabSafar
//
//  Created by FCI on 05/09/23.
//

import UIKit

class FBookingDetailsVC: BaseTableVC, EBookingViewModelDelegate {
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    static var newInstance: FBookingDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.FastTrack.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FBookingDetailsVC
        return vc
    }
    var tablerow = [TableRow]()
    var passengerName = String()
    var flightNo = String()
    var mobilno = String()
    var ccode = String()
    var terminal = String()
    var depTime = String()
    var depDate = String()
    var child = String()
    var adult = String()
    var price = String()
    var totalprice = String()
    var currency = String()
    var sku = String()
    var payload = [String:Any]()
    var from_plan_code = String()
    var to_plan_code = String()
    var totalAmount = 0
    var vm:EBookingViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
        if callapibool == true {
            callAPI()
        }
    }
    
    
    func callAPI() {
        holderView.isHidden = true
        if let selectedTab = defaults.object(forKey: UserDefaultsKeys.fasttrackJournyType) as? String  {
            
            if selectedTab == "quick" {
                callFastrackQuickBookingBookingAPI()
            }else {
                callFastrackExploreBookingAPI()
            }
            
        }else {
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = EBookingViewModel(self)
    }
    
    
    func setupUI() {
        nav.titlelbl.text = "Booking Details"
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtnAction), for: .touchUpInside)
        commonTableView.registerTVCells(["ExploreSummeryTVCell",
                                         "ExploreResultTVCell",
                                         "ExploreLeadPassengerTVCell",
                                         "EmptyTVCell",
                                         "SpecialRequestTVCell",
                                         "FasttrackFlightDeatilsTVCell",
                                         "FromLeadPassengerTVCell"])
        
        
        
        
        
    }
    
    @objc func didTapOnBackBtnAction() {
        callapibool = false
        NotificationCenter.default.post(name: NSNotification.Name("closefrombookingdetails"), object: nil)
        dismiss(animated: true)
    }
    
    
    override func editingTextField(tf:UITextField){
        switch tf.tag {
            
        case 111:
            passengerName = tf.text ?? ""
            break
            
        case 222:
            terminal = tf.text ?? ""
            break
            
        case 333:
            flightNo = tf.text ?? ""
            break
            
            
        case 444:
            mobilno = tf.text ?? ""
            break
            
        default:
            break
        }
    }
    
    
    
    //MARK: - ExploreLeadPassengerTVCell
    
    override func didTapOnAdultBtnAction(cell: ExploreLeadPassengerTVCell) {
        print(cell.adultlbl.text as Any)
    }
    
    override func didTapOnChildBtnAction(cell: ExploreLeadPassengerTVCell) {
        print(cell.childlbl.text)
    }
    
    override func didTapOnTerminalBtnAction(cell:ExploreLeadPassengerTVCell){
        print(cell.terminalTF.text)
    }
    
    override func donedatePicker(cell: ExploreLeadPassengerTVCell) {
        print(cell.depDateTF.text as Any)
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell: ExploreLeadPassengerTVCell) {
        self.view.endEditing(true)
    }
    
    override func doneTimePicker(cell: ExploreLeadPassengerTVCell) {
        print(cell.depTimeTF.text as Any)
        self.view.endEditing(true)
    }
    
    override func cancelTimePicker(cell: ExploreLeadPassengerTVCell) {
        self.view.endEditing(true)
    }
    
    
    
    
    //MARK: - FromLeadPassengerTVCell
    
    override func didTapOnAdultBtnAction(cell: FromLeadPassengerTVCell) {
        print(cell.adultlbl.text as Any)
    }
    
    override func didTapOnChildBtnAction(cell: FromLeadPassengerTVCell) {
        print(cell.childlbl.text as Any)
    }
    
    override func donedatePicker(cell: FromLeadPassengerTVCell) {
        print(cell.depDateTF.text as Any)
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell: FromLeadPassengerTVCell) {
        self.view.endEditing(true)
    }
    
    override func doneTimePicker(cell: FromLeadPassengerTVCell) {
        print(cell.depTimeTF.text as Any)
        self.view.endEditing(true)
    }
    
    override func cancelTimePicker(cell: FromLeadPassengerTVCell) {
        self.view.endEditing(true)
    }
    
    override func didTapOnTerminalBtnAction(cell: FromLeadPassengerTVCell) {
        
    }
    
    override func didTapOnCountryCodeBtn(cell:FromLeadPassengerTVCell){
        ccode = cell.countryCodeTF.text ?? ""
    }
    
    
    
    @IBAction func didTapOnProceedPaymentBtnAction(_ sender: Any) {
        paymentTap()
    }
    
    
    
}


extension FBookingDetailsVC {
    
    
    func callFastrackExploreBookingAPI() {
        payload.removeAll()
        payload["search_id"] = fsearch_id
        payload["booking_source"] = fbooking_source
        payload["plan_code"] = fplan_code
        
        vm?.CALL_EXPLORE_BOOKING_LIST_API(dictParam: payload)
    }
    
    
    func bookingDetails(response: EBookingModel) {
        holderView.isHidden = false
        adult18Array.removeAll()
        child2_7Array.removeAll()
        terminalArray.removeAll()
        adult18PriceArray.removeAll()
        
        eproduct_details = response.product_details
        sku = response.product_details?.data?.from?.sku ?? ""
        totalprice = "\(response.product_details?.data?.from?.price ?? 0)"
        currency = response.product_details?.data?.from?.currency ?? ""
        setAttributedText(str1: "\(currency):", str2: totalprice)
        
        response.product_details?.data?.from?.form_fields?.forEach({ i in
            if i.title == "Adults (18+ Years)" {
                i.options?.forEach({ j in
                    adult18Array.append(j.formatted_title ?? "")
                    adult18PriceArray.append("\(j.price ?? 0)")
                })
            }
            
            if i.title == "Child (2-17 Years)" {
                i.options?.forEach({ j in
                    child2_7Array.append(j.formatted_title ?? "")
                })
            }
            
            
            if i.title == "Available Airport Terminal" {
                i.options?.forEach({ j in
                    terminalArray.append(j.formatted_title ?? "")
                })
            }
            
            
        })
        
        DispatchQueue.main.async {
            self.setupExploreTV()
        }
    }
    
    
    func setupExploreTV() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:sku,
                                 subTitle: price,
                                 key:"booking",
                                 text: "\(currency):",
                                 headerText: totalprice,
                                 image: "",
                                 cellType:.ExploreResultTVCell))
        tablerow.append(TableRow(cellType:.ExploreLeadPassengerTVCell))
        tablerow.append(TableRow(title:"",key: "explore",cellType:.ExploreSummeryTVCell))
        tablerow.append(TableRow(key:"explore",cellType:.SpecialRequestTVCell))
        tablerow.append(TableRow(height:50,bgColor: .AppHolderViewColor,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
}



extension FBookingDetailsVC {
    
    
    func callFastrackQuickBookingBookingAPI() {
        payload.removeAll()
        
        quickServiceA.forEach { i in
            if i.serviceType == "dep" {
                from_plan_code = i.title
            }else {
                to_plan_code = i.title
            }
        }
        
        payload["search_id"] = fsearch_id
        payload["booking_source"] = fbooking_source
        payload["from_plan_code"] = from_plan_code
        payload["to_plan_code"] = to_plan_code
        
        vm?.CALL_Quick_BOOKING_LIST_API(dictParam: payload)
    }
    
    
    func quickbookingDetails(response: QBookingModel) {
        holderView.isHidden = false
        adult18Array.removeAll()
        child2_7Array.removeAll()
        terminalArray.removeAll()
        adult18PriceArray.removeAll()
        
        
        qproduct_details = response.product_details
        currency = response.product_details?.data?.from?.currency ?? ""
        
        
        response.product_details?.data?.from?.form_fields?.forEach({ i in
            if i.title == "Adult (18+ Years)" {
                i.options?.forEach({ j in
                    adult18Array.append(j.formatted_title ?? "")
                    adult18PriceArray.append("\(j.price ?? 0)")
                })
            }
            
            if i.title == "Child (2-17 Years)" {
                i.options?.forEach({ j in
                    child2_7Array.append(j.formatted_title ?? "")
                })
            }
            
            
            if i.title == "Terminal" {
                i.options?.forEach({ j in
                    terminalArray.append(j.formatted_title ?? "")
                })
            }
            
            
        })
        
        DispatchQueue.main.async {
            self.setupQuickBookingTV()
        }
    }
    
    
    
    func setupQuickBookingTV() {
        tablerow.removeAll()
        
        setupTotalAmount()
        tablerow.append(TableRow(cellType:.FasttrackFlightDeatilsTVCell))
        tablerow.append(TableRow(cellType:.FromLeadPassengerTVCell))
        tablerow.append(TableRow(title:"",key: "quick",cellType:.ExploreSummeryTVCell))
        tablerow.append(TableRow(key:"explore",cellType:.SpecialRequestTVCell))
        tablerow.append(TableRow(height:50,bgColor: .AppHolderViewColor,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
}



extension FBookingDetailsVC {
    func paymentTap() {
        
        
        print(passengerName)
        print(flightNo)
        print(terminal)
        print(adult)
        print(child)
        print(depDate)
        print(depTime)
    }
}



extension FBookingDetailsVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(closebtnindex), name: Notification.Name("closebtnindex"), object: nil)
        
    }
    
    
    
    @objc func closebtnindex(notify:NSNotification) {
        
        let indexToRemove = (notify.object as? Int) ?? 0
        
        if indexToRemove >= 0 && indexToRemove < quickServiceA.count {
            quickServiceA.remove(at: indexToRemove)
        }
        
        if quickServiceA.count > 0 {
            DispatchQueue.main.async {
                self.setupQuickBookingTV()
            }
        }else {
            gotoSearchFastTrackVC()
        }
    }
    
    
    func gotoSearchFastTrackVC(){
        callapibool = false
        guard let vc = SearchFastTrackVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
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
    
    
    func setupTotalAmount() {
        if quickServiceA.count == 1 {
            totalAmount = 0
            
            quickServiceA.forEach({ i in
                if i.serviceType == "dep" {
                    totalAmount = (qproduct_details?.data?.from?.price ?? 0) + totalAmount
                    
                }else {
                    totalAmount = (qproduct_details?.data?.to?.price ?? 0) + totalAmount
                    
                }
            })
        }
        
        if quickServiceA.count == 2 {
            totalAmount = 0
            
            quickServiceA.forEach({ i in
                if i.serviceType == "dep" {
                    totalAmount = (qproduct_details?.data?.from?.price ?? 0) + totalAmount
                }else {
                    totalAmount = (qproduct_details?.data?.to?.price ?? 0) + totalAmount
                }
            })
        }
        
        setAttributedText(str1: "\(currency):", str2: "\(totalAmount)")
        
        
    }
    
    
    func setAttributedText(str1:String,str2:String)  {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.WhiteColor,
                      NSAttributedString.Key.font:UIFont.LatoBold(size: 14)] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.WhiteColor,
                      NSAttributedString.Key.font:UIFont.LatoBold(size: 18)] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        pricelbl.attributedText = combination
        
    }
    
    
    
    
}
