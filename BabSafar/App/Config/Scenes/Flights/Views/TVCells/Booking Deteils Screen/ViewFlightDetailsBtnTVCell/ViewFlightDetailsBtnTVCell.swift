//
//  ViewFlightDetailsBtnTVCell.swift
//  BabSafar
//
//  Created by FCI on 07/12/22.
//

import UIKit

protocol ViewFlightDetailsBtnTVCellDelegate {
    func didTapOnViewFlightDetailsButton(cell:ViewFlightDetailsBtnTVCell)
}

class ViewFlightDetailsBtnTVCell: TableViewCell {
    
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var viewBtn: UIButton!
    
    
    var delegate:ViewFlightDetailsBtnTVCellDelegate?
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
        btnView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 15)
        btnView.backgroundColor = HexColor("#FCEDFF")
        setuplabels(lbl: titlelbl, text: "View Flights Details", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
        viewBtn.setTitle("", for: .normal)
        viewBtn.addTarget(self, action: #selector(didTapOnViewFlightDetailsButton(_:)), for: .touchUpInside)
    }
    
    
    @objc func didTapOnViewFlightDetailsButton(_ sender:UIButton) {
        delegate?.didTapOnViewFlightDetailsButton(cell: self)
    }
    
}
