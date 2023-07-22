//
//  AddRoomsGuestsTVCell.swift
//  BabSafar
//
//  Created by FCI on 17/12/22.
//

import UIKit
protocol AddRoomsGuestsTVCellDelegate {
    func closeBtnAction(cell:AddRoomsGuestsTVCell)
    func adultsIncrementButtonAction(cell:AddRoomsGuestsTVCell)
    func adultsDecrementBtnAction(cell:AddRoomsGuestsTVCell)
    func childrenIncrementButtonAction(cell:AddRoomsGuestsTVCell)
    func childrenDecrementBtnAction(cell:AddRoomsGuestsTVCell)
}

class AddRoomsGuestsTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var adultslbl: UILabel!
    @IBOutlet weak var adultsSubtitlelbl: UILabel!
    @IBOutlet weak var aIncrementBtn: UIButton!
    @IBOutlet weak var adultsCountlbl: UILabel!
    @IBOutlet weak var aDecrementBtn: UIButton!
    @IBOutlet weak var childrenlbl: UILabel!
    @IBOutlet weak var childrenSubtitlelbl: UILabel!
    @IBOutlet weak var cIncrementBtn: UIButton!
    @IBOutlet weak var childrenCountlbl: UILabel!
    @IBOutlet weak var cDecrementBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var closeBtnView: UIView!
    
    
    
    var adultcount = 1
    var childCount = Int()
    var delegate:AddRoomsGuestsTVCellDelegate?
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
        closeBtnView.isHidden = false
        adultcount = 1
        childCount = 0
        adultsCountlbl.text = "1"
        childrenCountlbl.text = "0"
    }
    
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        aIncrementBtn.tag = cellInfo?.characterLimit ?? 0
        cIncrementBtn.tag = cellInfo?.characterLimit ?? 0
        
        if titlelbl.text == "Room 1" {
            closeBtnView.isHidden = true
        }
    }
    
    
    func setupUI() {
        
        setuplabels(lbl: titlelbl, text: "Room 1", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .left)
        setuplabels(lbl: adultslbl, text: "Adults", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .left)
        setuplabels(lbl: adultsSubtitlelbl, text: "from 12 yeras old", textcolor: HexColor("#A6A6A6"), font: .RobotMedium(size: 13), align: .left)
        setuplabels(lbl: adultsCountlbl, text: "1", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .center)
        aIncrementBtn.setTitle("", for: .normal)
        aDecrementBtn.setTitle("", for: .normal)
        
        setuplabels(lbl: childrenlbl, text: "Children", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .left)
        setuplabels(lbl: childrenSubtitlelbl, text: "2 - 11 yeras old", textcolor: HexColor("#A6A6A6"), font: .RobotMedium(size: 13), align: .left)
        setuplabels(lbl: childrenCountlbl, text: "0", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .center)
        cIncrementBtn.setTitle("", for: .normal)
        cDecrementBtn.setTitle("", for: .normal)
        closeBtn.setTitle("", for: .normal)
        closeBtnView.isHidden = false
        
        
    }
    
    
    @IBAction func adultsIncrementButtonAction(_ sender: Any) {
        delegate?.adultsIncrementButtonAction(cell: self)
    }
    
    @IBAction func adultsDecrementBtnAction(_ sender: Any) {
        delegate?.adultsDecrementBtnAction(cell: self)
    }
    
    
    @IBAction func childrenIncrementButtonAction(_ sender: Any) {
        delegate?.childrenIncrementButtonAction(cell: self)
    }
    
    @IBAction func childrenDecrementBtnAction(_ sender: Any) {
        delegate?.childrenDecrementBtnAction(cell: self)
    }
    
    @IBAction func closeBtnAction(_ sender: Any) {
        delegate?.closeBtnAction(cell: self)
    }
    
    
    
}
