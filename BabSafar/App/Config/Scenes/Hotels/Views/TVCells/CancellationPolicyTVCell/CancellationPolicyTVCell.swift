//
//  CancellationPolicyTVCell.swift
//  BabSafar
//
//  Created by Admin on 24/06/24.
//

import UIKit

class CancellationPolicyTVCell: UITableViewCell {

    @IBOutlet weak var titlelblb: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        setuplabels(lbl: titlelblb,
                    text: "",
                    textcolor: .titleLabelColor,
                    font: .poppinsRegular(size: 14),
                    align: .left)
        
        setuplabels(lbl: subtitlelbl,
                    text: "",
                    textcolor: .titleLabelColor,
                    font: .poppinsRegular(size: 14),
                    align: .left)
    }
    
}
