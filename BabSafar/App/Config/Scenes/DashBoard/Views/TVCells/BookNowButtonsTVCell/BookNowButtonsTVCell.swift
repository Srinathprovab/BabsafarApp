//
//  BookNowButtonsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

protocol BookNowButtonsTVCellDelegate {
    func didTapOnKWDBtn(cell:BookNowButtonsTVCell)
    func didTapOnBookNowBtn(cell:BookNowButtonsTVCell)
}

class BookNowButtonsTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var kwdView: UIView!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var kwdBtn: UIButton!
    @IBOutlet weak var bookNowView: UIView!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    
    
    var delegate:BookNowButtonsTVCellDelegate?
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
        
        setupViews(v: holderView, radius: 0, color: .WhiteColor)
        setupViews(v: kwdView, radius: 0, color: HexColor("#67CDEC"))
        setupViews(v: bookNowView, radius: 0, color: .AppBtnColor)
        setupLabels(lbl: kwdlbl, text: "KWD:150.00", textcolor: .WhiteColor, font: .LatoMedium(size: 18))
        setupLabels(lbl: bookNowlbl, text: "Book Now", textcolor: .WhiteColor, font: .LatoMedium(size: 18))
        
        kwdBtn.setTitle("", for: .normal)
        bookNowBtn.setTitle("", for: .normal)
        
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        //        v.layer.borderWidth = 1
        //        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    @IBAction func didTapOnKWDBtn(_ sender: Any) {
        delegate?.didTapOnKWDBtn(cell: self)
    }
    
    
    @IBAction func didTapOnBookNowBtn(_ sender: Any) {
        delegate?.didTapOnBookNowBtn(cell: self)
    }
    
    
    
}
