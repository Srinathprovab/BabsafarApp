//
//  DropDownTVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit
import DropDown


protocol DropDownTVCellDelegate {
    func didTapOnDropDownBtn(cell:DropDownTVCell)
}

class DropDownTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var dropdownView: UIView!
    @IBOutlet weak var dropdownlbl: UILabel!
    @IBOutlet weak var dropdownImg: UIImageView!
    @IBOutlet weak var dropdownBtn: UIButton!
    
    var delegate:DropDownTVCellDelegate?
    var optionArray = [String]()
    let dropDown = DropDown()
    var nationality:String?
    var nationalitycode = String()
    var issuingCountry:String?
    var issuingCountrycode = String()
    
   
    
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
        dropdownlbl.text = cellInfo?.text
        dropdownImg.image = UIImage(named: cellInfo?.image ?? "")
        dropdownBtn.tag = cellInfo?.characterLimit ?? 0
        var countryNameArray = [String]()
        countrylist.forEach { i in
            countryNameArray.append(i.name ?? "")
        }
        dropDown.dataSource = countryNameArray
        
        setupDropDown()
      
        
//        switch self.titlelbl.text {
//        case "Nationality":
//            self.dropdownlbl.text = self.nationality ?? "Nationality"
//            break
//
//        case "Issuing Country":
//            self.dropdownlbl.text = self.issuingCountry ?? "Issuing Country"
//            break
//
//        default:
//            break
//        }
        
   
        
        switch cellInfo?.key1 {
        case "editnationality":
            dropdownlbl.text = edit_nationalityname
            dropdownlbl.textColor = .AppLabelColor
            break
        case "editissuingcountry":
            dropdownlbl.text = edit_issuingCountryname
            dropdownlbl.textColor = .AppLabelColor
            break
        default:
            break
        }
    }
    
    
    func setupDropDown() {
        
        dropDown.direction = .any
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.dropdownBtn
        dropDown.bottomOffset = CGPoint(x: 0, y: dropdownView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.dropdownlbl.text = item
            self?.dropdownlbl.textColor = .AppLabelColor
            
            switch self?.titlelbl.text {
            case "Nationality":
                self?.nationality = self?.dropdownlbl.text ?? ""
                self?.nationalitycode = countrylist[index].origin ?? ""
                
                break
                
            case "Issuing Country":
                self?.issuingCountry = self?.dropdownlbl.text ?? ""
                self?.issuingCountrycode = countrylist[index].country_code ?? ""
                break
                
            default:
                break
            }
            self?.delegate?.didTapOnDropDownBtn(cell: self!)
        }
    }
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        dropdownView.backgroundColor = .WhiteColor
        dropdownView.layer.cornerRadius = 4
        dropdownView.clipsToBounds = true
        dropdownView.layer.borderColor = UIColor.AppBorderColor.cgColor
        dropdownView.layer.borderWidth = 1
        
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.LatoRegular(size: 14)
        
        dropdownlbl.textColor = HexColor("#CECECE")
        dropdownlbl.font = UIFont.LatoMedium(size: 18)
        dropdownBtn.setTitle("", for: .normal)
        
    }
    
    @IBAction func didTapOnDropDownBtn(_ sender: Any) {
        if self.titlelbl.text == "Date Of Travel" {
            dropDown.hide()
        }else {
            dropDown.show()
        }
        
     //   delegate?.didTapOnDropDownBtn(cell: self)
    }
    
}
