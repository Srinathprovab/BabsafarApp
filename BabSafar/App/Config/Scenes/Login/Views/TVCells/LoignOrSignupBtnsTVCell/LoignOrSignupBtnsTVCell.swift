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
        loginView.layer.cornerRadius = 4
        loginView.layer.borderWidth = 1
        loginView.layer.borderColor = UIColor.AppBorderColor.cgColor
        signUpView.backgroundColor = .WhiteColor
        signUpView.layer.cornerRadius = 4
        signUpView.layer.borderWidth = 1
        signUpView.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        loginlbl.text = "Login"
        loginlbl.textColor = .WhiteColor
        loginlbl.font = UIFont.LatoMedium(size: 18)
        
        signuplbl.text = "Sign Up"
        signuplbl.textColor = .AppLabelColor
        signuplbl.font = UIFont.LatoMedium(size: 18)
    }
    
    
    @IBAction func didTapOnLoginBtn(_ sender: Any) {
        delegate?.didTapOnLoginBtn(cell: self)
    }
    
    @IBAction func didTapOnSignUpBtn(_ sender: Any) {
        delegate?.didTapOnSignUpBtn(cell: self)
    }
    
}
