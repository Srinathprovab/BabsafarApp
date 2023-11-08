//
//  MBFlightData.swift
//  BabSafar
//
//  Created by FCI on 06/12/22.
//

import Foundation

struct MBFlightData : Codable {
    let all_Passenger : String?
    let myMarkup_cal : String?
    let aMarkup : String?
    let adults : Int?
    // let fare : [Fare]?
    //    let adults_Total_Price : Double?
    //    let totalPrice_API : Double?
    //    let aPICurrencyType : String?
    //    let adults_Tax_Price : Int?
    //  let attr : MBAtter?
    //   let flight_details : Flight_details?
    //   let taxes : Double?
    //   let aMarkup_cal : String?
    //  let resultToken : String?
    //  let totalPrice : Double?
    //  let basePrice : Double?
    //   let adults_Base_Price : Double?
    //    let price : Price?
    //    let price : Price?
    // let myMarkup : String?
    let sITECurrencyType : String?
    let flightDetails : MBFlightDetails?
    
    enum CodingKeys: String, CodingKey {
        
        case all_Passenger = "All_Passenger"
        case myMarkup_cal = "myMarkup_cal"
        case aMarkup = "aMarkup"
        case adults = "Adults"
        //   case fare = "fare"
        //        case adults_Total_Price = "Adults_Total_Price"
        //        case totalPrice_API = "TotalPrice_API"
        //        case aPICurrencyType = "APICurrencyType"
        //        case adults_Tax_Price = "Adults_Tax_Price"
        //   case attr = "Attr"
        //   case flight_details = "flight_details"
        //  case taxes = "Taxes"
        //   case aMarkup_cal = "aMarkup_cal"
        //        case resultToken = "ResultToken"
        //        case totalPrice = "TotalPrice"
        //        case basePrice = "BasePrice"
        //        case adults_Base_Price = "Adults_Base_Price"
        //        case price = "Price"
        //        case price = "price"
        //   case myMarkup = "MyMarkup"
        case sITECurrencyType = "SITECurrencyType"
        case flightDetails = "flight_details"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        all_Passenger = try values.decodeIfPresent(String.self, forKey: .all_Passenger)
        myMarkup_cal = try values.decodeIfPresent(String.self, forKey: .myMarkup_cal)
        aMarkup = try values.decodeIfPresent(String.self, forKey: .aMarkup)
        adults = try values.decodeIfPresent(Int.self, forKey: .adults)
        //    fare = try values.decodeIfPresent([Fare].self, forKey: .fare)
        //        adults_Total_Price = try values.decodeIfPresent(Double.self, forKey: .adults_Total_Price)
        //        totalPrice_API = try values.decodeIfPresent(Double.self, forKey: .totalPrice_API)
        //        aPICurrencyType = try values.decodeIfPresent(String.self, forKey: .aPICurrencyType)
        //        adults_Tax_Price = try values.decodeIfPresent(Int.self, forKey: .adults_Tax_Price)
        //    attr = try values.decodeIfPresent(MBAtter.self, forKey: .attr)
        //      flight_details = try values.decodeIfPresent(Flight_details.self, forKey: .flight_details)
        //    taxes = try values.decodeIfPresent(Double.self, forKey: .taxes)
        //     aMarkup_cal = try values.decodeIfPresent(String.self, forKey: .aMarkup_cal)
        //        resultToken = try values.decodeIfPresent(String.self, forKey: .resultToken)
        //        totalPrice = try values.decodeIfPresent(Double.self, forKey: .totalPrice)
        //        basePrice = try values.decodeIfPresent(Double.self, forKey: .basePrice)
        //        adults_Base_Price = try values.decodeIfPresent(Double.self, forKey: .adults_Base_Price)
        //        price = try values.decodeIfPresent(Price.self, forKey: .price)
        //        price = try values.decodeIfPresent(Price.self, forKey: .price)
        //   myMarkup = try values.decodeIfPresent(String.self, forKey: .myMarkup)
        sITECurrencyType = try values.decodeIfPresent(String.self, forKey: .sITECurrencyType)
        flightDetails = try values.decodeIfPresent(MBFlightDetails.self, forKey: .flightDetails)
    }
    
}
