

import Foundation
struct RegisterModel : Codable {
    let status : Bool?
    let data : UserRegisterDetails?
    let msg :String?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case data = "data"
        case msg = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(UserRegisterDetails.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }
    
}
