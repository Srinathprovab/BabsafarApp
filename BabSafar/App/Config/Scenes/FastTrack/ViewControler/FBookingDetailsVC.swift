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
    var vm:EBookingViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        if callapibool == true {
            holderView.isHidden = true
            callFastrackExploreBookingAPI()
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
                                         "SpecialRequestTVCell"])
       
    }
    
    @objc func didTapOnBackBtnAction() {
        callapibool = false
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
            
        default:
            break
        }
    }
    
    
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
    
    
    
    
    func setAttributedText(str1:String,str2:String)  {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.WhiteColor,
                      NSAttributedString.Key.font:UIFont.LatoBold(size: 12)] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.WhiteColor,
                      NSAttributedString.Key.font:UIFont.LatoBold(size: 16)] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        pricelbl.attributedText = combination
        
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
        totalprice = response.product_details?.data?.from?.price ?? ""
        currency = response.product_details?.data?.from?.currency ?? ""
        setAttributedText(str1: "\(currency):", str2: totalprice)


         response.product_details?.data?.from?.form_fields?.forEach({ i in
             if i.title == "Adults (18+ Years)" {
                 i.options?.forEach({ j in
                     adult18Array.append(j.formatted_title ?? "")
                     adult18PriceArray.append(j.price ?? "")
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
        tablerow.append(TableRow(cellType:.ExploreSummeryTVCell))
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
