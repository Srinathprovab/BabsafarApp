//
//  ExploreResultTVCell.swift
//  BabSafar
//
//  Created by FCI on 04/09/23.
//

import UIKit
protocol ExploreResultTVCellDelegate {
    func didTapOnBookNowBtnAction(cell:ExploreResultTVCell)
}

class ExploreResultTVCell: TableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    
    var delegate:ExploreResultTVCellDelegate?
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
        //  img.sd_setImage(with: URL(string: cellInfo?.image ?? "" ), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
    }
    
    
    @IBAction func didTapOnBookNowBtnAction(_ sender: Any) {
        delegate?.didTapOnBookNowBtnAction(cell: self)
    }
    
}
