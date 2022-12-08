//
//  FlightDetailsTitleTVCell.swift
//  BabSafar
//
//  Created by FCI on 07/12/22.
//

import UIKit

class FlightDetailsTitleTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateUI() {
        
    }
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        img.contentMode = .scaleToFill
        img.image = UIImage(named: "flight")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#00A898"))
        setuplabels(lbl: titlelbl, text: "Flight Details", textcolor: .AppLabelColor, font: .LatoSemibold(size: 14), align: .left)
    }
    
}
