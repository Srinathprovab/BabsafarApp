//
//  InsurenceExploreResultTVCell.swift
//  BabSafar
//
//  Created by FCI on 29/08/23.
//

import UIKit

protocol InsurenceExploreResultTVCellDelegate {
    func didTapOnBookNowBtnAction(cell:InsurenceExploreResultTVCell)
}

class InsurenceExploreResultTVCell: TableViewCell {

    
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    
    
    var delegate:InsurenceExploreResultTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title ?? ""
    }
    
    @IBAction func didTapOnBookNowBtnAction(_ sender: Any) {
        delegate?.didTapOnBookNowBtnAction(cell: self)
    }
    
    
}
