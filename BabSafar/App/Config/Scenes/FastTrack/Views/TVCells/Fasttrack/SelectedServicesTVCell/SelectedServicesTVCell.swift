//
//  SelectedServicesTVCell.swift
//  BabSafar
//
//  Created by FCI on 24/08/23.
//

import UIKit


protocol SelectedServicesTVCellDelegate {
    func didTapOnCancelCardBtnAction(cell:SelectedServicesTVCell)
    
}

class SelectedServicesTVCell: TableViewCell {
    
    
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var fromAirportNamelbl: UILabel!
    @IBOutlet weak var terminallbl: UILabel!
    @IBOutlet weak var priceView: UIStackView!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var cancelView: BorderedView!
    @IBOutlet weak var closeBtn: UIButton!

    var tapedservicetype = ""
    var index = Int()
    var delegate:SelectedServicesTVCellDelegate?
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
        logoImg.image = UIImage(named: cellInfo?.image ?? "")?.withRenderingMode(.alwaysOriginal)
        fromAirportNamelbl.text = cellInfo?.title ?? ""
        terminallbl.text = cellInfo?.subTitle ?? ""
        
        
        setAttributedTextnew(str1: cellInfo?.text ?? "",
                             str2: cellInfo?.price ?? "",
                             lbl: pricelbl,
                             str1font: .LatoBold(size: 12),
                             str2font: .LatoBold(size: 18),
                             str1Color: .IttenarySelectedColor,
                             str2Color: .IttenarySelectedColor)
    }
    
    
    func setupUI() {
        priceView.isHidden = true
        closeView.isHidden = true
        
        closeView.layer.maskedCorners = [.layerMinXMinYCorner] // Top left corner, Top right corner respectively
        closeView.layer.cornerRadius = 5
        closeView.clipsToBounds = true
    }
    
    
    @IBAction func didTapOnChangeSelectionBtnAction(_ sender: Any) {
        delegate?.didTapOnCancelCardBtnAction(cell: self)
    }
    
    
    
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        var userinfo = [String:Any]()
        userinfo["type"] = tapedservicetype
        userinfo["index"] = index
        NotificationCenter.default.post(name: NSNotification.Name("closebtnindex"), object: index,userInfo: userinfo)
    }
    

}
