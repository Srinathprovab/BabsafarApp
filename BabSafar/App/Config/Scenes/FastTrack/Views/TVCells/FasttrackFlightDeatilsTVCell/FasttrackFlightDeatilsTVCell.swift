//
//  FasttrackFlightDeatilsTVCell.swift
//  BabSafar
//
//  Created by FCI on 24/08/23.
//

import UIKit


protocol FasttrackFlightDeatilsTVCellDelegate {
    func didTapOnChangeSelectionBtnAction(cell:FasttrackFlightDeatilsTVCell)
}

class FasttrackFlightDeatilsTVCell: TableViewCell {

    
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var airportNamelbl: UILabel!
    @IBOutlet weak var terminallbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var changeSelectionView: BorderedView!
    @IBOutlet weak var priceView: UIStackView!
    
    
    var delegate:FasttrackFlightDeatilsTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupUI(){
        changeSelectionView.isHidden = true
    }
    
    
    override func updateUI() {
        logoImg.image = UIImage(named: cellInfo?.image ?? "")?.withRenderingMode(.alwaysOriginal)
        airportNamelbl.text = cellInfo?.title ?? ""
        terminallbl.text = cellInfo?.subTitle ?? ""
        pricelbl.text = cellInfo?.price ?? ""
    }
    
    
    @IBAction func didTapOnChangeSelectionBtnAction(_ sender: Any) {
        delegate?.didTapOnChangeSelectionBtnAction(cell: self)
    }
    
}
