
import Foundation
struct J_flight_list : Codable {
    
//	let airPricingSolution_Key : String?
//	let completeItinerary : String?
//	let connections : String?
	let totalPrice : String?
	let basePrice : String?
	let taxes : String?
	let totalPrice_API : String?
	let aPICurrencyType : String?
//	let sITECurrencyType : String?
//	let myMarkup : String?
//	let myMarkup_cal : String?
//	let aMarkup : String?
//	let aMarkup_cal : String?
//	let basePrice_Breakdown : String?
//	let taxPrice_Breakdown : String?
//	let admin_markup_amount : Int?
//	let agent_markup_amount : Int?
//	let refundable : Bool?
//	let platingCarrier : String?
//	let fareType : String?
//	let all_Passenger : String?
//	let adults : Int?
//	let adults_Base_Price : String?
//	let adults_Tax_Price : String?
//	let travelTime : String?
//	let airSegment_Key : String?
//	let baggageAllowance : [[String]]?
//	let baggage_allow_data : [[Baggage_allow_data]]?
	let flight_details : Flight_details?
	let price : Price?
//	let fare : [Fare]?
	let access_key : String?
	let selectedResult : String?
    
  //  let rreturn : Return?
  //  let onward : Onward?
   
	enum CodingKeys: String, CodingKey {

//		case airPricingSolution_Key = "AirPricingSolution_Key"
//		case completeItinerary = "CompleteItinerary"
//		case connections = "Connections"
		case totalPrice = "TotalPrice"
		case basePrice = "BasePrice"
		case taxes = "Taxes"
		case totalPrice_API = "TotalPrice_API"
		case aPICurrencyType = "APICurrencyType"
//		case sITECurrencyType = "SITECurrencyType"
//		case myMarkup = "MyMarkup"
//		case myMarkup_cal = "myMarkup_cal"
//		case aMarkup = "aMarkup"
//		case aMarkup_cal = "aMarkup_cal"
//		case basePrice_Breakdown = "BasePrice_Breakdown"
//		case taxPrice_Breakdown = "TaxPrice_Breakdown"
//		case admin_markup_amount = "admin_markup_amount"
//		case agent_markup_amount = "agent_markup_amount"
//		case refundable = "Refundable"
//		case platingCarrier = "PlatingCarrier"
//		case fareType = "FareType"
//		case all_Passenger = "All_Passenger"
//		case adults = "Adults"
//		case adults_Base_Price = "Adults_Base_Price"
//		case adults_Tax_Price = "Adults_Tax_Price"
//		case travelTime = "TravelTime"
//		case airSegment_Key = "AirSegment_Key"
//		case baggageAllowance = "BaggageAllowance"
//		case baggage_allow_data = "Baggage_allow_data"
		case flight_details = "flight_details"
		case price = "price"
//		case fare = "fare"
		case access_key = "access_key"
		case selectedResult = "selectedResult"
        
        
     //   case rreturn = "return"
     //   case onward = "onward"
    
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
//		airPricingSolution_Key = try values.decodeIfPresent(String.self, forKey: .airPricingSolution_Key)
//		completeItinerary = try values.decodeIfPresent(String.self, forKey: .completeItinerary)
//		connections = try values.decodeIfPresent(String.self, forKey: .connections)
		totalPrice = try values.decodeIfPresent(String.self, forKey: .totalPrice)
		basePrice = try values.decodeIfPresent(String.self, forKey: .basePrice)
		taxes = try values.decodeIfPresent(String.self, forKey: .taxes)
		totalPrice_API = try values.decodeIfPresent(String.self, forKey: .totalPrice_API)
		aPICurrencyType = try values.decodeIfPresent(String.self, forKey: .aPICurrencyType)
//		sITECurrencyType = try values.decodeIfPresent(String.self, forKey: .sITECurrencyType)
//		myMarkup = try values.decodeIfPresent(String.self, forKey: .myMarkup)
//		myMarkup_cal = try values.decodeIfPresent(String.self, forKey: .myMarkup_cal)
//		aMarkup = try values.decodeIfPresent(String.self, forKey: .aMarkup)
//		aMarkup_cal = try values.decodeIfPresent(String.self, forKey: .aMarkup_cal)
//		basePrice_Breakdown = try values.decodeIfPresent(String.self, forKey: .basePrice_Breakdown)
//		taxPrice_Breakdown = try values.decodeIfPresent(String.self, forKey: .taxPrice_Breakdown)
//		admin_markup_amount = try values.decodeIfPresent(Int.self, forKey: .admin_markup_amount)
//		agent_markup_amount = try values.decodeIfPresent(Int.self, forKey: .agent_markup_amount)
//		refundable = try values.decodeIfPresent(Bool.self, forKey: .refundable)
//		platingCarrier = try values.decodeIfPresent(String.self, forKey: .platingCarrier)
//		fareType = try values.decodeIfPresent(String.self, forKey: .fareType)
//		all_Passenger = try values.decodeIfPresent(String.self, forKey: .all_Passenger)
//		adults = try values.decodeIfPresent(Int.self, forKey: .adults)
//		adults_Base_Price = try values.decodeIfPresent(String.self, forKey: .adults_Base_Price)
//		adults_Tax_Price = try values.decodeIfPresent(String.self, forKey: .adults_Tax_Price)
//		travelTime = try values.decodeIfPresent(String.self, forKey: .travelTime)
//		airSegment_Key = try values.decodeIfPresent(String.self, forKey: .airSegment_Key)
//		baggageAllowance = try values.decodeIfPresent([[String]].self, forKey: .baggageAllowance)
//		baggage_allow_data = try values.decodeIfPresent([[Baggage_allow_data]].self, forKey: .baggage_allow_data)
		flight_details = try values.decodeIfPresent(Flight_details.self, forKey: .flight_details)
		price = try values.decodeIfPresent(Price.self, forKey: .price)
//		fare = try values.decodeIfPresent([Fare].self, forKey: .fare)
		access_key = try values.decodeIfPresent(String.self, forKey: .access_key)
		selectedResult = try values.decodeIfPresent(String.self, forKey: .selectedResult)
        
        
   //     rreturn = try values.decodeIfPresent(Return.self, forKey: .rreturn)
    //    onward = try values.decodeIfPresent(Onward.self, forKey: .onward)
        
     
	}

}
