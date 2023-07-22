//
//  PaymentOptionTVCell.swift
//  BabSafar
//
//  Created by FCI on 23/02/23.
//

import UIKit

protocol PaymentOptionTVCellDelegate {
    func didTapOnSelectPaymentOptionBtn(cell:PaymentOptionTVCell)
}

class PaymentOptionTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var logoimg: UIImageView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var tapopOptionBtn: UIButton!
    
    
    var delegate:PaymentOptionTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        
    }
    
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        logoimg.image = UIImage(named: cellInfo?.image ?? "")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    func setupUI() {
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 15), align: .left)
        checkImg.image = UIImage(named: "unselected")?.withRenderingMode(.alwaysOriginal)
        checkImg.contentMode = .scaleToFill
        logoimg.contentMode = .scaleToFill
        tapopOptionBtn.setTitle("", for: .normal)
        tapopOptionBtn.isHidden = true
    }
    
    
    
    func selected() {
        checkImg.image = UIImage(named: "selected")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
    }
    
    func unselected() {
        checkImg.image = UIImage(named: "unselected")?.withRenderingMode(.alwaysOriginal)
    }
    
    @IBAction func didTapOnSelectPaymentOptionBtn(_ sender: Any) {
        delegate?.didTapOnSelectPaymentOptionBtn(cell: self)
    }
}
