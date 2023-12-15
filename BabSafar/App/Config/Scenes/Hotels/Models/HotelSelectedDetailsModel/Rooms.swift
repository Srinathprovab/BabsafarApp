

import Foundation
struct Rooms : Codable {
    let boardName : String?
    let currency : String?
    let cancellationPolicies : [CancellationPolicies]?
    let rooms : Int?
    let adults : Int?
    let net : String?
    let xml_currency : String?
    let booking_reference : String?
    let rateKey : String?
    let code : String?
    let image : String?
    let children : Int?
    let childrenAges : String?
    let promotions : String?
    let refund : Int?
    let name : String?
    let xml_net : String?

    enum CodingKeys: String, CodingKey {

        case boardName = "boardName"
        case currency = "currency"
        case cancellationPolicies = "cancellationPolicies"
        case rooms = "rooms"
        case adults = "adults"
        case net = "net"
        case xml_currency = "xml_currency"
        case booking_reference = "booking_reference"
        case rateKey = "rateKey"
        case code = "code"
        case image = "image"
        case children = "children"
        case childrenAges = "childrenAges"
        case promotions = "promotions"
        case refund = "refund"
        case name = "name"
        case xml_net = "xml_net"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        boardName = try values.decodeIfPresent(String.self, forKey: .boardName)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        cancellationPolicies = try values.decodeIfPresent([CancellationPolicies].self, forKey: .cancellationPolicies)
        rooms = try values.decodeIfPresent(Int.self, forKey: .rooms)
        adults = try values.decodeIfPresent(Int.self, forKey: .adults)
        net = try values.decodeIfPresent(String.self, forKey: .net)
        xml_currency = try values.decodeIfPresent(String.self, forKey: .xml_currency)
        booking_reference = try values.decodeIfPresent(String.self, forKey: .booking_reference)
        rateKey = try values.decodeIfPresent(String.self, forKey: .rateKey)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        children = try values.decodeIfPresent(Int.self, forKey: .children)
        childrenAges = try values.decodeIfPresent(String.self, forKey: .childrenAges)
        promotions = try values.decodeIfPresent(String.self, forKey: .promotions)
        refund = try values.decodeIfPresent(Int.self, forKey: .refund)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        xml_net = try values.decodeIfPresent(String.self, forKey: .xml_net)
    }

}
