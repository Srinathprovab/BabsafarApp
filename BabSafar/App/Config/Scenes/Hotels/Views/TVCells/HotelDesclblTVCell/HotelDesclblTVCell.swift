//
//  HotelDesclblTVCell.swift
//  BabSafar
//
//  Created by FCI on 25/08/23.
//

import UIKit

class HotelDesclblTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //    override func updateUI() {
    //       // titlelbl.text = cellInfo?.title ?? ""
    //
    //        // Assuming `hoteldisc` is an optional Hotel_desc object
    //        if let hotelDesc = cellInfo?.moreData as? Hotel_desc {
    //            // Access the properties of the hotel_desc object and set them as the text of subTitlelbl
    //            titlelbl.text = """
    //                Meals: \(hotelDesc.meals ?? "")
    //                Location: \(hotelDesc.location ?? "")
    //                Facilities: \(hotelDesc.facilities ?? "")
    //                Payment: \(hotelDesc.payment ?? "")
    //                Rooms: \(hotelDesc.rooms ?? "")
    //                Sports/Entertainment: \(hotelDesc.sportsEntertainment ?? "")
    //            """
    //        } else {
    //            // Handle the case where hoteldisc is nil
    //            titlelbl.text = ""
    //        }
    //    }
    
    
    override func updateUI() {
        
        
        // Assuming `hoteldisc` is an optional Hotel_desc object
        if let hotelDesc = cellInfo?.moreData as? Hotel_desc {
            // Create a mutable attributed string
            let attributedText = NSMutableAttributedString(string: "")
            
            // Add the "Meals" heading with bold font attribute
            let mealsHeadingText = "Meals:"
            let boldAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.LatoBold(size: titlelbl.font.pointSize)
            ]
            attributedText.append(NSAttributedString(string: mealsHeadingText, attributes: boldAttributes))
            attributedText.append(NSAttributedString(string: "\n\(hotelDesc.meals ?? "")\n"))
            
            
            // Add the "Location" heading with bold font attribute
            let locationHeadingText = "\nLocation:"
            attributedText.append(NSAttributedString(string: locationHeadingText, attributes: boldAttributes))
            attributedText.append(NSAttributedString(string: "\n\(hotelDesc.location ?? "")\n"))
            
            
            
            // Add the "Facilities" heading with bold font attribute
            let facilitiesHeadingText = "\nFacilities:"
            attributedText.append(NSAttributedString(string: facilitiesHeadingText, attributes: boldAttributes))
            attributedText.append(NSAttributedString(string: "\n\(hotelDesc.facilities ?? "")\n"))
            
            
            
            // Add the "Payment" heading with bold font attribute
            let paymentHeadingText = "\nPayment:"
            attributedText.append(NSAttributedString(string: paymentHeadingText, attributes: boldAttributes))
            attributedText.append(NSAttributedString(string: "\n\(hotelDesc.payment ?? "")\n"))
            
            
            
            // Add the "Rooms" heading with bold font attribute
            let roomsHeadingText = "\nRooms:"
            attributedText.append(NSAttributedString(string: roomsHeadingText, attributes: boldAttributes))
            attributedText.append(NSAttributedString(string: "\n\(hotelDesc.rooms ?? "")\n"))
            
            
            
            // Add the "Sports/Entertainment" heading with bold font attribute
            let sportsEntertainmentHeadingText = "\nSports/Entertainment:"
            attributedText.append(NSAttributedString(string: sportsEntertainmentHeadingText, attributes: boldAttributes))
            attributedText.append(NSAttributedString(string: "\n\(hotelDesc.sportsEntertainment ?? "")\n"))
            
            
            // Add the content for each section
           
           
           
           
           
          
            // Set the attributed text to subTitlelbl
            titlelbl.attributedText = attributedText
        } else {
            // Handle the case where hoteldisc is nil
            titlelbl.text = ""
        }
    }
    
    
}
