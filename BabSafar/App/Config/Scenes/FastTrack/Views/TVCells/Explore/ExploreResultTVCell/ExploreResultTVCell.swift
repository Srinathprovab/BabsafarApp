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
            setAttributedText(str1: cellInfo?.text ?? "", str2: cellInfo?.headerText ?? "")
        }else{
            booknowView.isHidden = false
            pricelbl.isHidden = true
        }
        
    }
    

    
    @IBAction func didTapOnBookNowBtnAction(_ sender: Any) {
        delegate?.didTapOnBookNowBtnAction(cell: self)
    }
    
}



extension ExploreResultTVCell {
    
    func setAttributedText(str1:String,str2:String)  {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.AppTabSelectColor,
                      NSAttributedString.Key.font:UIFont.LatoBold(size: 12)] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.AppTabSelectColor,
                      NSAttributedString.Key.font:UIFont.LatoBold(size: 16)] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        pricelbl.attributedText = combination
        
    }
    
}
