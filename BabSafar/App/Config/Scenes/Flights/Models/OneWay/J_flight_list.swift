
import Foundation
struct J_flight_list : Codable {
    //   let infants_Base_Price : Double?
    //   let totalPrice : Double?
    let booking_source : String?
    let access_key : String?
    //    let adults_Base_Price : Double?
    //    let adults_Tax_Price : Double?
    //    let baggageAllowance : [[String]]?
    let booking_source_key : String?
    //  let refundable : Bool?
    //    let childs_Total_Price : Double?
    //    let infants : Int?
    let fareType : String?
    //    let childs : Int?
    //    let infants_Tax_Price : Double?
    //    let basePrice : Double?
    //    let adults_Total_Price : Double?
    //    let childs_Base_Price : Double?
    //    let infants_Total_Price : Double?
    //    let aMarkup_cal : String?
    //    let childs_Tax_Price : Double?
    //    let myMarkup_cal : String?
    let price : Price?
    let sITECurrencyType : String?
    //    let all_Passenger : String?
    let flight_details : Flight_details?
    //    let adults : Int?
    //    let aMarkup : String?
    //    let taxes : Double?
    //    let myMarkup : String?
    //    let fare : [Fare]?
    //    let airlineRemark : String?
    let selectedResult : String?
    //  let totalPrice_API : Double?
    let aPICurrencyType : String?
    
    enum CodingKeys: String, CodingKey {
        
        //   case infants_Base_Price = "Infants_Base_Price"
        //     case totalPrice = "TotalPrice"
        case booking_source = "booking_source"
        case access_key = "access_key"
        //        case adults_Base_Price = "Adults_Base_Price"
        //        case adults_Tax_Price = "Adults_Tax_Price"
        //      case baggageAllowance = "BaggageAllowance"
        case booking_source_key = "booking_source_key"
        //  case refundable = "Refundable"
        //        case childs_Total_Price = "Childs_Total_Price"
        //        case infants = "Infants"
        case fareType = "FareType"
        //        case childs = "Childs"
        //        case infants_Tax_Price = "Infants_Tax_Price"
        //        case basePrice = "BasePrice"
        //        case adults_Total_Price = "Adults_Total_Price"
        //        case childs_Base_Price = "Childs_Base_Price"
        //        case infants_Total_Price = "Infants_Total_Price"
        //        case aMarkup_cal = "aMarkup_cal"
        //        case childs_Tax_Price = "Childs_Tax_Price"
        //        case myMarkup_cal = "myMarkup_cal"
        case price = "price"
        case sITECurrencyType = "SITECurrencyType"
        //  case all_Passenger = "All_Passenger"
        case flight_details = "flight_details"
        //        case adults = "Adults"
        //        case aMarkup = "aMarkup"
        //        case taxes = "Taxes"
        //        case myMarkup = "MyMarkup"
        //     case fare = "fare"
        //     case airlineRemark = "AirlineRemark"
        case selectedResult = "selectedResult"
        //    case totalPrice_API = "TotalPrice_API"
        case aPICurrencyType = "APICurrencyType"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //   infants_Base_Price = try values.decodeIfPresent(Double.self, forKey: .infants_Base_Price)
        //    totalPrice = try values.decodeIfPresent(Double.self, forKey: .totalPrice)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        access_key = try values.decodeIfPresent(String.self, forKey: .access_key)
        //        adults_Base_Price = try values.decodeIfPresent(Double.self, forKey: .adults_Base_Price)
        //        adults_Tax_Price = try values.decodeIfPresent(Double.self, forKey: .adults_Tax_Price)
        //       baggageAllowance = try values.decodeIfPresent([[String]].self, forKey: .baggageAllowance)
        booking_source_key = try values.decodeIfPresent(String.self, forKey: .booking_source_key)
        //   refundable = try values.decodeIfPresent(Bool.self, forKey: .refundable)
        //        childs_Total_Price = try values.decodeIfPresent(Double.self, forKey: .childs_Total_Price)
        //        infants = try values.decodeIfPresent(Int.self, forKey: .infants)
        fareType = try values.decodeIfPresent(String.self, forKey: .fareType)
        //        childs = try values.decodeIfPresent(Int.self, forKey: .childs)
        //        infants_Tax_Price = try values.decodeIfPresent(Double.self, forKey: .infants_Tax_Price)
        //        basePrice = try values.decodeIfPresent(Double.self, forKey: .basePrice)
        //        adults_Total_Price = try values.decodeIfPresent(Double.self, forKey: .adults_Total_Price)
        //        childs_Base_Price = try values.decodeIfPresent(Double.self, forKey: .childs_Base_Price)
        //        infants_Total_Price = try values.decodeIfPresent(Double.self, forKey: .infants_Total_Price)
        //        aMarkup_cal = try values.decodeIfPresent(String.self, forKey: .aMarkup_cal)
        //        childs_Tax_Price = try values.decodeIfPresent(Double.self, forKey: .childs_Tax_Price)
        //        myMarkup_cal = try values.decodeIfPresent(String.self, forKey: .myMarkup_cal)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        sITECurrencyType = try values.decodeIfPresent(String.self, forKey: .sITECurrencyType)
        //    all_Passenger = try values.decodeIfPresent(String.self, forKey: .all_Passenger)
        flight_details = try values.decodeIfPresent(Flight_details.self, forKey: .flight_details)
        //        adults = try values.decodeIfPresent(Int.self, forKey: .adults)
        //        aMarkup = try values.decodeIfPresent(String.self, forKey: .aMarkup)
        //        taxes = try values.decodeIfPresent(Double.self, forKey: .taxes)
        //        myMarkup = try values.decodeIfPresent(String.self, forKey: .myMarkup)
        //     fare = try values.decodeIfPresent([Fare].self, forKey: .fare)
        //     airlineRemark = try values.decodeIfPresent(String.self, forKey: .airlineRemark)
        selectedResult = try values.decodeIfPresent(String.self, forKey: .selectedResult)
        //      totalPrice_API = try values.decodeIfPresent(Double.self, forKey: .totalPrice_API)
        aPICurrencyType = try values.decodeIfPresent(String.self, forKey: .aPICurrencyType)
    }
    
}
