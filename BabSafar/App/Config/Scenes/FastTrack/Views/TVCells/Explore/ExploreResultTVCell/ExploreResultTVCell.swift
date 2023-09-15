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
    @IBOutlet weak var booknowView: BorderedView!
    @IBOutlet weak var pricelbl: UILabel!
    
   
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
       
        
        if cellInfo?.key == "booking" {
            booknowView.isHidden = true
            pricelbl.isHidden = false
            pricelbl.text = cellInfo?.subTitle
            titlelbl.text = cellInfo?.title
            
            setAttributedTextnew(str1: cellInfo?.text ?? "",
                                 str2: cellInfo?.headerText ?? "",
                                 lbl: pricelbl,
                                 str1font: .LatoBold(size: 12),
                                 str2font: .LatoBold(size: 18),
                                 str1Color: .IttenarySelectedColor,
                                 str2Color: .IttenarySelectedColor)
        
            
        }else{
            booknowView.isHidden = false
            pricelbl.isHidden = true
        }
        
    }
    

    
    @IBAction func didTapOnBookNowBtnAction(_ sender: Any) {
        delegate?.didTapOnBookNowBtnAction(cell: self)
    }
    
}



