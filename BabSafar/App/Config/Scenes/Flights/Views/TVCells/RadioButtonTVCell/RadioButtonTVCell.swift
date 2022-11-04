//
//  RadioButtonTVCell.swift
//  AirportProject
//
//  Created by Codebele 09 on 22/06/22.
//

import UIKit
protocol RadioButtonTVCellDelegate {
    func didTapOnRadioButton(cell:RadioButtonTVCell)
}

class RadioButtonTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var radioImg: UIImageView!

    var delegate: RadioButtonTVCellDelegate?
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
        titlelbl.text = cellInfo?.title
    }
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        
        titlelbl.textColor = .AppLabelColor
        titlelbl.textAlignment = .left
        titlelbl.font = UIFont.OpenSansMedium(size: 18)
        
        radioImg.image = UIImage(named: "radioUnselected")
    }
    
    
    func show() {
        radioImg.image = UIImage(named: "radioSelected")
    }
    
    
    func hide() {
        radioImg.image = UIImage(named: "radioUnselected")
    }

}
