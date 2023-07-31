//
//  SearchHotelsResultVC.swift
//  BabSafar
//
//  Created by MA673 on 29/07/22.
//

import UIKit
import DropDown

class SearchHotelsResultVC: BaseTableVC, UITextFieldDelegate, HotelSearchViewModelDelegate {
   
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navView: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var cvHolderView: UIView!
    @IBOutlet weak var recommandedView: UIView!
    @IBOutlet weak var downimg: UIImageView!
    @IBOutlet weak var recommandedlbl: UILabel!
    @IBOutlet weak var recommandedbtn: UIButton!
    @IBOutlet weak var filterBtnView: UIView!
    @IBOutlet weak var filterImg: UIImageView!
    @IBOutlet weak var filterlbl: UILabel!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var dropupimg: UIImageView!
    @IBOutlet weak var moveUpBtn: UIButton!
    @IBOutlet weak var hiddenView: UIView!
    
    let dropDown = DropDown()
    var lastContentOffset: CGFloat = 0
    var tablerow = [TableRow]()
    var filtered = [HotelSearchResult]()
    var isSearchBool = false
    var searchText = String()
    let refreshControl = UIRefreshControl()
    var isvcfrom = String()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var countrycode = String()
    var isLoadingData = false
    var viewModel:HotelSearchViewModel?
    
    static var newInstance: SearchHotelsResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotels.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SearchHotelsResultVC
        return vc
    }
    
    
    //MARK: - somthingwentwrong
    @objc func somthingwentwrong() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "noresult"
        self.present(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(somthingwentwrong), name: Notification.Name("somthingwentwrong"), object: nil)
        
        if callapibool == true{
            holderView.isHidden = true
            callAPI()
        }
    }
    
    
    
    
    
    func setupinitialView() {
        
        setupUI()
        commonTableView.register(UINib(nibName: "HotelsTVCell", bundle: nil), forCellReuseIdentifier: "cell44")
        
        if screenHeight < 835 {
            navHeight.constant = 130
        }
        filtered = hotelSearchResult
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupinitialView()
        setupRefreshControl()
        viewModel = HotelSearchViewModel(self)
        //setuptv()
        
    }
    
    //MARK: - setupRefreshControl
    func setupRefreshControl(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        commonTableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        // Code to refresh table v
        isSearchBool = false
        commonTableView.reloadData()
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            // Put your code which should be executed with a delay here
            self.refreshControl.endRefreshing()
        }
    }
    
    
    
    func setupUI() {
        navView.titlelbl.text = ""
        navView.filterBtnView.isHidden = false
        navView.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        navView.titlelbl.text = ""
        
        setuplabels(lbl: navView.lbl1, text: defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "", textcolor: .WhiteColor, font: .LatoMedium(size: 18), align: .center)
        setuplabels(lbl: navView.lbl2, text: "Checkin:\(defaults.string(forKey: UserDefaultsKeys.checkin) ?? "") | Checkout:\(defaults.string(forKey: UserDefaultsKeys.checkout) ?? "")", textcolor: .WhiteColor, font: .LatoLight(size: 14), align: .center)
        
        
        navView.editBtnView.isHidden = true
        navView.filterBtnView.isHidden = false
        navView.filterBtn.addTarget(self, action: #selector(didTapOnEditBtn(_:)), for: .touchUpInside)
        navView.filterImg.image = UIImage(named: "edit1")?.withRenderingMode(.alwaysOriginal)
        navView.lbl1.isHidden = false
        navView.lbl2.isHidden = false
        cvHolderView.isHidden = true
        
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        cvHolderView.backgroundColor = .WhiteColor
        cvHolderView.addBottomBorderWithColor(color: .AppBorderColor, width: 1)
        downimg.image = UIImage(named: "down")?.withRenderingMode(.alwaysOriginal)
        recommandedbtn.setTitle("", for: .normal)
        setuplabels(lbl: recommandedlbl, text: "Recomanded", textcolor: .AppTabSelectColor, font: .LatoBold(size: 16), align: .right)
        filterImg.image = UIImage(named: "filter1")?.withRenderingMode(.alwaysOriginal)
        filterBtn.setTitle("", for: .normal)
        setuplabels(lbl: filterlbl, text: "FILTER", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .left)
        
        commonTableView.backgroundColor = .WhiteColor
        hiddenView.isHidden = true
        hiddenView.backgroundColor = .AppBtnColor
        hiddenView.addCornerRadiusWithShadow(color: .lightGray, borderColor: .clear, cornerRadius: 4)
        dropupimg.image = UIImage(named: "dropup")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        moveUpBtn.setTitle("", for: .normal)
        filterBtn.addTarget(self, action: #selector(didTapOnFilterBtnAction(_:)), for: .touchUpInside)
        recommandedbtn.addTarget(self, action: #selector(didTapOnSortBtnAction(_:)), for: .touchUpInside)
        setupDropDown()
    }
    
    
    func setupDropDown() {
        
        dropDown.direction = .any
        dropDown.backgroundColor = .WhiteColor
        dropDown.dataSource = ["Price (Low to High)","Price (High to Low)","Hotel Name(A to Z)","Hotel Name(Z to A)"]
        dropDown.anchorView = self.recommandedbtn
        dropDown.bottomOffset = CGPoint(x: 0, y: recommandedbtn.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            print(item)
            
            switch item {
            case "Price (Low to High)":
                self?.filtersSortByApplied(sortBy: .PriceLow)
                break
                
            case "Price (High to Low)":
                self?.filtersSortByApplied(sortBy: .PriceHigh)
                break
                
            case "Hotel Name(A to Z)":
                self?.filtersSortByApplied(sortBy: .airlinessortatoz)
                break
                
            case "Hotel Name(Z to A)":
                self?.filtersSortByApplied(sortBy: .airlinessortztoa)
                break
                
            default:
                break
            }
        }
    }
    
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        // dismiss(animated: true)
        
        callapibool = false
        if isvcfrom == "dashboard" {
            guard let vc = DashBoaardTabbarVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            vc.selectedIndex = 0
            self.present(vc, animated: false)
        }else {
            guard let vc = SearchHotelsVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            vc.isFromvc = "hotelvc"
            self.present(vc, animated: false)
        }
    }
    
    
    @objc func didTapOnEditBtn(_ sender:UIButton){
        
        if let tabSelected = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if tabSelected == "flights" {
                guard let vc = SearchFlightsVC.newInstance.self else {return}
                vc.modalPresentationStyle = .overCurrentContext
                present(vc, animated: true)
            }else {
                guard let vc = ModifySearchHotelVC.newInstance.self else {return}
                vc.modalPresentationStyle = .overCurrentContext
                present(vc, animated: true)
            }
        }
        
        
    }
    
    override func viewBtnAction(cell: CommonFromCityTVCell) {
        print(cell.subtitlelbl.text as Any)
    }
    
    override func didTapOnDual1Btn(cell:CommonFromCityTVCell){
        print(cell.dual1lbl2.text)
    }
    override func didTapOnDual2Btn(cell:CommonFromCityTVCell){
        print(cell.dual2lbl2.text)
    }
    
    
    @objc func editingTextField1(_ tf: UITextField) {
        searchText = tf.text ?? ""
        
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText)
        }else {
            isSearchBool = true
            filterContentForSearchText(searchText)
            
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        filtered.removeAll()
        filtered = hotelSearchResult.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        commonTableView.reloadData()
    }
    
    
    override func mapViewBtnAction(cell:SearchLocationTFTVCell){
        print("mapViewBtnAction ..")
    }
    
    
    override func didTapOnRefundableBtn(cell: HotelsTVCell) {
        print("didTapOnRefundableBtn")
    }
    
    
    override func didTapOnLocationBtnAction(cell: HotelsTVCell){
        
        guard let vc = MapViewVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        vc.lat = Double(cell.lat) ?? 0.0
        vc.long = Double(cell.long) ?? 0.0
        vc.annotationtitle = cell.hotelNamelbl.text ?? ""
        present(vc, animated: true)
        
    }
    
    func goToHotelDetailsVC(hid:String,bs:String,kwdprice:String) {
        guard let vc = HotelDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.hotelid = hid
        vc.bookingsource = bs
        vc.kwdprice = kwdprice
        callapibool = true
        present(vc, animated: true)
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
    
    @IBAction func didTapOnMoveUpScreenBtn(_ sender: Any) {
        commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        self.hiddenView.isHidden = true
    }
    
    
    @objc func didTapOnFilterBtnAction(_ sender:UIButton) {
        gotoFilterVC(strkey: "hotelfilter")
    }
    
    
    @objc func didTapOnSortBtnAction(_ sender:UIButton) {
        dropDown.show()
    }
    
    func gotoFilterVC(strkey:String) {
        guard let vc = FilterVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        vc.filterKey = strkey
        present(vc, animated: true)
    }
    
}


extension SearchHotelsResultVC {
    
    
    func callAPI() {
        
        loderBool = true
        do {
            
            let arrJson = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
            let theJSONText = NSString(data: arrJson, encoding: String.Encoding.utf8.rawValue)
            print(theJSONText ?? "")
            payload1["search_params"] = theJSONText
            payload1["offset"] = "0"
            payload1["limit"] = "20"
            viewModel?.CallHotelSearchAPI(dictParam: payload1)
            
        }catch let error as NSError{
            print(error.description)
        }
        
    }
    
    
    
    
    
    func hoteSearchResult(response: HotelSearchModel) {
        navView.isHidden = false
        filterBtnView.isHidden = false
        commonTableView.isHidden = false
        cvHolderView.isHidden = false
        loderBool = false
        holderView.isHidden = false
        
        hotelSearchId = String(response.search_id ?? 0)
        hsearchid = String(response.search_id ?? 0)
        hbookingsource = response.booking_source ?? ""
        hotelSearchResult = response.data?.hotelSearchResult ?? []
        
        
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //check search text & original text
        if( isSearchBool == true){
            return filtered.count
        }else{
            return hotelSearchResult.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell44", for: indexPath) as? HotelsTVCell{
            cell.selectionStyle = .none
            cell.delegate = self
            
            if( isSearchBool == true){
                let dict = filtered[indexPath.row]
                
                cell.hotelNamelbl.text = dict.name
                cell.hotelImg.sd_setImage(with: URL(string: dict.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                cell.ratingslbl.text = String(dict.star_rating ?? 0)
                cell.locationlbl.text = dict.address
                cell.refundablelbl.text = dict.refund
                cell.kwdlbl.text = "\(dict.currency ?? ""):\(dict.price ?? "")"
                cell.bookingsource = dict.booking_source ?? ""
                cell.hotelid = String(dict.hotel_code ?? 0)
                cell.lat = dict.latitude ?? ""
                cell.long = dict.longitude ?? ""
                cell.facilityArray = dict.facility ?? []
                cell.facilityCV.reloadData()
                ccell = cell
            }else{
                let dict = hotelSearchResult[indexPath.row]
                
                cell.hotelNamelbl.text = dict.name
                cell.hotelImg.sd_setImage(with: URL(string: dict.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                cell.ratingslbl.text = String(dict.star_rating ?? 0)
                cell.locationlbl.text = dict.address
                cell.refundablelbl.text = dict.refund
                cell.kwdlbl.text = "\(dict.currency ?? ""):\(dict.price ?? "")"
                cell.bookingsource = dict.booking_source ?? ""
                cell.hotelid = String(dict.hotel_code ?? 0)
                cell.lat = dict.latitude ?? ""
                cell.long = dict.longitude ?? ""
                cell.facilityArray = dict.facility ?? []
                cell.facilityCV.reloadData()
                ccell = cell
            }
        }
        
        return ccell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? HotelsTVCell {
            self.goToHotelDetailsVC(hid: cell.hotelid, bs: cell.bookingsource, kwdprice: cell.kwdlbl.text ?? "")
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}


extension SearchHotelsResultVC:AppliedFilters{
    func filtersByApplied(minpricerange: Double, maxpricerange: Double, noofStopsArray: [String], refundableTypeArray: [String], departureTime: String, arrivalTime: String, noOvernightFlight: String, airlinesFilterArray: [String], connectingFlightsFilterArray: [String], ConnectingAirportsFilterArray: [String]) {
        
    }
    
    
    
    
    
    
    //MARK: - SORT BY FILTER
    func filtersSortByApplied(sortBy: SortParameter) {
        commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        switch sortBy {
            
        case .PriceLow:
            print("PriceLow")
            isSearchBool = true
            
            filtered = hotelSearchResult.sorted { $0.price ?? "0" < $1.price ?? "0" }
            
            DispatchQueue.main.async {[self] in
                commonTableView.reloadData()
            }
            break
            
            
        case .PriceHigh:
            print("PriceHigh")
            isSearchBool = true
            filtered = hotelSearchResult.sorted { $0.price ?? "0" > $1.price ?? "0" }
            DispatchQueue.main.async {[self] in
                commonTableView.reloadData()
            }
            break
            
            
        case .airlinessortatoz:
            
            isSearchBool = true
            filtered = hotelSearchResult.sorted { $0.name ?? "" < $1.name ?? "" }
            DispatchQueue.main.async {[self] in
                commonTableView.reloadData()
            }
            break
            
            
        case .airlinessortztoa:
            isSearchBool = true
            
            filtered = hotelSearchResult.sorted { $0.name ?? "" > $1.name ?? "" }
            DispatchQueue.main.async {[self] in
                commonTableView.reloadData()
            }
            break
            
            
            
        default:
            break
        }
    }
    
    
}


extension SearchHotelsResultVC {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex && !isLoadingData {
            callHotelSearchPaginationAPI()
        }
    }
    
    func callHotelSearchPaginationAPI() {
        print("You've reached the last cell, trigger the API call.")

        payload.removeAll()
        payload["booking_source"] = hbookingsource
        payload["search_id"] = hsearchid
        payload["offset"] = "41"
        payload["limit"] = "5"
        payload["no_of_nights"] = "1"
        
       // viewModel?.CallHotelSearchPagenationAPI(dictParam: payload)
        
    }
    
    func hoteSearchPagenationResult(response: HotelSearchModel) {
        
        hotelSearchResult = response.data?.hotelSearchResult ?? []
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
        
    }
    
}
