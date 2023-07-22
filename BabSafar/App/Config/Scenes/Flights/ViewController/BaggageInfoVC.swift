//
//  BaggageInfoVC.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit
import FreshchatSDK

class BaggageInfoVC: BaseTableVC, FlightDetailsViewModelProtocal, FDViewModelDelegate, FareRulesModelViewModelDelegate {
    func flightDetails(response: FlightDetailsModel) {
        
    }
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var itineraryCV: UICollectionView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var BookNowBtnView: UIView!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var chatBtnView: UIView!
    @IBOutlet weak var dropupimg: UIImageView!
    
    
    var lastContentOffset: CGFloat = 0
    
    static var newInstance: BaggageInfoVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BaggageInfoVC
        return vc
    }
    var isVCFrom = String()
    var tablerow = [TableRow]()
    var viewmodel : FlightDetailsViewModel?
    var viewmodel1 : FDViewModel?
    var payload = [String:Any]()
    var fdetails = [FDFlightDetails]()
    var itineraryArray = ["Itinerary","Fare Breakdown","Fare Rules","Baggage Info"]
    var adultsCount = Int()
    var childCount = Int()
    var infantsCount = Int()
    var fareRulesData = [FareRulesData]()
    var fareruleViewModel : FareRulesModelViewModel?
    var dropdownBool = true
    var jSummary = [JourneySummary]()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        hiddenView.isHidden = true
        chatBtnView.isHidden = true
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                
                
            }else if journeyType == "circle"{
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.rinfantsCount) ?? "0") ?? 0
            }else {
                
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "0") ?? 0
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        
        
        
        if callapibool == true {
            holderView.isHidden = true
            callApi()
        }
    }
    
    func callApi() {
        callGetFlightDetailsAPI()
    }
    
    
    func setupTVCells() {
        commonTableView.isHidden = false
        setupItineraryOneWayTVCell()
        
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    @objc func reloadTV() {
        callApi()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        // viewmodel = FlightDetailsViewModel(self)
        viewmodel1 = FDViewModel(self)
        fareruleViewModel = FareRulesModelViewModel(self)
        
    }
    
    
    func setupUI() {
        
        // self.view.backgroundColor = .black.withAlphaComponent(0.5)
        setupViews(v: holderView, radius: 8, color: .WhiteColor)
        setupViews(v: buttonsView, radius: 0, color: .WhiteColor)
        closeBtn.setTitle("", for: .normal)
        chatBtnView.isHidden = true
        setupViews(v: BookNowBtnView, radius: 0, color: .AppBtnColor)
        setuplabels(lbl: bookNowlbl, text: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""):", textcolor: .WhiteColor, font: .LatoBold(size: 18), align: .left)
        setuplabels(lbl: kwdlbl, text: "Book Now", textcolor: .WhiteColor, font: .LatoBold(size: 18), align: .right)
        bookNowBtn.setTitle("", for: .normal)
        dropupimg.image = UIImage(named: "dropup")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        
        defaults.set(0, forKey: UserDefaultsKeys.itinerarySelectedIndex)
        setupCV()
        
        commonTableView.isHidden = true
        commonTableView.registerTVCells(["ItineraryTVCell",
                                         "FareRulesTVCell",
                                         "BaggageInfoTVCell",
                                         "BookNowButtonsTVCell",
                                         "EmptyTVCell",
                                         "ItineraryAddTVCell",
                                         "CancellationFeesTVCell",
                                         "basefareTVCell",
                                         "NoteTVCell",
                                         "FareBreakdownTVCell",
                                         "FareBreakdownTitleTVCell",
                                         "TitleLblTVCell"])
        
        
    }
    
    
    func setupCV() {
        let nib = UINib(nibName: "ItineraryCVCell", bundle: nil)
        itineraryCV.register(nib, forCellWithReuseIdentifier: "cell")
        itineraryCV.delegate = self
        itineraryCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        itineraryCV.collectionViewLayout = layout
        itineraryCV.backgroundColor = .clear
        itineraryCV.layer.cornerRadius = 4
        itineraryCV.clipsToBounds = true
        itineraryCV.showsHorizontalScrollIndicator = false
        
    }
    
    
    
    func setupItineraryOneWayTVCell() {
        
        tablerow.removeAll()
        
        fd.forEach { i in
            tablerow.append(TableRow(title:"\(i.startIndex )",moreData:i,cellType:.ItineraryAddTVCell))
        }
        
        
        tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    func setupFareRulesOneWayTVCell() {
        self.commonTableView.estimatedRowHeight = 500
        self.commonTableView.rowHeight = 40
        
        tablerow.removeAll()
        
        fareRulehtml.forEach { i in
            tablerow.append(TableRow(title:i.rule_heading,subTitle: i.rule_content?.htmlToString,cellType:.FareRulesTVCell))
        }
        
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    //MARK: - show FARE RULES Content Btn Action
    override func showContentBtnAction(cell: FareRulesTVCell) {
        if dropdownBool == true {
            cell.show()
            dropdownBool = false
        }else {
            cell.hide()
            dropdownBool = true
        }
        
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    
    
    
    
    func setupFareBreakdownTVCells() {
        commonTableView.separatorColor = .clear
        tablerow.removeAll()
        
        
        //  tablerow.append(TableRow(cellType:.FareBreakdownTitleTVCell))
        
        if adultsCount > 0 && childCount == 0 && infantsCount == 0 {
            tablerow.append(TableRow(title:"Adult",subTitle: "X\(String(adultsCount))",text: Adults_Base_Price,headerText: sub_total_adult, buttonTitle:AdultsTotalPrice,tempText: Adults_Tax_Price,cellType:.FareBreakdownTVCell))
        }else if adultsCount > 0 && childCount > 0 && infantsCount == 0 {
            tablerow.append(TableRow(title:"Adult",subTitle: "X\(String(adultsCount))",text: Adults_Base_Price,headerText: sub_total_adult, buttonTitle:AdultsTotalPrice,tempText: Adults_Tax_Price,cellType:.FareBreakdownTVCell))
            
            tablerow.append(TableRow(title:"Child",subTitle: "X\(String(childCount))",text: Childs_Base_Price,headerText: sub_total_child, buttonTitle:ChildTotalPrice,tempText: Childs_Tax_Price,cellType:.FareBreakdownTVCell))
        }else if adultsCount > 0 && childCount == 0 && infantsCount > 0 {
            tablerow.append(TableRow(title:"Adult",subTitle: "X\(String(adultsCount))",text: Adults_Base_Price,headerText: sub_total_adult, buttonTitle:AdultsTotalPrice,tempText: Adults_Tax_Price,cellType:.FareBreakdownTVCell))
            tablerow.append(TableRow(title:"Infanta",subTitle: "X\(String(infantsCount))",text: Infants_Base_Price,headerText: sub_total_infant, buttonTitle:InfantTotalPrice,tempText: Infants_Tax_Price,cellType:.FareBreakdownTVCell))
        }else {
            tablerow.append(TableRow(title:"Adult",subTitle: "X\(String(adultsCount))",text: Adults_Base_Price,headerText: sub_total_adult, buttonTitle:AdultsTotalPrice,tempText: Adults_Tax_Price,cellType:.FareBreakdownTVCell))
            
            tablerow.append(TableRow(title:"Child",subTitle: "X\(String(childCount))",text: Childs_Base_Price,headerText: sub_total_child, buttonTitle:ChildTotalPrice,tempText: Childs_Tax_Price,cellType:.FareBreakdownTVCell))
            
            tablerow.append(TableRow(title:"Infanta",subTitle: "X\(String(infantsCount))",text: Infants_Base_Price,headerText: sub_total_infant, buttonTitle:InfantTotalPrice,tempText: Infants_Tax_Price,cellType:.FareBreakdownTVCell))
        }
        
        tablerow.append(TableRow(title:"Total Trip Cost",subTitle: totalprice,key: "totalcost",cellType:.TitleLblTVCell))
        tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    func setupBaggageInfoOneWayTVCell() {
        
        tablerow.removeAll()
        jSummary.forEach { j in
            tablerow.append(TableRow(title:"\(j.from_city ?? "")-\(j.to_city ?? "")",
                                     subTitle: j.cabin_baggage ?? "",
                                     buttonTitle: j.weight_Allowance ?? "",
                                     cellType:.BaggageInfoTVCell))
        }
        
        
        
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.7
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    
    @IBAction func didTapOnitCloseBtn(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnBookNowBtn(_ sender: Any) {
        guard let vc = BookingDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.totalPrice1 = totalprice
        callapibool = true
        self.present(vc, animated: true)
    }
    
    
    func callGetFlightDetailsAPI() {
        payload["search_id"] = defaults.string(forKey: UserDefaultsKeys.searchid)
        payload["selectedResultindex"] = defaults.string(forKey: UserDefaultsKeys.selectedResult)
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["booking_source"] = defaults.string(forKey: UserDefaultsKeys.bookingsourcekey) ?? "0"
        
        viewmodel1?.CALL_GET_FLIGHT_DETAILS_API(dictParam: payload)
        
    }
    
    
    func flightDetails(response: FDModel) {
        
        self.view.backgroundColor = .black.withAlphaComponent(0.50)
        holderView.isHidden = false
        
        fd = response.flightDetails ?? [[]]
        jd = response.journeySummary ?? []
        fareRulehtml = response.fareRulehtml ?? []
        totalprice = "\(response.priceDetails?.api_currency ?? "") : \(response.priceDetails?.grand_total ?? "")"
        self.bookNowlbl.text = totalprice
        grandTotal = totalprice
        farerulerefkey = response.fare_rule_ref_key ?? ""
        farerulesrefcontent = response.farerulesref_content ?? ""
        jSummary = response.journeySummary ?? []
        
        Adults_Base_Price = String(response.priceDetails?.adultsBasePrice ?? "0")
        Adults_Tax_Price = String(response.priceDetails?.adultsTaxPrice ?? "0")
        Childs_Base_Price = String(response.priceDetails?.childBasePrice ?? "0")
        Childs_Tax_Price = String(response.priceDetails?.childTaxPrice ?? "0")
        Infants_Base_Price = String(response.priceDetails?.infantBasePrice ?? "0")
        Infants_Tax_Price = String(response.priceDetails?.infantTaxPrice ?? "0")
        AdultsTotalPrice = String(response.priceDetails?.adultsTotalPrice ?? "0")
        ChildTotalPrice = String(response.priceDetails?.childTotalPrice ?? "0")
        InfantTotalPrice = String(response.priceDetails?.infantTotalPrice ?? "0")
        sub_total_adult = String(response.priceDetails?.sub_total_adult ?? "0")
        sub_total_child = String(response.priceDetails?.sub_total_child ?? "0")
        sub_total_infant = String(response.priceDetails?.sub_total_infant ?? "0")
        
        
        DispatchQueue.main.async {[self] in
            setupTVCells()
        }
        
        let seconds = 0.60
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.callFareRulesAPI()
        }
        
        
    }
    
    
    func callFareRulesAPI() {
        payload.removeAll()
        payload["fare_rule_ref_key"] = farerulerefkey
        payload["farerulesref_content"] = farerulesrefcontent
        fareruleViewModel?.CALL_GET_FARE_RULES_API(dictParam: payload)
    }
    
    
    
    
    func fareRulesDetails(response: FareRulesModel) {
        
        fareRulesData = response.data ?? []
        DispatchQueue.main.async {[self] in
            setupTVCells()
        }
    }
    
    
    
    func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.commonTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    
    @IBAction func didTapOnMoveToTopTapBtn(_ sender: Any) {
        commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
    @IBAction func didTapOnShowChatWindow(_ sender: Any) {
        Freshchat.sharedInstance().showConversations(self)
    }
    
    
    //MARK: - scrollViewDidScroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > self.lastContentOffset {
            // scrolling down
            if self.hiddenView.alpha == 1 {
                UIView.animate(withDuration: 0.3) {
                    self.hiddenView.alpha = 0
                    self.hiddenView.isHidden = true
                }
            }
        } else if scrollView.contentOffset.y < self.lastContentOffset {
            // scrolling up
            if self.hiddenView.alpha == 0 {
                UIView.animate(withDuration: 0.3) {
                    self.hiddenView.alpha = 1
                    self.hiddenView.isHidden = false
                }
            }
        }
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
}


extension BaggageInfoVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itineraryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ItineraryCVCell {
            cell.titlelbl.text = itineraryArray[indexPath.row]
            if indexPath.row == Int(defaults.integer(forKey: UserDefaultsKeys.itinerarySelectedIndex)) {
                cell.holderView.backgroundColor = .IttenarySelectedColor
                cell.titlelbl.textColor = .WhiteColor
                itineraryCV.selectItem(at: indexPath, animated: true, scrollPosition: .left)
            }
            commonCell = cell
        }
        return commonCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ItineraryCVCell {
            cell.holderView.backgroundColor = .IttenarySelectedColor
            cell.titlelbl.textColor = .WhiteColor
            commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            defaults.set(indexPath.row, forKey: UserDefaultsKeys.itinerarySelectedIndex)
            
            
            
            switch cell.titlelbl.text {
            case "Itinerary":
                setupItineraryOneWayTVCell()
                break
                
            case "Fare Breakdown":
                setupFareBreakdownTVCells()
                break
                
            case "Fare Rules":
                setupFareRulesOneWayTVCell()
                break
                
            case "Baggage Info":
                setupBaggageInfoOneWayTVCell()
                break
                
            default:
                break
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ItineraryCVCell {
            cell.holderView.backgroundColor = .WhiteColor.withAlphaComponent(0.40)
            cell.titlelbl.textColor = .AppLabelColor
            cell.holderView.backgroundColor = .WhiteColor
        }
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //  return CGSize(width: itineraryArray[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width + 25, height: 30)
        
        return CGSize(width: 120, height: 30)
    }
    
}


extension BaggageInfoVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FareRulesTVCell {
            cell.show()
        }
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FareRulesTVCell {
            cell.hide()
        }
        
    }
}
