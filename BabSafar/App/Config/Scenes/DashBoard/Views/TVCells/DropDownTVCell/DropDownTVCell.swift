//
//  DropDownTVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit
protocol DropDownTVCellDelegate {
    func didTapOnDropDownBtn(cell:DropDownTVCell)
}

class DropDownTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var dropdownView: UIView!
    @IBOutlet weak var dropdownlbl: UILabel!
    @IBOutlet weak var dropdownImg: UIImageView!
    @IBOutlet weak var dropdownBtn: UIButton!
    
    var delegate:DropDownTVCellDelegate?
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
        dropdownlbl.text = cellInfo?.subTitle
        dropdownImg.image = UIImage(named: cellInfo?.image ?? "")
    }
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        dropdownView.backgroundColor = .WhiteColor
        dropdownView.layer.cornerRadius = 4
        dropdownView.clipsToBounds = true
        dropdownView.layer.borderColor = UIColor.AppBorderColor.cgColor
        dropdownView.layer.borderWidth = 1
        
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.LatoRegular(size: 14)
        
        dropdownlbl.textColor = HexColor("#CECECE")
        dropdownlbl.font = UIFont.LatoMedium(size: 18)
        dropdownBtn.setTitle("", for: .normal)
    }
    
    @IBAction func didTapOnDropDownBtn(_ sender: Any) {
        delegate?.didTapOnDropDownBtn(cell: self)
    }
}
