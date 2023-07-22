//
//  FrequentFlyerTVCell.swift
//  BabSafar
//
//  Created by FCI on 02/03/23.
//

import UIKit
import DropDown

protocol FrequentFlyerTVCellDelegate {
    func didTapOnFlayerProgramBtn(cell:FrequentFlyerTVCell)
    func didTapOnSelectFlayerNoBtn(cell:FrequentFlyerTVCell)
}

class FrequentFlyerTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var optionallbl: UILabel!
    @IBOutlet weak var frequentflyerprogramlbl: UILabel!
    @IBOutlet weak var selectFlyerProgramView: UIView!
    @IBOutlet weak var selectFlyerProgramlbl: UILabel!
    @IBOutlet weak var selectFlyerProgramBtn: UIButton!
    @IBOutlet weak var frequentflyerNumberlbl: UILabel!
    @IBOutlet weak var selectFlyerNoView: UIView!
    @IBOutlet weak var selectFlyerNolbl: UILabel!
    @IBOutlet weak var selectFlyerNoBtn: UIButton!
    
    var countryNameArray = [String]()
    let dropDown = DropDown()
    var delegate:FrequentFlyerTVCellDelegate?
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
        countrylist.forEach { i in
            countryNameArray.append(i.name ?? "")
        }
        dropDown.dataSource = countryNameArray
        setupDropDown()
    }
    
    
    
    
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: titlelbl, text: "Frequent Flyer", textcolor: .AppLabelColor, font: .ManropeMedium(size: 16), align: .left)
        setuplabels(lbl: optionallbl, text: "(options)", textcolor: .AppCalenderDateSelectColor, font: .ManropeMedium(size: 16), align: .left)
        setuplabels(lbl: frequentflyerprogramlbl, text: "Frequent flyer program", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .left)
        setuplabels(lbl: frequentflyerNumberlbl, text: "Frequent flyer number", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .left)
        setuplabels(lbl: selectFlyerProgramlbl, text: "Country", textcolor: .SubTitleColor, font: .ManropeMedium(size: 16), align: .left)
        setuplabels(lbl: selectFlyerNolbl, text: "Country", textcolor: .SubTitleColor, font: .ManropeMedium(size: 16), align: .left)
        selectFlyerProgramView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        selectFlyerNoView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        selectFlyerProgramView.backgroundColor = .WhiteColor
        selectFlyerNoView.backgroundColor = .WhiteColor
        selectFlyerProgramBtn.setTitle("", for: .normal)
        selectFlyerNoBtn.setTitle("", for: .normal)
    }
    
    
    func setupDropDown() {
        
        dropDown.direction = .any
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.selectFlyerNoView
        dropDown.bottomOffset = CGPoint(x: 0, y: selectFlyerNoView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.selectFlyerNolbl.text = item
            self?.selectFlyerNolbl.textColor = .AppLabelColor
            self?.delegate?.didTapOnSelectFlayerNoBtn(cell: self!)
        }
    }
    
    
    @IBAction func didTapOnFlayerProgramBtn(_ sender: Any) {
        delegate?.didTapOnFlayerProgramBtn(cell: self)
    }
    
    
    
    @IBAction func didTapOnSelectFlayerNoBtn(_ sender: Any) {
        dropDown.show()
    }
    
    
}
