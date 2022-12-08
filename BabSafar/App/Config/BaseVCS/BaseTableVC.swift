//
//  BaseTableVC.swift
//  Clique
//
//  Created by Codebele-03 on 03/06/21.
//

import UIKit

class BaseTableVC: UIViewController, SearchFlightsTVCellDelegate, TravellerEconomyTVCellDelegate, RadioButtonTVCellDelegate, LabelTVCellDelegate, SignUpWithTVCellDelegate, ButtonTVCellDelegate, TextfieldTVCellDelegate, LoignOrSignupBtnsTVCellDelegate, BookNowButtonsTVCellDelegate, MenuBGTVCellDelegate, DropDownTVCellDelegate, TDetailsLoginTVCellDelegate, ContactInformationTVCellDelegate, TravelInsuranceTVCellDelegate, PriceSummaryTVCellDelegate, AddTravellerTVCellDelegate, SelectGenderTVCellDelegate, SortbyTVCellDelegate, YourPrivacyTVCellDelegate, SearchFlightResultTVCellDelegate, MultiCityTVCellDelegate, CommonFromCityTVCellDelegate,SearchLocationTFTVCellDelegate, HotelsTVCellelegate, PopularFiltersTVCellDelegate, RoomsTVcellDelegate,RoomDetailsTVCellDelegate, AddAdultsOrGuestTVCellDelegate, FlightDetailsTVCellDelegate, CheckBoxTVCellDelegate, FilterDepartureTVCellDelegate, SliderTVCellDelegate, RoundTripFlightResultTVCellDelegate, MultiCityTripFlightResultTVCellDelegate, EnterTravellerDetailsTVCellDelegate, DobTVCellDelegate, ExpireOnTVCellDelegate, ViewFlightDetailsBtnTVCellDelegate {
    
    
    
    
    @IBOutlet weak var commonScrollView: UITableView!
    @IBOutlet weak var commonTableView: UITableView!
    
    
    @IBOutlet weak var commonTVTopConstraint: NSLayoutConstraint!
    
    
    var commonTVData = [TableRow]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalPresentationCapturesStatusBarAppearance = true
        self.navigationController?.navigationBar.isHidden = true
        configureTableView()
        //        self.automaticallyAdjustsScrollViewInsets = false
        
        // Do any additional setup after loading the view.
    }
    
    
    func configureTableView() {
        if commonTableView != nil {
            makeDefaultConfigurationForTable(tableView: commonTableView)
        } else {
            print("commonTableView is nil")
        }
    }
    
    func makeDefaultConfigurationForTable(tableView: UITableView) {
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            // Fallback on earlier versions
        }
    }
    
    func serviceCall_Completed_ForNoDataLabel(noDataMessage: String? = nil, data: [Any]? = nil, centerVal:CGFloat? = nil, color: UIColor = HexColor("#182541")) {
        dealWithNoDataLabel(message: noDataMessage, data: data, centerVal: centerVal ?? 2.0, color: color)
    }
    
    func dealWithNoDataLabel(message: String?, data: [Any]?, centerVal: CGFloat = 2.0, color: UIColor = HexColor("#182541")) {
        if commonTableView == nil { return; }
        
        commonTableView.viewWithTag(100)?.removeFromSuperview()
        
        if let message = message, let data = data {
            if data.count == 0 {
                let tableSize = commonTableView.frame.size
                
                let label = UILabel(frame: CGRect(x: 15, y: 15, width: tableSize.width, height: 60))
                label.center = CGPoint(x: (tableSize.width/2), y: (tableSize.height/centerVal))
                label.tag = 100
                label.numberOfLines = 0
                
                label.textAlignment = NSTextAlignment.center
                //                label.font = UIFont.CircularStdMedium(size: 14)
                label.textColor = color
                label.text = message
                
                commonTableView.addSubview(label)
            }
        }
        
    }
    
    
    //Delegate Methods
    
    
    func didTapOnFromCityBtnAction(cell: SearchFlightsTVCell) {}
    func didTapOnToCityBtnAction(cell: SearchFlightsTVCell){}
    func didTapOnSwipeCityBtnAction(cell: SearchFlightsTVCell) {}
    func didTapOnDepartureBtnAction(cell: SearchFlightsTVCell) {}
    func didTapOnReturnBtnAction(cell: SearchFlightsTVCell) {}
    func addEconomyBtnAction(cell: SearchFlightsTVCell) {}
    func moreOptionBtnAction(cell: SearchFlightsTVCell){}
    func didTapOnairlineBtnAction(cell: SearchFlightsTVCell) {}
    func didTapOntimeReturnJourneyBtnAction(cell: SearchFlightsTVCell) {}
    func didTapOntimeOutwardJourneyBtnAction(cell: SearchFlightsTVCell) {}
    func didTapOnReturnJurneyRadioButton(cell: SearchFlightsTVCell) {}
    func didTapOnDirectFlightRadioButton(cell: SearchFlightsTVCell) {}
    func didTapOnSearchFlightBtnAction(cell: SearchFlightsTVCell) {}
    func didTapOnDecrementButton(cell: TravellerEconomyTVCell) {}
    func didTapOnIncrementButton(cell: TravellerEconomyTVCell) {}
    func didTapOnRadioButton(cell: RadioButtonTVCell) {}
    func didTapOnCloseBtn(cell: LabelTVCell) {}
    func didTapOnGoogleBtn(cell: SignUpWithTVCell) {}
    func btnAction(cell: ButtonTVCell) {}
    func didTapOnForGetPassword(cell: TextfieldTVCell) {}
    func donedatePicker(cell:TextfieldTVCell){}
    func cancelDatePicker(cell:TextfieldTVCell){}
    func editingTextField(tf: UITextField) {}
    func textFieldText(cell: TextfieldTVCell, text: String){}
    func didTapOnLoginBtn(cell: LoignOrSignupBtnsTVCell) {}
    func didTapOnSignUpBtn(cell: LoignOrSignupBtnsTVCell) {}
    func didTapOnShowPasswordBtn(cell:TextfieldTVCell){}
    func didTapOnKWDBtn(cell: BookNowButtonsTVCell) {}
    func didTapOnBookNowBtn(cell: BookNowButtonsTVCell) {}
    func didTapOnLoginBtn(cell: MenuBGTVCell) {}
    func didTapOnEditProfileBtn(cell: MenuBGTVCell) {}
    func didTapOnDropDownBtn(cell: DropDownTVCell) {}
    func didTapOnLoginBtn(cell: TDetailsLoginTVCell) {}
    func didTapOnCountryCodeBtn(cell: ContactInformationTVCell) {}
    func didTapOnInsureSkipButton(cell: TravelInsuranceTVCell) {}
    func didTapOnPABtn(cell: TravelInsuranceTVCell) {}
    func didTapOnTCBtn(cell: TravelInsuranceTVCell) {}
    func didTapOnTDBtn(cell: TravelInsuranceTVCell) {}
    func didTapOnTC1Btn(cell: TravelInsuranceTVCell) {}
    func didTapOnTD1Btn(cell: TravelInsuranceTVCell) {}
    func didTapOnShowMoreBtn(cell: TravelInsuranceTVCell) {}
    func didTapOnYesInsureBtn(cell: TravelInsuranceTVCell) {}
    func didTapOnNoInsureBtn(cell: TravelInsuranceTVCell) {}
    func didTapOnRemoveTravelInsuranceBtn(cell: PriceSummaryTVCell) {}
    func didTapOnAddAdultBtn(cell: AddTravellerTVCell) {}
    func didTapOnAddChildBtn(cell: AddTravellerTVCell) {}
    func didTapOnAddInfantaBtn(cell:AddTravellerTVCell) {}
    func didSelectMaleRadioBtn(cell: SelectGenderTVCell) {}
    func didSelectOnFemaleBtn(cell: SelectGenderTVCell) {}
    func didTapOnSaveBtn(cell: SelectGenderTVCell) {}
    func didTapOnLowtoHighBtn(cell: SortbyTVCell) {}
    func didTapOnHightoLowBtn(cell: SortbyTVCell) {}
    //    func didTapOnResetSortbyBtn(cell: SortbyTVCell) {}
    func didTapOnShowMoreBtn(cell: YourPrivacyTVCell) {}
    func didTapOnDualBtn1(cell: ButtonTVCell){}
    func didTapOnDualBtn2(cell: ButtonTVCell){}
    func didTapOnViewVoucherBtn(cell: SearchFlightResultTVCell) {}
    func addEconomyBtnAction(cell: MultiCityTVCell) {}
    
    func didTapOnairlineBtnAction(cell: MultiCityTVCell) {}
    func didTapOntimeReturnJourneyBtnAction(cell: MultiCityTVCell) {}
    func didTapOntimeOutwardJourneyBtnAction(cell: MultiCityTVCell) {}
    func viewBtnAction(cell: CommonFromCityTVCell) {}
    func didTapOnDual1Btn(cell:CommonFromCityTVCell){}
    func didTapOnDual2Btn(cell:CommonFromCityTVCell){}
    func mapViewBtnAction(cell:SearchLocationTFTVCell){}
    func didTapOnRefundableBtn(cell: HotelsTVCell) {}
    func didTapOnOneRatingViewBtn(cell: PopularFiltersTVCell) {}
    func didTapOnTwoRatingViewBtn(cell: PopularFiltersTVCell) {}
    func didTapOnThreeatingViewBtn(cell: PopularFiltersTVCell) {}
    func didTapOnFouratingViewBtn(cell: PopularFiltersTVCell) {}
    func didTapOnFivetingViewBtn(cell: PopularFiltersTVCell) {}
    func didTapOnShowMoreBtn(cell:LabelTVCell){}
    func didTapOnRoomsBtn(cell: RoomsTVcell) {}
    func didTapOnHotelsDetailsBtn(cell: RoomsTVcell) {}
    func didTapOnAmenitiesBtn(cell: RoomsTVcell) {}
    func didTapOnRefundableBtn1(cell:RoomDetailsTVCell){}
    func didTapOnEditAdultBtn(cell: AddAdultsOrGuestTVCell) {}
    func didTapOnEditTraveller(cell:AddAdultsOrGuestTVCell){}
    func didTapOnViewFlightsDetailsBtn(cell: FlightDetailsTVCell) {}
    func didTapOnFlightsDetails(cell:SearchFlightResultTVCell){}
    func didTapOnCheckBoxDropDownBtn(cell: CheckBoxTVCell) {}
    func didTapOnShowMoreBtn(cell:CheckBoxTVCell){}
    func didTapOnDropDownBtn(cell: FilterDepartureTVCell) {}
    func didTapOnShowSliderBtn(cell: SliderTVCell) {}
    func gotoRoundTripBaggageIntoVC(cell: RoundTripFlightResultTVCell) {}
    func gotoRoundTripBaggageIntoVC(cell: MultiCityTripFlightResultTVCell) {}
    
    func didTapOnFromCityBtn(cell: MultiCityTVCell) {}
    func didTapOnToCityBtn(cell: MultiCityTVCell) {}
    func didTapOnDateBtn(cell: MultiCityTVCell) {}
    func editingChanged(tf: UITextField) {}
    func donedatePicker(cell:EnterTravellerDetailsTVCell){}
    func cancelDatePicker(cell:EnterTravellerDetailsTVCell){}
    func selectedTitle(cell:EnterTravellerDetailsTVCell){}
    func donedatePicker(cell: DobTVCell) {}
    func cancelDatePicker(cell: DobTVCell) {}
    func donedatePicker(cell: ExpireOnTVCell) {}
    func cancelDatePicker(cell: ExpireOnTVCell) {}
    func didTapOnDropDownBtn(cell: ContactInformationTVCell) {}
    func didTapOnViewFlightDetailsButton(cell: ViewFlightDetailsBtnTVCell) {}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

extension BaseTableVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = commonTVData[indexPath.row].height
        
        if let height = height {
            return height
        }
        
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
}
extension BaseTableVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == commonTableView {
            return commonTVData.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell: TableViewCell!
        
        var data: TableRow?
        var commonTV = UITableView()
        
        if tableView == commonTableView {
            data = commonTVData[indexPath.row]
            commonTV = commonTableView
        }
        
        
        if let cellType = data?.cellType {
            switch cellType {
                
                //Sign & SignUp Cells
                
            case .EmptyTVCell:
                let cell: EmptyTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .SpecialDealsTVCell:
                let cell: SpecialDealsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .TopCityTVCell:
                let cell: TopCityTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .SearchFlightsTVCell:
                let cell: SearchFlightsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .TopAirlinesTVCell:
                let cell: TopAirlinesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .RadioButtonTVCell:
                let cell: RadioButtonTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .TravellerEconomyTVCell:
                let cell: TravellerEconomyTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .LabelTVCell:
                let cell: LabelTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .FromCityTVCell:
                let cell: FromCityTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .UnderLineTVCell:
                let cell: UnderLineTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .SignUpWithTVCell:
                let cell: SignUpWithTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .ButtonTVCell:
                let cell: ButtonTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .TextfieldTVCell:
                let cell: TextfieldTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .LoignOrSignupBtnsTVCell:
                let cell: LoignOrSignupBtnsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .SearchFlightResultTVCell:
                let cell: SearchFlightResultTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .ItineraryTVCell:
                let cell: ItineraryTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .ItineraryAddTVCell:
                let cell: ItineraryAddTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .FareRulesTVCell:
                let cell: FareRulesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .BaggageInfoTVCell:
                let cell: BaggageInfoTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .BookNowButtonsTVCell:
                let cell: BookNowButtonsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .SelectLanguageTVCell:
                let cell: SelectLanguageTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .MenuBGTVCell:
                let cell: MenuBGTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .DropDownTVCell:
                let cell: DropDownTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .TDetailsLoginTVCell:
                let cell: TDetailsLoginTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .ContactInformationTVCell:
                let cell: ContactInformationTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .TravelInsuranceTVCell:
                let cell: TravelInsuranceTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .PriceSummaryTVCell:
                let cell: PriceSummaryTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .AddTravellerTVCell:
                let cell: AddTravellerTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .SelectGenderTVCell:
                let cell: SelectGenderTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .CheckBoxTVCell:
                let cell: CheckBoxTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .SortbyTVCell:
                let cell: SortbyTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .DoubleSliderTVCell:
                let cell: DoubleSliderTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .BookingConfirmedTVCell:
                let cell: BookingConfirmedTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .BookedTravelDetailsTVCell:
                let cell: BookedTravelDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .YourPrivacyTVCell:
                let cell: YourPrivacyTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .MultiCityTVCell:
                let cell: MultiCityTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .TextViewTVCell:
                let cell: TextViewTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .CommonFromCityTVCell:
                let cell: CommonFromCityTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .SearchLocationTFTVCell:
                let cell: SearchLocationTFTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .HotelsTVCell:
                let cell: HotelsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .HotelImagesTVCell:
                let cell: HotelImagesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .TitleLabelTVCell:
                let cell: TitleLabelTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .RoomsTVcell:
                let cell: RoomsTVcell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .PopularFiltersTVCell:
                let cell: PopularFiltersTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .RoomDetailsTVCell:
                let cell: RoomDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                //  cell.delegate = self
                commonCell = cell
                
                
            case .checkOptionsTVCell:
                let cell: checkOptionsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                //  cell.delegate = self
                commonCell = cell
                
                
            case .HotelDetailsTVCell:
                let cell: HotelDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .AddAdultsOrGuestTVCell:
                let cell: AddAdultsOrGuestTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .FlightDetailsTVCell:
                let cell: FlightDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
                
            case .FilterDepartureTVCell:
                let cell: FilterDepartureTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .SliderTVCell:
                let cell: SliderTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .ContactTVCell:
                let cell: ContactTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
                
            case .AboutusTVCell:
                let cell: AboutusTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .RoundTripFlightResultTVCell:
                let cell: RoundTripFlightResultTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .MultiCityTripFlightResultTVCell:
                let cell: MultiCityTripFlightResultTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .CommonTVCell:
                let cell: CommonTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
                
            case .EnterTravellerDetailsTVCell:
                let cell: EnterTravellerDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .DobTVCell:
                let cell: DobTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .ExpireOnTVCell:
                let cell: ExpireOnTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .CancellationFeesTVCell:
                let cell: CancellationFeesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .basefareTVCell:
                let cell: basefareTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .NoteTVCell:
                let cell: NoteTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .FlightDetailsTitleTVCell:
                let cell: FlightDetailsTitleTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .ViewFlightDetailsBtnTVCell:
                let cell: ViewFlightDetailsBtnTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
                
            default:
                print("handle this case in getCurrentCellAt")
            }
        }
        
        commonCell.cellInfo = data
        commonCell.indexPath = indexPath
        commonCell.selectionStyle = .none
        
        return commonCell
    }
} 



extension UITableView {
    func registerTVCells(_ classNames: [String]) {
        for className in classNames {
            register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
        }
    }
    
    func dequeTVCell<T: UITableViewCell>(indexPath: IndexPath, osVersion: String? = nil) -> T {
        let className = String(describing: T.self) + "\(osVersion ?? "")"
        guard let cell = dequeueReusableCell(withIdentifier: className, for: indexPath) as? T  else { fatalError("Couldn’t get cell with identifier \(className)") }
        return cell
    }
    
    func dequeTVCellForFooter<T: UITableViewCell>() -> T {
        let className = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: className) as? T  else { fatalError("Couldn’t get cell with identifier \(className)") }
        return cell
    }
    
    
    
    func isLast(for indexPath: IndexPath) -> Bool {
        
        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
        let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1
        
        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    }
    
}
