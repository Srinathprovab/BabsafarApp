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
    @IBOutlet weak var leftButton: UIButton!
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
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        departureDatelbl.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "Select Date"
        returnDatelbl.text = defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "Select Date"
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
        
        setupViews(v: departureView, radius: 4, color: .AppHolderViewColor)
        setupViews(v: returnView, radius: 4, color: .AppHolderViewColor)
        setupViews(v: selectBtnView, radius: 4, color: .AppBtnColor)
        
        
        setupLabels(lbl: departurelbl, text: "Departure ", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: departureDatelbl, text: "26-07-2022", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: returnlbl, text: "Return ", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: returnDatelbl, text: "26-07-2022", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
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
        
        holderView.backgroundColor = .white
        holderView.layer.shadowColor = UIColor.lightGray.cgColor
        holderView.layer.shadowOpacity = 1
        holderView.layer.shadowOffset = .zero
        holderView.layer.shadowRadius = 5
        
        
        monthLabel.textColor = HexColor("#555555")
        monthLabel.font = UIFont.LatoRegular(size: 16)
        
        sundayLabel.textColor = HexColor("#555555")
        sundayLabel.font = UIFont.LatoRegular(size: 14)
        sundayLabel.text = "SU"
        
        mondayLabel.textColor = HexColor("#555555")
        mondayLabel.font = UIFont.LatoRegular(size: 14)
        mondayLabel.text = "MO"
        
        tuesdayLabel.textColor = HexColor("#555555")
        tuesdayLabel.font = UIFont.LatoRegular(size: 14)
        tuesdayLabel.text = "TU"
        
        wednesdayLabel.textColor = HexColor("#555555")
        wednesdayLabel.font = UIFont.LatoRegular(size: 14)
        wednesdayLabel.text = "WE"
        
        thursdayLabel.textColor = HexColor("#555555")
        thursdayLabel.font = UIFont.LatoRegular(size: 14)
        thursdayLabel.text = "TH"
        
        fridayLabel.textColor = HexColor("#555555")
        fridayLabel.font = UIFont.LatoRegular(size: 14)
        fridayLabel.text = "FR"
        
        saturdayLabel.textColor = HexColor("#555555")
        saturdayLabel.font = UIFont.LatoRegular(size: 14)
        saturdayLabel.text = "SA"
        
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
        calendarView.allowsMultipleSelection = true
        calendarView.isRangeSelectionUsed = true
        calendarView.ibCalendarDelegate = self
        calendarView.ibCalendarDataSource = self
        calendarView.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        calendarView.minimumLineSpacing = 5
        calendarView.minimumInteritemSpacing = 5
        
        
        calendarView.visibleDates { (visibleDates) in
            self.setupMonthLabel(date: visibleDates.monthDates.first?.date ?? Date())
        }
        
        //        let panGensture = UILongPressGestureRecognizer(target: self, action: #selector(didStartRangeSelecting(gesture:)))
        //        panGensture.minimumPressDuration = 0.5
        //        calendarView.addGestureRecognizer(panGensture)
        
    }
    
    
    //    @objc func didStartRangeSelecting(gesture: UITapGestureRecognizer) {
    //        let point = gesture.location(in: gesture.view!)
    //        let rangeSelectedDates = calendarView.selectedDates
    //
    //        guard let cellState = calendarView.cellStatus(at: point) else { return }
    //
    //        if !rangeSelectedDates.contains(cellState.date) {
    //            let dateRange = calendarView.generateDateRange(from: rangeSelectedDates.first ?? cellState.date, to: cellState.date)
    //            calendarView.selectDates(dateRange, keepSelectionIfMultiSelectionAllowed: true)
    //        }
    //    }
    
    func setupMonthLabel(date: Date) {
        monthLabel.text = date.monthYearName
    }
    
    
    func handleConfiguration(cell: JTAppleCell?, cellState: CellState) {
        guard let cell = cell as? calendarCVCell else { return }
        handleCellColor(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState)
        
        if calendarView.selectedDates.count == 0 {
            
        }else if calendarView.selectedDates.count == 1 {
            
            calstartDate = "\(cellState.date.customDateStringFormat("dd/MM/YYYY"))"
            calendDate = "\(cellState.date.customDateStringFormat("dd/MM/YYYY"))"
            
        }else {
            
            
            calstartDate = calendarView.selectedDates.first?.customDateStringFormat("dd/MM/YYYY") ?? ""
            calendDate = calendarView.selectedDates.last?.customDateStringFormat("dd/MM/YYYY") ?? ""
            
            
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
        switch cellState.selectedPosition() {
        case .left:
            cell.selectedView.layer.cornerRadius = 0
            cell.selectedView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
            cell.selectedView.isHidden = false
            cell.selectedView.backgroundColor = UIColor.AppCalenderDateSelectColor
            cell.label.textColor = UIColor.white
        case .middle:
            cell.selectedView.layer.cornerRadius = 0
            cell.selectedView.layer.maskedCorners = []
            cell.selectedView.isHidden = false
            cell.selectedView.backgroundColor = UIColor.AppCalenderDateSelectColor
            cell.label.textColor = UIColor.white
        case .right:
            cell.selectedView.layer.cornerRadius = 0
            cell.selectedView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            cell.selectedView.isHidden = false
            cell.selectedView.backgroundColor = UIColor.AppCalenderDateSelectColor
            cell.label.textColor = UIColor.white
        case .full:
            cell.selectedView.layer.cornerRadius = 0
            cell.selectedView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
            cell.selectedView.isHidden = false
            cell.selectedView.backgroundColor = UIColor.AppCalenderDateSelectColor
            cell.label.textColor = UIColor.white
        default: break
        }
    }
    
    
    
    
    @IBAction func leftButtonClick(_ sender: Any) {
        calendarView.scrollToSegment(.previous)
    }
    
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
        dismiss(animated: false)
    }
}



extension CalenderVC: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
        handleConfiguration(cell: cell, cellState: cellState)
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calendarCVCell", for: indexPath) as! calendarCVCell
        cell.label.text = cellState.text
        cell.holderView.backgroundColor = HexColor("#ECF3FD")
        handleConfiguration(cell: cell, cellState: cellState)
        //        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        
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
        print(cellState.date.customDateStringFormat())
        print("start date  : \(calstartDate)")
        print("End date  : \(calendDate)")
        
        self.departureDatelbl.text = calstartDate
        defaults.set(calstartDate, forKey: UserDefaultsKeys.calDepDate)
        
        self.returnDatelbl.text = calendDate
        defaults.set(calendDate, forKey: UserDefaultsKeys.calRetDate)
        
//        if dateSelectKey == "dep" {
//            self.departureDatelbl.text = calstartDate
//            defaults.set(calstartDate, forKey: UserDefaultsKeys.calDepDate)
//        }else {
//            self.returnDatelbl.text = calendDate
//            defaults.set(calendDate, forKey: UserDefaultsKeys.calRetDate)
//        }
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleConfiguration(cell: cell, cellState: cellState)
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        print("configureCalendar")
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
