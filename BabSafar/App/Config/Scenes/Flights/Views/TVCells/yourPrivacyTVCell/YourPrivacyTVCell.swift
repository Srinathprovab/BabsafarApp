//
//  YourPrivacyTVCell.swift
//  BabSafar
//
//  Created by MA673 on 27/07/22.
//

import UIKit
protocol YourPrivacyTVCellDelegate {
    func didTapOnShowMoreBtn(cell:YourPrivacyTVCell)
}

class YourPrivacyTVCell: TableViewCell {
    
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var textlbl: UILabel!
    @IBOutlet weak var showMoreBtn: UIButton!
    
    var delegate: YourPrivacyTVCellDelegate?
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
        
    }
    
    
    func setupUI() {
        
        titlelbl.text = "Your Privacy"
        titlelbl.textColor = .AppTabSelectColor
        titlelbl.font = UIFont.LatoRegular(size: 18)
        
        let str1 = "These are used for different purposes. By clicking on 'All cookies' you agree with our "
        let str2 = "Privacy&cookies"
        let str3 = " and we receive the non-functional cookies. Via these non-functional cookies "
        let str4 = "BABsafar"
        let str5 = "   can approach you on another site based on the pages you have visited."
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.AppLabelColor,NSAttributedString.Key.font:UIFont.LatoLight(size: 16)] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.red,NSAttributedString.Key.font:UIFont.LatoLight(size: 16),NSAttributedString.Key.link: URL(string: "http://www.google.com")!] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        let atterStr3 = NSMutableAttributedString(string: str3, attributes: atter1)
        let atterStr4 = NSMutableAttributedString(string: str4, attributes: atter2)
        let atterStr5 = NSMutableAttributedString(string: str5, attributes: atter1)
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        combination.append(atterStr3)
        combination.append(atterStr4)
        combination.append(atterStr5)
        subtitlelbl.attributedText = combination
        subtitlelbl.textColor = .AppLabelColor
        subtitlelbl.font = UIFont.LatoLight(size: 16)
        subtitlelbl.numberOfLines = 0
        
        textlbl.text = ""
        textlbl.textColor = .AppLabelColor
        textlbl.font = UIFont.LatoLight(size: 16)
        textlbl.numberOfLines = 0
        
        
        
        showMoreBtn.setTitle("Show More", for: .normal)
        showMoreBtn.setTitleColor(.AppTabSelectColor, for: .normal)
        showMoreBtn.titleLabel?.font = UIFont.LatoRegular(size: 18)
    }
    
    
    @IBAction func didTapOnShowMoreBtn(_ sender: Any) {
        delegate?.didTapOnShowMoreBtn(cell: self)
    }
    
    
}
