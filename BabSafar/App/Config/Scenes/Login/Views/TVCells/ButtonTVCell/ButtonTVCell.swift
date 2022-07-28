//
//  ButtonTVCell.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit

protocol ButtonTVCellDelegate {
    func btnAction(cell: ButtonTVCell)
    func didTapOnDualBtn1(cell: ButtonTVCell)
    func didTapOnDualBtn2(cell: ButtonTVCell)
}

class ButtonTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var btnImg: UIImageView!
    
    @IBOutlet weak var dualBtnsView: UIStackView!
    @IBOutlet weak var dualBtn1View: UIView!
    @IBOutlet weak var dualBtnlbl1: UILabel!
    @IBOutlet weak var dualBtn1: UIButton!
    
    @IBOutlet weak var dualBtn2View: UIView!
    @IBOutlet weak var dualBtnlbl2: UILabel!
    @IBOutlet weak var dualBtn2: UIButton!
    
    var delegate:ButtonTVCellDelegate?
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
        
        switch cellInfo?.key {
        case "booked":
            btnView.backgroundColor = .clear
            titlelbl.textColor = .AppBtnColor
            btnImg.isHidden = false
            titlelbl.font = UIFont.LatoRegular(size: 18)
            break
            
        case "privacy":
            btnView.isHidden = true
            dualBtnsView.isHidden = false
            break
        default:
            break
        }
    }
    
    func setupUI(){
        
        holderView.backgroundColor = .WhiteColor
        btnView.backgroundColor = .AppBtnColor
        btnView.layer.cornerRadius = 4
        btnView.clipsToBounds = true
        titlelbl.textColor = .WhiteColor
        titlelbl.font = UIFont.LatoSemibold(size: 20)
        btnImg.image = UIImage(named: "download")?.withRenderingMode(.alwaysOriginal)
        btnImg.isHidden = true
        btn.setTitle("", for: .normal)
        
        btnView.isHidden = false
        dualBtnsView.isHidden = true
        
        
        setupViews(v: dualBtn1View, radius: 4, color: .AppBtnColor)
        setupViews(v: dualBtn2View, radius: 4, color: .WhiteColor)
        setupLabels(lbl: dualBtnlbl1, text: "All Cookies", textcolor: .WhiteColor, font: .LatoRegular(size: 18))
        setupLabels(lbl: dualBtnlbl2, text: "Necessary Cookies", textcolor: .AppLabelColor, font: .LatoRegular(size: 18))
        dualBtn1.setTitle("", for: .normal)
        dualBtn2.setTitle("", for: .normal)
        
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    @IBAction func btnAction(_ sender: Any) {
        delegate?.btnAction(cell: self)
    }
    
    @IBAction func didTapOnDualBtn1(_ sender: Any) {
        delegate?.didTapOnDualBtn1(cell: self)
        dualBtnlbl1.textColor = .WhiteColor
        dualBtn1View.backgroundColor = .AppBtnColor
        dualBtnlbl2.textColor = .AppLabelColor
        dualBtn2View.backgroundColor = .WhiteColor
    }
    
    
    @IBAction func didTapOnDualBtn2(_ sender: Any) {
        delegate?.didTapOnDualBtn2(cell: self)
        dualBtnlbl1.textColor = .AppLabelColor
        dualBtn1View.backgroundColor = .WhiteColor
        dualBtnlbl2.textColor = .WhiteColor
        dualBtn2View.backgroundColor = .AppBtnColor
    }
}
