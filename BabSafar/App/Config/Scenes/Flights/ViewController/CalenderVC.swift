//
//  CalenderVC.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit
import JTAppleCalendar


class CalenderVC: BaseTableVC {
    
    @IBOutlet weak var banerImage: UIImageView!
    @IBOutlet weak var backBtnView: UIView!
    @IBOutlet weak var leftArrowImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var departureView: UIView!
    @IBOutlet weak var departurelbl: UILabel!
    @IBOutlet weak var departureDatelbl: UILabel!
    @IBOutlet weak var returnView: UIView!
    @IBOutlet weak var returnlbl: UILabel!
    @IBOutlet weak var returnDatelbl: UILabel!
    @IBOutlet weak var selectBtnView: UIView!
    @IBOutlet weak var selectlbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarViewHolder: UIView!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
  //  @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var sundayLabel: UILabel!
    @IBOutlet weak var mondayLabel: UILabel!
    @IBOutlet weak var tuesdayLabel: UILabel!
    @IBOutlet weak var thursdayLabel: UILabel!
    @IBOutlet weak var wednesdayLabel: UILabel!
    @IBOutlet weak var fridayLabel: UILabel!
    @IBOutlet weak var saturdayLabel: UILabel!
    @IBOutlet weak var selectBtn: UIButton!
    
    
    static var newInstance: CalenderVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CalenderVC
        return vc
    }
    
    var titleStr: String?
    var selectedfirstDate : Date?
    var selectedlastDate : Date?
    let df = DateFormatter()
    var startDate = Date().dateByAddingMonths(months: -12).startOfMonth
    var endDate = Date().dateByAddingMonths(months: 12).endOfMonth
    var selectedDays: Date?
    let grayView = UIView()
    var btnDoneActionBool = Bool()
    var calstartDate = String()
    var calendDate = String()
    var celltag = Int()
    var depDay = String()
    var retDay = String()
    
    
    override func viewWillDisappear(_ animated: Bool) {
        callapibool = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        setupinitialUI()
    }
    
    
    func setupinitialUI() {
        
        self.celltag = Int(defaults.string(forKey: UserDefaultsKeys.cellTag) ?? "0") ?? 0
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if selectedTab == "Flights" {
                
                if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                    if journeyType == "oneway" {
                        calendarView.allowsMultipleSelection = false
                        departureDatelbl.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "Select Date"
                        returnView.isHidden = true
                        depDay = convertDateFormat(inputDate: departureDatelbl.text ?? "", f1: "dd-MM-yyyy", f2: "dd")
                        
                    }else if journeyType == "circle"{
                        calendarView.allowsMultipleSelection = true
                        departureDatelbl.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "Select Date"
                        returnDatelbl.text = defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "Select Date"
                        
                        depDay = convertDateFormat(inputDate: departureDatelbl.text ?? "", f1: "dd-MM-yyyy", f2: "dd")
                        retDay = convertDateFormat(inputDate: returnDatelbl.text ?? "", f1: "dd-MM-yyyy", f2: "dd")
                    }else {
                        
                        
                        calendarView.allowsMultipleSelection = false
                        departureView.isHidden = true
                        returnView.isHidden = true
                        depDay = convertDateFormat(inputDate: departureDatelbl.text ?? "", f1: "dd-MM-yyyy", f2: "dd")
                        
                    }
                }
                
            }else {
                
                calendarView.allowsMultipleSelection = true
                departurelbl.text = "Check-In"
                returnlbl.text = "Check -Out"
                
                departureDatelbl.text = defaults.string(forKey: UserDefaultsKeys.checkin) ?? "Select Date"
                returnDatelbl.text = defaults.string(forKey: UserDefaultsKeys.checkout) ?? "Select Date"
                
                depDay = convertDateFormat(inputDate: departureDatelbl.text ?? "", f1: "dd-MM-yyyy", f2: "dd")
                retDay = convertDateFormat(inputDate: returnDatelbl.text ?? "", f1: "dd-MM-yyyy", f2: "dd")
                
                
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
        setupinitialUI()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        updateUI()
        setupCalView()
    }
    
    func setupUI() {
        
        selectBtn.setTitle("", for: .normal)
        leftArrowImg.image = UIImage(named: "leftarrow")
        banerImage.image = UIImage(named: "baner")
        banerImage.contentMode = .scaleToFill
        setupViews(v: backBtnView, radius: 20, color: .WhiteColor.withAlphaComponent(0.2))
        setupLabels(lbl:titlelbl,text: titleStr ?? "", textcolor: .WhiteColor, font: .LatoMedium(size: 20))
        setupViews(v: departureView, radius: 4, color: .WhiteColor)
        setupViews(v: returnView, radius: 4, color: .WhiteColor)
        setupViews(v: selectBtnView, radius: 4, color: .AppBtnColor)
        setupLabels(lbl: departurelbl, text: "Departure ", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: departureDatelbl, text: "26-07-2022", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16))
        setupLabels(lbl: returnlbl, text: "Return ", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: returnDatelbl, text: "26-07-2022", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16))
        setupLabels(lbl: selectlbl, text: "Select", textcolor: .WhiteColor, font: .LatoSemibold(size: 20))
        
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.5
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    func updateUI() {
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: monthLabel, text: "", textcolor: .AppLabelColor, font: .LatoBold(size: 18), align: .left)
        setuplabels(lbl: sundayLabel, text: "SU", textcolor: HexColor("#555555"), font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: mondayLabel, text: "MO", textcolor: HexColor("#555555"), font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: tuesdayLabel, text: "TU", textcolor: HexColor("#555555"), font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: wednesdayLabel, text: "WE", textcolor: HexColor("#555555"), font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: thursdayLabel, text: "TH", textcolor: HexColor("#555555"), font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: fridayLabel, text: "FR", textcolor: HexColor("#555555"), font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: saturdayLabel, text: "SA", textcolor: HexColor("#555555"), font: .LatoRegular(size: 14), align: .center)
        
    }
    
    
    func setupCalView() {
        
        
        calendarViewHolder.backgroundColor = .clear
        
        // Do any additional setup after loading the view.
        calendarView.scrollDirection  = .vertical
        calendarView.scrollingMode = .stopAtEachSection
        calendarView.showsHorizontalScrollIndicator = false
        
        
        
        calendarView.scrollToDate(Date(),animateScroll: false)
        
        calendarView.register(UINib(nibName: "calendarCVCell", bundle: nil), forCellWithReuseIdentifier: "calendarCVCell")
        //        calendarView.allowsSelection = true
        calendarView.isRangeSelectionUsed = true
        
        calendarView.ibCalendarDelegate = self
        calendarView.ibCalendarDataSource = self
        calendarView.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        calendarView.minimumLineSpacing = 10
        calendarView.minimumInteritemSpacing = 10
        
        
        
        calendarView.visibleDates { (visibleDates) in
            self.setupMonthLabel(date: visibleDates.monthDates.first?.date ?? Date())
        }
        
        let panGensture = UILongPressGestureRecognizer(target: self, action: #selector(didStartRangeSelecting(gesture:)))
        panGensture.minimumPressDuration = 0.5
        calendarView.addGestureRecognizer(panGensture)
        
    }
    
    
    @objc func didStartRangeSelecting(gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: gesture.view!)
        let rangeSelectedDates = calendarView.selectedDates
        
        guard let cellState = calendarView.cellStatus(at: point) else { return }
        
        if !rangeSelectedDates.contains(cellState.date) {
            let dateRange = calendarView.generateDateRange(from: rangeSelectedDates.first ?? cellState.date, to: cellState.date)
            calendarView.selectDates(dateRange, keepSelectionIfMultiSelectionAllowed: true)
        }
    }
    
    func setupMonthLabel(date: Date) {
        monthLabel.text = date.monthYearName
    }
    
    
    func handleConfiguration(cell: JTAppleCell?, cellState: CellState) {
        guard let cell = cell as? calendarCVCell else { return }
        handleCellColor(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState)
        
        if calendarView.selectedDates.count == 0 {
            
        }else if calendarView.selectedDates.count == 1 {
            
            calstartDate = "\(cellState.date.customDateStringFormat("dd-MM-YYYY"))"
            calendDate = "\(cellState.date.customDateStringFormat("dd-MM-YYYY"))"
            
        }else {
            calstartDate = calendarView.selectedDates.first?.customDateStringFormat("dd-MM-YYYY") ?? ""
            calendDate = calendarView.selectedDates.last?.customDateStringFormat("dd-MM-YYYY") ?? ""
            
        }
        
      

               
    }
    
    
    func handleCellColor(cell: calendarCVCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.label.textColor = UIColor.black
        } else {
            cell.label.textColor = UIColor.lightGray
        }
    }
    
    func handleCellSelected(cell: calendarCVCell, cellState: CellState) {
        cell.selectedView.isHidden = !cellState.isSelected
        
        cell.selectedView.layer.cornerRadius = cell.selectedView.frame.width / 2
        cell.clipsToBounds = true
        
        switch cellState.selectedPosition() {
        case .left:
//            cell.selectedView.layer.cornerRadius = 3
//            cell.selectedView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
//            cell.selectedView.isHidden = false
            cell.selectedView.backgroundColor = UIColor.AppCalenderDateSelectColor
            cell.label.textColor = UIColor.white
        case .middle:
//            cell.selectedView.layer.cornerRadius = 3
//            cell.selectedView.layer.maskedCorners = []
//            cell.selectedView.isHidden = false
            cell.selectedView.backgroundColor = UIColor.AppCalenderDateSelectColor.withAlphaComponent(0.3)
            cell.label.textColor = UIColor.AppLabelColor.withAlphaComponent(0.4)
        case .right:
//            cell.selectedView.layer.cornerRadius = 3
//            cell.selectedView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
//            cell.selectedView.isHidden = false
            cell.selectedView.backgroundColor = UIColor.AppCalenderDateSelectColor
            cell.label.textColor = UIColor.white
        case .full:
//            cell.selectedView.layer.cornerRadius = 3
//            cell.selectedView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
//            cell.selectedView.isHidden = false
            cell.selectedView.backgroundColor = UIColor.AppCalenderDateSelectColor
            cell.label.textColor = UIColor.white
        default: break
        }
        
       
              
    }
    
    
//    @IBAction func leftButtonClick(_ sender: Any) {
//        calendarView.scrollToSegment(.previous)
//    }
    
    @IBAction func rightButtonClick(_ sender: Any) {
        calendarView.scrollToSegment(.next)
    }
    
    
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapOnDepartureBtnAction(_ sender: Any) {
        print("didTapOnDepartureBtnAction")
    }
    
    
    @IBAction func didTapOnReturnBtnAction(_ sender: Any) {
        print("didTapOnReturnBtnAction")
    }
    
    
    @IBAction func selectDateBtnAction(_ sender: Any) {
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if selectedTab == "Flights" {
                
                if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                    if journeyType == "oneway" {
                        if calstartDate == "" {
                            showToast(message: "Please Select Date")
                        }else {
                            defaults.set(calstartDate, forKey: UserDefaultsKeys.calDepDate)
                            keyStr = "select"
                            NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
                            dismiss(animated: false)
                        }
                        
                    }else if journeyType == "circle"{
                        if calstartDate == "" && calendDate == "" {
                            showToast(message: "Please Select Dates")
                        }else if calstartDate == calendDate{
                            showToast(message: "Please Select Multiple Dates")
                        }else{
                            defaults.set(calstartDate, forKey: UserDefaultsKeys.calDepDate)
                            defaults.set(calendDate, forKey: UserDefaultsKeys.calRetDate)
                            keyStr = "select1"
                            NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
                            dismiss(animated: false)
                        }
                    }else {
                        
                        if calstartDate == "" {
                            showToast(message: "Please Select Dates")
                        }else{
                            defaults.set(calstartDate, forKey: UserDefaultsKeys.mcaldate)
                            depatureDatesArray[self.celltag] = calstartDate
                            gotoSearchFlightsVC()
                        }
                    }
                }
                
            }else {
                
                if calstartDate == "" && calendDate == "" {
                    showToast(message: "Please Select Dates")
                }else if calstartDate == calendDate{
                    showToast(message: "Please Select Multiple Dates")
                }else{
                    defaults.set(calstartDate, forKey: UserDefaultsKeys.checkin)
                    defaults.set(calendDate, forKey: UserDefaultsKeys.checkout)
                    
                    gotoSearchHotelsVC()
                }
                
            }
        }
        
    }
    
    
    func gotoSearchFlightsVC() {
        guard let vc = SearchFlightsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        keyStr = "select"
        vc.isfromVc = "cal"
        self.present(vc, animated: false)
    }
    
    
    func gotoSearchHotelsVC() {
        guard let vc = SearchHotelsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
}



extension CalenderVC: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
        handleConfiguration(cell: cell, cellState: cellState)
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calendarCVCell", for: indexPath) as! calendarCVCell
        cell.label.text = cellState.text
        handleConfiguration(cell: cell, cellState: cellState)
        
        
        if cellState.dateBelongsTo == .thisMonth {
            cell.isHidden = false
        } else {
            cell.isHidden = true
        }
        
        if date <= Date(){
            cell.label.textColor = HexColor("#555555", alpha: 0.4)
        }else {
            cell.label.textColor = HexColor("#555555")
        }
        
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupMonthLabel(date: visibleDates.monthDates.first!.date)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleConfiguration(cell: cell, cellState: cellState)
        self.departureDatelbl.text = calstartDate
        self.returnDatelbl.text = calendDate
        if selectedfirstDate != nil {
            if date < selectedfirstDate! {
                calendarView.selectDates(from: date, to: selectedfirstDate!,  triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
                selectedlastDate = calendarView.selectedDates.last
                selectedfirstDate = calendarView.selectedDates.first
                
            } else {
                selectedlastDate = calendarView.selectedDates.last
                calendarView.selectDates(from: selectedfirstDate!, to: date,  triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
            }
        } else {
            selectedfirstDate = calendarView.selectedDates.first
            selectedlastDate = nil
            handleConfiguration(cell: cell, cellState: cellState)
        }
        
    }
    
    

    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleConfiguration(cell: cell, cellState: cellState)
        
        if selectedfirstDate != nil{
            if date > (selectedfirstDate!){
                calendarView.deselectDates(from: selectedfirstDate!, to: date, triggerSelectionDelegate: false)
                selectedfirstDate = calendarView.selectedDates.first
            } else if selectedlastDate == nil || date == selectedlastDate {
                selectedfirstDate = nil
                selectedlastDate = nil
                handleConfiguration(cell: cell, cellState: cellState)
                
            }else {
                handleConfiguration(cell: cell, cellState: cellState)
            }
        }
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let parameter = ConfigurationParameters(startDate: self.startDate,
                                                endDate: self.endDate,
                                                numberOfRows: 6,
                                                generateInDates: .forAllMonths,
                                                generateOutDates: .tillEndOfGrid,
                                                firstDayOfWeek: .monday,
                                                hasStrictBoundaries:true)
        return parameter
    }
    
    func calendar(_ calendar: JTAppleCalendarView, shouldSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) -> Bool {
        return date >= Date()
    }
    
    
    
    
    
}
