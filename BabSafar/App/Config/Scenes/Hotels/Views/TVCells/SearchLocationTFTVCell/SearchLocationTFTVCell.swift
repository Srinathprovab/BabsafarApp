//
//  SearchLocationTFTVCell.swift
//  BabSafar
//
//  Created by MA673 on 29/07/22.
//

import UIKit
protocol SearchLocationTFTVCellDelegate {
    func editingTextField(tf:UITextField)
    func mapViewBtnAction(cell:SearchLocationTFTVCell)
}

class SearchLocationTFTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var mapBtnView: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var mapImg: UIImageView!
    @IBOutlet weak var mapViewBtn: UIButton!
    
    
    var delegate:SearchLocationTFTVCellDelegate?
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
        mapBtnView.backgroundColor = .AppTabSelectColor
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        searchImg.image = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        mapImg.image = UIImage(named: "map")
        searchTF.delegate = self
        searchTF.backgroundColor = .clear
        searchTF.setLeftPaddingPoints(20)
        searchTF.placeholder = "Search Location /City"
        searchTF.font = UIFont.ManropeMedium(size: 18)
        searchTF.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        
        mapViewBtn.setTitle("", for: .normal)
    }
    
    
    @objc func editingText(textField:UITextField) {
        delegate?.editingTextField(tf: textField)
    }
    
    @IBAction func mapViewBtnAction(_ sender: Any) {
        delegate?.mapViewBtnAction(cell: self)
    }
    
    
}
