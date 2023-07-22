//
//  LoignOrSignupBtnsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit

protocol LoignOrSignupBtnsTVCellDelegate {
    func didTapOnLoginBtn(cell:LoignOrSignupBtnsTVCell)
    func didTapOnSignUpBtn(cell:LoignOrSignupBtnsTVCell)
}

class LoignOrSignupBtnsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginlbl: UILabel!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var signuplbl: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    var delegate:LoignOrSignupBtnsTVCellDelegate?
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
        holderView.backgroundColor = .WhiteColor
        loginView.backgroundColor = .AppTabSelectColor
        signUpView.backgroundColor = .WhiteColor
        stackView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        
        setuplabels(lbl: loginlbl, text: "Login", textcolor: .WhiteColor, font: UIFont.LatoMedium(size: 18), align: .center)
        setuplabels(lbl: signuplbl, text: "Sign Up", textcolor: .AppLabelColor, font: UIFont.LatoMedium(size: 18), align: .center)
        
        
    }
    
    
    @IBAction func didTapOnLoginBtn(_ sender: Any) {
        delegate?.didTapOnLoginBtn(cell: self)
    }
    
    @IBAction func didTapOnSignUpBtn(_ sender: Any) {
        delegate?.didTapOnSignUpBtn(cell: self)
    }
    
}
