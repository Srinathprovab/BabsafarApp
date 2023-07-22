//
//  TravellerEconomyTVCell.swift
//  AirportProject
//
//  Created by Codebele 09 on 22/06/22.
//

import UIKit

protocol TravellerEconomyTVCellDelegate {
    func didTapOnDecrementButton(cell:TravellerEconomyTVCell)
    func didTapOnIncrementButton(cell:TravellerEconomyTVCell)
}

class TravellerEconomyTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    @IBOutlet weak var decrementView: UIView!
    @IBOutlet weak var decrementImg: UIImageView!
    @IBOutlet weak var countlbl: UILabel!
    @IBOutlet weak var incrementView: UIView!
    @IBOutlet weak var incrementImg: UIImageView!
    
    var delegate: TravellerEconomyTVCellDelegate?
    var count = 0
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
        subTitlelbl.text = cellInfo?.subTitle
        
        
        if titlelbl.text == "Adults" {
            count = Int(cellInfo?.text ?? "1") ?? 1
        }else {
            count = Int(cellInfo?.text ?? "0") ?? 0
        }
        
        countlbl.text = cellInfo?.text
        
    }
    
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        holderView.layer.cornerRadius = 5
        holderView.clipsToBounds = true
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.viewBorderColor.cgColor
        
        
        decrementView.backgroundColor = .clear
        decrementView.layer.cornerRadius = 15
        decrementView.clipsToBounds = true
        incrementView.layer.cornerRadius = 15
        incrementView.clipsToBounds = true
        
        titlelbl.textColor = .AppLabelColor
        titlelbl.textAlignment = .left
        titlelbl.font = UIFont.OpenSansMedium(size: 18)
        
        
        subTitlelbl.textColor = .AppLabelColor
        subTitlelbl.textAlignment = .left
        subTitlelbl.font = UIFont.LatoLight(size: 14)
        
      
        countlbl.textColor = .AppLabelColor
        countlbl.textAlignment = .center
        countlbl.font = UIFont.OpenSansMedium(size: 18)
        
//        decrementView.backgroundColor = .buttonBGColor
//        incrementView.backgroundColor = .buttonBGColor
        
        incrementImg.image = UIImage(named: "incr")
        decrementImg.image = UIImage(named: "decr")
        
    }
    
    
    @IBAction func didTapOnDecrementButton(_ sender: Any) {
        delegate?.didTapOnDecrementButton(cell: self)
    }
    
    @IBAction func didTapOnIncrementButton(_ sender: Any) {
        delegate?.didTapOnIncrementButton(cell: self)
    }
    
    
}
