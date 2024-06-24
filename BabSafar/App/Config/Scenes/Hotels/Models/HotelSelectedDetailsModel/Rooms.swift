

import Foundation
struct Rooms : Codable {
    let booking_source : String?
    let childrenAges : String?
    let code : String?
    let cancellationPolicies : [CancellationPolicies]?
    let allotment : String?
    let rateCommentsId : String?
    let boardCode : String?
    let boardName : String?
    let currency : String?
    let rate_plan_code : String?
    let image : String?
    let adults : String?
    let xml_currency : String?
    let children : String?
    let name : String?
    let rateClass : String?
    let roomtypecode : String?
    let allocationdetails : String?
    let room_count : Int?
    let net : String?
    let rooms : Int?
    let room_no : Int?
    let room_selected : Int?
    let refund : String?
    let xml_net : Int?
    let booking_reference : String?
    let rateKey : String?

    enum CodingKeys: String, CodingKey {

        case booking_source = "booking_source"
        case childrenAges = "childrenAges"
        case code = "code"
        case cancellationPolicies = "cancellationPolicies"
        case allotment = "allotment"
        case rateCommentsId = "rateCommentsId"
        case boardCode = "boardCode"
        case boardName = "boardName"
        case currency = "currency"
        case rate_plan_code = "rate_plan_code"
        case image = "image"
        case adults = "adults"
        case xml_currency = "xml_currency"
        case children = "children"
        case name = "name"
        case rateClass = "rateClass"
        case roomtypecode = "roomtypecode"
        case allocationdetails = "allocationdetails"
        case room_count = "room_count"
        case net = "net"
        case rooms = "rooms"
        case room_no = "room_no"
        case room_selected = "room_selected"
        case refund = "refund"
        case xml_net = "xml_net"
        case booking_reference = "booking_reference"
        case rateKey = "rateKey"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        childrenAges = try values.decodeIfPresent(String.self, forKey: .childrenAges)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        cancellationPolicies = try values.decodeIfPresent([CancellationPolicies].self, forKey: .cancellationPolicies)
        allotment = try values.decodeIfPresent(String.self, forKey: .allotment)
        rateCommentsId = try values.decodeIfPresent(String.self, forKey: .rateCommentsId)
        boardCode = try values.decodeIfPresent(String.self, forKey: .boardCode)
        boardName = try values.decodeIfPresent(String.self, forKey: .boardName)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        rate_plan_code = try values.decodeIfPresent(String.self, forKey: .rate_plan_code)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        adults = try values.decodeIfPresent(String.self, forKey: .adults)
        xml_currency = try values.decodeIfPresent(String.self, forKey: .xml_currency)
        children = try values.decodeIfPresent(String.self, forKey: .children)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        rateClass = try values.decodeIfPresent(String.self, forKey: .rateClass)
        roomtypecode = try values.decodeIfPresent(String.self, forKey: .roomtypecode)
        allocationdetails = try values.decodeIfPresent(String.self, forKey: .allocationdetails)
        room_count = try values.decodeIfPresent(Int.self, forKey: .room_count)
        net = try values.decodeIfPresent(String.self, forKey: .net)
        rooms = try values.decodeIfPresent(Int.self, forKey: .rooms)
        room_no = try values.decodeIfPresent(Int.self, forKey: .room_no)
        room_selected = try values.decodeIfPresent(Int.self, forKey: .room_selected)
        refund = try values.decodeIfPresent(String.self, forKey: .refund)
        xml_net = try values.decodeIfPresent(Int.self, forKey: .xml_net)
        booking_reference = try values.decodeIfPresent(String.self, forKey: .booking_reference)
        rateKey = try values.decodeIfPresent(String.self, forKey: .rateKey)
    }

}
