//
//  FilterVC.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit

class FilterVC: BaseTableVC{
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var filterButtonsView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var sortbyBtnView: UIView!
    @IBOutlet weak var sortbyUL: UIView!
    @IBOutlet weak var filterUL: UIView!
    @IBOutlet weak var sortBylbl: UILabel!
    @IBOutlet weak var sortbyBtn: UIButton!
    @IBOutlet weak var filtersBtnView: UIView!
    @IBOutlet weak var filterslbl: UILabel!
    @IBOutlet weak var filtersBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    
    
    var stopsArray = ["0 Stop","1 Stop","1+ Stop"]
    var refundableTypeArray = ["Refundable ","Non Refundable"]
    var luggageArray = ["Cabin Baggage ","Checked Baggage "]
    var airlinesArray = ["Egypt Air (MS)","Emirates Airlines (EK)","Gulf Air (GF)","Emirates Airlines (EK)"]
    var classArray = ["Economy","Permium Economy","Bussiness","First Class"]
    var tablerow = [TableRow]()
    var filterKey = String()
    
    var free_airport_shuttleArray = ["Free Ariport Shuttle","All Inclusive","Facilities"]
    var guestRating = ["Wonderful 4.5+","Very good 4+","Good 3.5+","Average 3+","Poor 4.5+"]
    var guestRating1 = ["Fully Refundable","Reserve Now , Pay Later"]
    var  healthsafetyArray = ["only show stay with enhanced health & safety measures"]
    var badPreference = ["Twin Beds","Double Bed"]
    var brands = ["Maison Privee","Jumeirah","Rove hotels"]
    var accessibilityFeatures = ["Accessibility Equipment","Accessible Bathroom","Accessible Path Of Travel"]
    var distance_from_center = [String]()
    var noOverNightFlightArray = ["No"]
    var connectingflights = ["Saudi Arabian Airlines(SV)","Qatar Airways(QR)","Gulf Air Company(GF)","Etlhad Airways(EY)"]
    var connectingAirports = ["Riyadh(RUH)","Jeddah(JED)","Doha(DOH)","Bahrain(bAH)"]
    
    
    var paymentTypeArray = ["Refundable","Non Refundable"]
    var badPreferenceArray = ["Twin Beds","Double Bed"]
    var amenitiesArray = ["24 Hour Front Desk","Adults Only","Air Conditioned"]
    var neighbourhoodArray = ["Deira","Dubai","Jebel ali","Jumeirah"]
    var accommodationArray = ["Hotel"]
    static var newInstance: FilterVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FilterVC
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        if let tabSelected = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if tabSelected == "flights" {
                setupSortByTVCells()
            }else {
                setupHotelsSortByTVCells()
            }
        }
    }
    
    
    func setupUI() {
        
        self.view.backgroundColor = .black.withAlphaComponent(0.3)
        setupViews(v: holderView, radius: 10, color: .WhiteColor)
        holderView.layer.borderColor = UIColor.WhiteColor.cgColor
        setupViews(v: filterButtonsView, radius: 0, color: .WhiteColor)
        filterButtonsView.addBottomBorderWithColor(color: .AppBorderColor, width: 1)
        setupViews(v: sortbyBtnView, radius: 0, color: .WhiteColor)
        setupViews(v: filtersBtnView, radius: 0, color: .WhiteColor)
        setupViews(v: sortbyUL, radius: 0, color: .AppTabSelectColor)
        setupViews(v: filterUL, radius: 0, color: .WhiteColor)
        setupLabels(lbl: sortBylbl, text: "Sort By", textcolor: .AppLabelColor, font: .LatoRegular(size: 18))
        setupLabels(lbl: filterslbl, text: "Filters", textcolor: .SubTitleColor, font: .LatoRegular(size: 18))
        closeBtn.setTitle("", for: .normal)
        sortbyBtn.setTitle("", for: .normal)
        filtersBtn.setTitle("", for: .normal)
        filterKey = "sort"
        resetBtn.setTitle("Reset", for: .normal)
        resetBtn.titleLabel?.textColor = .AppTabSelectColor
        resetBtn.titleLabel?.font = UIFont.LatoRegular(size: 16)
        commonTableView.registerTVCells(["CheckBoxTVCell","EmptyTVCell","SortbyTVCell","ButtonTVCell","DoubleSliderTVCell","PopularFiltersTVCell","LabelTVCell","SliderTVCell","FilterDepartureTVCell"])
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.WhiteColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    func setupFilterTVCells() {
        commonTableView.isScrollEnabled = true
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Price",cellType:.SliderTVCell))
        tablerow.append(TableRow(title:"Stops",data: stopsArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Refundable Type",data: refundableTypeArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Luggage",data: luggageArray,cellType:.CheckBoxTVCell))
        
        tablerow.append(TableRow(title:"Duration",cellType:.SliderTVCell))
        tablerow.append(TableRow(title:"Transit Time",cellType:.SliderTVCell))
        
        tablerow.append(TableRow(title:"Departure Time",cellType:.FilterDepartureTVCell))
        tablerow.append(TableRow(title:"Arrival Time",cellType:.FilterDepartureTVCell))
        tablerow.append(TableRow(title:"No Overnight Flight",data: noOverNightFlightArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Airlines",data: airlinesArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Connecting Flights",data: connectingflights,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Connecting Airports",data: connectingAirports,cellType:.CheckBoxTVCell))
        
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Apply",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    func setupSortByTVCells() {
        commonTableView.isScrollEnabled = false
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Price",key: "reset",cellType:.SortbyTVCell))
        tablerow.append(TableRow(title:"Star",key: "no",cellType:.SortbyTVCell))
        tablerow.append(TableRow(title:"Arrival Time",key: "no",cellType:.SortbyTVCell))
        tablerow.append(TableRow(title:"Duration",key: "no",cellType:.SortbyTVCell))
        tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Done",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    func setupHotelsFilterTVCells() {
        
        
        commonTableView.isScrollEnabled = true
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Free Airport Shuttle",data: free_airport_shuttleArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Price",cellType:.SliderTVCell))
        tablerow.append(TableRow(cellType:.PopularFiltersTVCell))
        tablerow.append(TableRow(title:"Guest Rating",data: guestRating,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Payment Type",data: paymentTypeArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Bad Preference",data: badPreference,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Brands",data: brands,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Amenities",data: amenitiesArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Neighbourhood",data: neighbourhoodArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Accommodation",data: accommodationArray,cellType:.CheckBoxTVCell))
        
        tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Apply",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    func setupHotelsSortByTVCells() {
        commonTableView.isScrollEnabled = false
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Price",key: "",cellType:.SortbyTVCell))
        tablerow.append(TableRow(title:"Star",key: "no",cellType:.SortbyTVCell))
        
        tablerow.append(TableRow(height:380,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Done",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    override func btnAction(cell: ButtonTVCell) {
        if filterKey == "filter" {
            print(filterKey)
        }else {
            print(filterKey)
        }
    }
    
    
    override func didTapOnShowMoreBtn(cell:CheckBoxTVCell){
        
        
        switch cell.titlelbl.text {
        case "Airlines":
            airlinesArray = ["Egypt Air (MS)","Emirates Airlines (EK)","Gulf Air (GF)","Egypt Air (MS)","Emirates Airlines (EK)","Gulf Air (GF)"]
            cell.nameArray = airlinesArray
            break
            
        default:
            break
        }
        cell.btnView.isHidden = true
        cell.btnViewHeight.constant = 0
        cell.checkOptionsTV.reloadData()
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
        
    }
    
    
    override func didTapOnOneRatingViewBtn(cell: PopularFiltersTVCell) {
        print("didTapOnOneRatingViewBtn")
    }
    override func didTapOnTwoRatingViewBtn(cell: PopularFiltersTVCell) {
        print("didTapOnTwoRatingViewBtn")
    }
    override func didTapOnThreeatingViewBtn(cell: PopularFiltersTVCell) {
        print("didTapOnThreeatingViewBtn")
    }
    override func didTapOnFouratingViewBtn(cell: PopularFiltersTVCell) {
        print("didTapOnFouratingViewBtn")
    }
    override func didTapOnFivetingViewBtn(cell: PopularFiltersTVCell) {
        print("didTapOnFivetingViewBtn")
    }
    
    override func didTapOnLowtoHighBtn(cell: SortbyTVCell) {
        cell.lowtoHighlbl.textColor = .WhiteColor
        cell.lowtoHighView.backgroundColor = .AppCalenderDateSelectColor
        cell.hightoLowhlbl.textColor = .AppLabelColor
        cell.hightoLowView.backgroundColor = .WhiteColor
    }
    
    override func didTapOnHightoLowBtn(cell: SortbyTVCell) {
        cell.lowtoHighlbl.textColor = .AppLabelColor
        cell.lowtoHighView.backgroundColor = .WhiteColor
        cell.hightoLowhlbl.textColor = .WhiteColor
        cell.hightoLowView.backgroundColor = .AppCalenderDateSelectColor
    }
    
    
    func resetSortBy(cell:SortbyTVCell) {
        
        cell.lowtoHighlbl.textColor = .AppLabelColor
        cell.lowtoHighView.backgroundColor = .WhiteColor
        cell.hightoLowhlbl.textColor = .AppLabelColor
        cell.hightoLowView.backgroundColor = .WhiteColor
    }
    
    @IBAction func didTapOnResetBtn(_ sender: Any) {
        if filterKey == "filter" {
            if let tabSelected = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
                if tabSelected == "flights" {
                    
                }else {
                    
                }
            }
        }else {
            if let tabSelected = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
                if tabSelected == "flights" {
                    if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                        resetSortBy(cell: cell1)
                    }
                    if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                        resetSortBy(cell: cell2)
                    }
                    
                    if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortbyTVCell {
                        resetSortBy(cell: cell3)
                    }
                    if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortbyTVCell {
                        resetSortBy(cell: cell4)
                    }
                    
                }else {
                    if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                        resetSortBy(cell: cell1)
                    }
                    if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                        resetSortBy(cell: cell2)
                    }
                    
                }
            }
        }
    }
    
    
    
    @IBAction func didTapOnCloseBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
   // var sliderBool = true
//    override func didTapOnShowSliderBtn(cell: SliderTVCell) {
//
//        if sliderBool == true {
//            cell.sliderViewHeight.constant = 112
//            cell.rangeSlider.isHidden = false
//            sliderBool = false
//        }else {
//            cell.sliderViewHeight.constant = 0
//            cell.rangeSlider.isHidden = true
//            sliderBool = true
//        }
//        commonTableView.reloadRows(at: [IndexPath(item: cell.indexPath?.row ?? 0, section: 0)], with: .automatic)
//    }
    
    @IBAction func didTapOnSortByBtn(_ sender: Any) {
        sortbyTap()
    }
    
    func sortbyTap() {
        filterKey = "sortby"
        sortBylbl.textColor = .AppTabSelectColor
        sortbyUL.backgroundColor = .AppTabSelectColor
        filterslbl.textColor = .SubTitleColor
        filterUL.backgroundColor = .WhiteColor
        
        
        if let tabSelected = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if tabSelected == "flights" {
                setupSortByTVCells()
            }else {
                setupHotelsSortByTVCells()
            }
        }
    }
    
    
    
    
    @IBAction func didTapOnFiltersBtn(_ sender: Any) {
        filtertap()
    }
    
    
    func filtertap() {
        filterKey = "filter"
        sortBylbl.textColor = .SubTitleColor
        sortbyUL.backgroundColor = .WhiteColor
        filterslbl.textColor = .AppTabSelectColor
        filterUL.backgroundColor = .AppTabSelectColor
        
        if let tabSelected = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if tabSelected == "flights" {
                setupFilterTVCells()
            }else {
                setupHotelsFilterTVCells()
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            tableView.performBatchUpdates(nil)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CheckBoxTVCell {
            cell.hide()
        }else if let cell = tableView.cellForRow(at: indexPath) as? FilterDepartureTVCell {
            cell.hide()
        }else if let cell = tableView.cellForRow(at: indexPath) as? SliderTVCell {
            cell.hide()
        }
    }
    
}
