//
//  TextViewTVCell.swift
//  BabSafar
//
//  Created by MA673 on 29/07/22.
//

import UIKit

class TextViewTVCell: TableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var desView: UITextView!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    
    
    var placeHolder = String()
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
        placeHolder = cellInfo?.title ?? ""
        
        switch cellInfo?.key {
        case "visa":
            leftConstraint.constant = 28
            break
        default:
            break
        }
    }
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        desView.layer.cornerRadius = 5
        desView.clipsToBounds = true
        desView.layer.borderWidth = 1
        desView.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        
        desView.delegate = self
        desView.setPlaceholder(ph: placeHolder)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.checkPlaceholder()
    }
    
}
extension UITextView{
    
    func setPlaceholder(ph:String) {
        
        let placeholderLabel = UILabel()
        placeholderLabel.text = "Descript/Remarks"
        placeholderLabel.font = UIFont.LatoLight(size: 14)
        placeholderLabel.sizeToFit()
        placeholderLabel.tag = 222
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (self.font?.pointSize)! / 2)
        placeholderLabel.textColor = .AppLabelColor
        placeholderLabel.isHidden = !self.text.isEmpty
        
        self.addSubview(placeholderLabel)
    }
    
    func checkPlaceholder() {
        let placeholderLabel = self.viewWithTag(222) as! UILabel
        placeholderLabel.isHidden = !self.text.isEmpty
    }
    
}
