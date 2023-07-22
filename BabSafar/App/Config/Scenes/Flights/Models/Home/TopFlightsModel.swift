//
//  TopFlightsModel.swift
//  BabSafar
//
//  Created by FCI on 17/11/22.
//

import Foundation

struct TopFlightDetailsModel : Codable {
    
    
    let status : Bool?
    let topFlightDetails : [TopFlightDetails]?
    let topHotelDetails : [TopHotelDetails]?
    let deail_code_list : [Deail_code_list]?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case topFlightDetails = "topFlightDetails"
        case topHotelDetails = "topHotelDetails"
        case deail_code_list = "deail_code_list"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        topFlightDetails = try values.decodeIfPresent([TopFlightDetails].self, forKey: .topFlightDetails)
        topHotelDetails = try values.decodeIfPresent([TopHotelDetails].self, forKey: .topHotelDetails)
        deail_code_list = try values.decodeIfPresent([Deail_code_list].self, forKey: .deail_code_list)
    }
    
}

struct TopFlightDetails : Codable {
    let id : String?
    let from_city : String?
    let to_city : String?
    let travel_date : String?
    let return_date : String?
    let image : String?
    let status : String?
    let voucher_status : String?
    let voucher : String?
    let airline_id : String?
    let airline_class : String?
    let trip_type : String?
    let price : String?
    let created_at : String?
    let updated_at : String?
    let from_airport_name : String?
    let to_airport_name : String?
    let from_city_name : String?
    let airport_code : String?
    let from_city_loc : String?
    let from_country : String?
    let to_city_name : String?
    let to_country : String?
    let to_city_loc : String?
    let airport_name : String?
    let fromFlight : String?
    let toFlight : String?
    let topFlightImg : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case from_city = "from_city"
        case to_city = "to_city"
        case travel_date = "travel_date"
        case return_date = "return_date"
        case image = "image"
        case status = "status"
        case voucher_status = "voucher_status"
        case voucher = "voucher"
        case airline_id = "airline_id"
        case airline_class = "airline_class"
        case trip_type = "trip_type"
        case price = "price"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case from_airport_name = "from_airport_name"
        case to_airport_name = "to_airport_name"
        case from_city_name = "from_city_name"
        case airport_code = "airport_code"
        case from_city_loc = "from_city_loc"
        case from_country = "from_country"
        case to_city_name = "to_city_name"
        case to_country = "to_country"
        case to_city_loc = "to_city_loc"
        case airport_name = "airport_name"
        case fromFlight = "fromFlight"
        case toFlight = "toFlight"
        case topFlightImg = "topFlightImg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        from_city = try values.decodeIfPresent(String.self, forKey: .from_city)
        to_city = try values.decodeIfPresent(String.self, forKey: .to_city)
        travel_date = try values.decodeIfPresent(String.self, forKey: .travel_date)
        return_date = try values.decodeIfPresent(String.self, forKey: .return_date)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        voucher_status = try values.decodeIfPresent(String.self, forKey: .voucher_status)
        voucher = try values.decodeIfPresent(String.self, forKey: .voucher)
        airline_id = try values.decodeIfPresent(String.self, forKey: .airline_id)
        airline_class = try values.decodeIfPresent(String.self, forKey: .airline_class)
        trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        from_airport_name = try values.decodeIfPresent(String.self, forKey: .from_airport_name)
        to_airport_name = try values.decodeIfPresent(String.self, forKey: .to_airport_name)
        from_city_name = try values.decodeIfPresent(String.self, forKey: .from_city_name)
        airport_code = try values.decodeIfPresent(String.self, forKey: .airport_code)
        from_city_loc = try values.decodeIfPresent(String.self, forKey: .from_city_loc)
        from_country = try values.decodeIfPresent(String.self, forKey: .from_country)
        to_city_name = try values.decodeIfPresent(String.self, forKey: .to_city_name)
        to_country = try values.decodeIfPresent(String.self, forKey: .to_country)
        to_city_loc = try values.decodeIfPresent(String.self, forKey: .to_city_loc)
        airport_name = try values.decodeIfPresent(String.self, forKey: .airport_name)
        fromFlight = try values.decodeIfPresent(String.self, forKey: .fromFlight)
        toFlight = try values.decodeIfPresent(String.self, forKey: .toFlight)
        topFlightImg = try values.decodeIfPresent(String.self, forKey: .topFlightImg)
    }

}





struct TopHotelDetails : Codable {
    let id : String?
    let title : String?
    let city_name : String?
    let city : String?
    let check_in : String?
    let check_out : String?
    let image : String?
    let voucher_status : String?
    let voucher : String?
    let price : String?
    let status : String?
    let created_at : String?
    let updated_at : String?
    let ar_title : String?
    let hotel_code : String?
    let country : String?
    let country_name : String?
    let topHotelImg : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case city_name = "city_name"
        case city = "city"
        case check_in = "check_in"
        case check_out = "check_out"
        case image = "image"
        case voucher_status = "voucher_status"
        case voucher = "voucher"
        case price = "price"
        case status = "status"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case ar_title = "ar_title"
        case hotel_code = "hotel_code"
        case country = "country"
        case country_name = "country_name"
        case topHotelImg = "topHotelImg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        check_in = try values.decodeIfPresent(String.self, forKey: .check_in)
        check_out = try values.decodeIfPresent(String.self, forKey: .check_out)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        voucher_status = try values.decodeIfPresent(String.self, forKey: .voucher_status)
        voucher = try values.decodeIfPresent(String.self, forKey: .voucher)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        ar_title = try values.decodeIfPresent(String.self, forKey: .ar_title)
        hotel_code = try values.decodeIfPresent(String.self, forKey: .hotel_code)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        topHotelImg = try values.decodeIfPresent(String.self, forKey: .topHotelImg)
    }

}
