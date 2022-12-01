//
//  UIModels.swift
//  shifuApp
//
//  Created by Codebele on 12/09/19.
//  Copyright © 2019 Codebele. All rights reserved.
//

import Foundation
import UIKit


enum VCName {
    
}

enum socialSignUpType {
    case twitter
    case facebook
    case gmail
}

enum TVCellType {
    case SpecialDealsTVCell
    case EmptyTVCell
    case TopCityTVCell
    case SearchFlightsTVCell
    case TopAirlinesTVCell
    case TravellerEconomyTVCell
    case RadioButtonTVCell
    case LabelTVCell
    case FromCityTVCell
    case UnderLineTVCell
    case SignUpWithTVCell
    case ButtonTVCell
    case TextfieldTVCell
    case LoignOrSignupBtnsTVCell
    case SearchFlightResultTVCell
    case ItineraryTVCell
    case FareRulesTVCell
    case BaggageInfoTVCell
    case BookNowButtonsTVCell
    case SelectLanguageTVCell
    case MenuBGTVCell
    case DropDownTVCell
    case TDetailsLoginTVCell
    case ContactInformationTVCell
    case TravelInsuranceTVCell
    case PriceSummaryTVCell
    case AddTravellerTVCell
    case SelectGenderTVCell
    case CheckBoxTVCell
    case SortbyTVCell
    case DoubleSliderTVCell
    case BookingConfirmedTVCell
    case BookedTravelDetailsTVCell
    case YourPrivacyTVCell
    case MultiCityTVCell
    case TextViewTVCell
    case CommonFromCityTVCell
    case SearchLocationTFTVCell
    case HotelsTVCell
    case PopularFiltersTVCell
    case HotelImagesTVCell
    case TitleLabelTVCell
    case RoomsTVcell
    case RoomDetailsTVCell
    case checkOptionsTVCell
    case HotelDetailsTVCell
    case AddAdultsOrGuestTVCell
    case FlightDetailsTVCell
    case FilterDepartureTVCell
    case SliderTVCell
    case ContactTVCell
    case AboutusTVCell
    case RoundTripFlightResultTVCell
    case MultiCityTripFlightResultTVCell
    case CommonTVCell
    case ItineraryAddTVCell
    case EnterTravellerDetailsTVCell
    case DobTVCell
    case ExpireOnTVCell
    
    
    
    
    
}

enum CVCellType {
    
    
}

enum BorderSeq {
    case roundTop
    case first
    case middle
    case lastbutOne
    case last
    case twosides
    case none
}


class TableRow {
    
    var title: String?
    var subTitle: String?
    
    var text: String?
    var headerText: String?
    var buttonTitle: String?
    var key :String?
    var data:Any?
    var errormsg:String?
    var key1: String?
    var itemType: CVCellType?
    var isSecure:Bool = false
    var isSelected:Bool = false
    //    var source: SNClassName? = nil
    var needsBorder: Bool? = nil
    var needDoneButton: Bool? = nil
    var canGotoNextPage: Bool? = nil
    var signInType:socialSignUpType?
    var image: String?
    var height: CGFloat?
    var isError: Bool? = nil
    var imageSize: String? = nil
    var percentValue: Float?
    
    
    var isOptional:Bool = true
    var moreData : Any?
    var noInput :Bool = false
    var tempText:String?
    var characterLimit: Int?
    var characterLimit2: Int?
    var borderSeq:BorderSeq?
    var keyboardDistance:CGFloat?
    var errorMessage: String?
    var hasHyperLink: Bool?
    var disabled: Bool?
    var disableLeftPortion: Bool?
    var isEditable: Bool?
    var lineSpace: CGFloat?
    var tempInfo: Any? // Used to catch image while generating preview image for video
    var bgColor: UIColor?
    var separatorColor: UIColor?
    var titleColor: UIColor?
    var titleFont: UIFont?
    var cellbordercolor:CGColor?
    var fontSize: CGFloat? //Used to give custom height for empty cell
    
    var questionType: String?
    var questionBase: String?
    var TotalQuestions: String?
    var questionNumber: String?
    var questionHeading: String?
    var questionDescription: String?
    var shareImg: String?
    var shareLink: String?
    
    
    var cellType: TVCellType?
    var userCatdetails: Any?
    
    var data1: Any?
    var data2: Any?
    
    
    
    init() {}
    
    init(title: String? = nil, subTitle: String? = nil, key: String? = nil, text: String? = nil, headerText: String? = nil, buttonTitle: String? = nil, keyboardType: UIKeyboardType = .default, data: Any? = nil, errormsg: String? = nil, key1: String? = nil, signInType: socialSignUpType? = nil , itemType: CVCellType? = nil, isSecure: Bool = false, isSelected: Bool = false,  needsBorder: Bool? = nil, needDoneButton: Bool? = nil, canGotoNextPage: Bool? = nil, image: String? = nil, imageSize: String? = nil, height: CGFloat? = nil, isOptional: Bool = true, moreData: Any? = nil, noInput: Bool = false, tempText: String? = nil, characterLimit: Int? = nil,characterLimit2: Int? = nil, hasHyperLink: Bool? = nil, disabled: Bool? = nil, disableLeftPortion: Bool? = nil, isEditable: Bool? = nil, lineSpace: CGFloat? = nil, shouldDoDualFieldValidations: Bool? = nil, cellUIUpdateCallback: ((_ cell: Any) -> Void)? = nil, cellActions: ((_ cell: Any, _ actionType: String, _ moreData: Any) -> Void)? = nil, autoCapitalization: UITextAutocapitalizationType? = nil, fontSize: CGFloat? = nil, borderSeq: BorderSeq? = nil, keyboardDistance: CGFloat? = nil, itemSize: CGSize? = nil,
         isError: Bool? = nil,tempInfo: Any? = nil, bgColor: UIColor? = nil,separatorColor: UIColor? = nil,titleColor: UIColor? = nil, titleFont: UIFont? = nil,questionType: String? = nil,TotalQuestions: String? = nil,questionNumber: String? = nil,questionHeading: String? = nil,questionDescription: String? = nil,cellType: TVCellType? = nil, percentValue: Float? = nil,cellbordercolor:CGColor? = nil, userCatdetails: Any? = nil,data1: Any? = nil,data2: Any? = nil, shareLink: String? = nil,shareImg: String? = nil,questionBase: String? = nil ) {
        
        self.title = title
        self.bgColor = bgColor
        self.subTitle = subTitle
        self.key = key
        self.text = text
        self.headerText = headerText
        self.buttonTitle = buttonTitle
        self.data = data
        self.errormsg = errormsg
        self.key1 = key1
        self.signInType = signInType
        self.itemType = itemType
        self.isSecure = isSecure
        self.isSelected = isSelected
        //        self.source = source
        self.needsBorder = needsBorder
        self.needDoneButton = needDoneButton
        self.canGotoNextPage = canGotoNextPage
        self.image = image
        self.height = height
        self.imageSize = imageSize
        self.tempInfo = tempInfo
        self.isOptional = isOptional
        self.percentValue = percentValue
        self.moreData = moreData
        self.noInput = noInput
        self.tempText = tempText
        self.characterLimit = characterLimit
        self.hasHyperLink = hasHyperLink
        self.disabled = disabled
        self.disableLeftPortion = disableLeftPortion
        
        self.isEditable = isEditable
        self.lineSpace = lineSpace
        self.fontSize = fontSize
        self.borderSeq = borderSeq
        self.keyboardDistance = keyboardDistance
        self.isError = isError
        self.separatorColor = separatorColor
        self.titleColor = titleColor
        self.titleFont = titleFont
        
        self.questionType = questionType
        self.TotalQuestions = TotalQuestions
        self.questionNumber = questionNumber
        self.questionHeading = questionHeading
        self.questionDescription = questionDescription
        self.characterLimit2 = characterLimit2
        self.cellType = cellType //keep celltype at the last
        self.cellbordercolor = cellbordercolor
        self.userCatdetails = userCatdetails
        self.questionBase = questionBase
        self.shareImg = shareImg
        self.shareLink = shareLink
        
        self.data1 = data1
        self.data2 = data2
    }
    
}
