//
//  UsePromoCodesTVCell.swift
//  AlghanimTravelApp
//
//  Created by MA673 on 07/09/22.
//

import UIKit

protocol UsePromoCodesTVCellDelegate {
    func didTapOnViewAllPromoCodesBtn(cell:UsePromoCodesTVCell)
    func didTapOnApplyPromosCodesBtn(cell:UsePromoCodesTVCell)
    func editingChanged(tf:UITextField)
}

class UsePromoCodesTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var viewAllView: UIView!
    @IBOutlet weak var viewAlllbl: UILabel!
    @IBOutlet weak var viewAllBtn: UIButton!
    @IBOutlet weak var tfHolderView: UIView!
    @IBOutlet weak var codesTF: UITextField!
    @IBOutlet weak var applyBtn: UIButton!
    @IBOutlet weak var promoCodesTV: UITableView!
    @IBOutlet weak var promoCodesTVHeight: NSLayoutConstraint!
    @IBOutlet weak var titleView: UIStackView!
    
    var delegate:UsePromoCodesTVCellDelegate?
    //   var promoCodesList = [MBPromoCodeList]()
    var promocodecode = String()
    var promocodeval = String()
    var index = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    var count = Int()
    override func updateUI() {
        
        //   promoCodesList = cellInfo?.moreData as! [MBPromoCodeList]
        count = cellInfo?.characterLimit ?? 0
        //     promoCodesTVHeight.constant = CGFloat(promoCodesList.count * 40)
        
        promoCodesTVHeight.constant = CGFloat(0 * 44)
        
        
        switch cellInfo?.key {
        case "promo":
            titlelbl.textAlignment = .center
            logoImg.isHidden = true
            viewAllView.isHidden = true
            holderView.addCornerRadiusWithShadow(color: .WhiteColor, borderColor: .WhiteColor, cornerRadius: 0)
            break
        default:
            break
        }
        
        
        promoCodesTV.reloadData()
    }
    
    
    func setupUI() {
        
        
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 5)
        holderView.backgroundColor = .WhiteColor
        logoImg.image = UIImage(named: "promo1")?.withRenderingMode(.alwaysOriginal)
        logoImg.contentMode = .scaleToFill
        setuplabels(lbl: titlelbl, text: "Have promo-code (optional)", textcolor: .AppLabelColor, font: .poppinsMedium(size: 16), align: .left)
        setuplabels(lbl: viewAlllbl, text: "ViewAll", textcolor: .WhiteColor, font: .poppinsMedium(size: 12), align: .center)
        tfHolderView.addCornerRadiusWithShadow(color: .clear, borderColor: HexColor("#CECECE",alpha: 0.5), cornerRadius: 5)
        tfHolderView.backgroundColor = .WhiteColor
        codesTF.delegate = self
        codesTF.setLeftPaddingPoints(10)
        codesTF.placeholder = "Enter Promo Codes"
        codesTF.font = .poppinsMedium(size: 15)
        codesTF.isSecureTextEntry = false
        codesTF.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        viewAllView.backgroundColor = .AppBtnColor
        viewAllBtn.setTitle("", for: .normal)
        applyBtn.setTitle("Apply", for: .normal)
        //applyBtn.setTitleColor(HexColor("#12A5F8"), for: .normal)
        applyBtn.titleLabel?.font = UIFont.poppinsMedium(size: 15)
        viewAllView.isHidden = true
        
        setupTV()
    }
    
    
    
    func setupTV() {
        let nib = UINib(nibName: "RadioButtonTVCell", bundle: nil)
        promoCodesTV.register(nib, forCellReuseIdentifier: "cell")
        promoCodesTV.delegate = self
        promoCodesTV.dataSource = self
        promoCodesTV.tableFooterView = UIView()
        promoCodesTV.separatorStyle = .none
        promoCodesTV.isScrollEnabled = false
    }
    
    
    @objc func editingChanged(_ tf: UITextField){
        delegate?.editingChanged(tf: tf)
    }
    
    
    
    @IBAction func didTapOnViewAllPromoCodesBtn(_ sender: Any) {
        delegate?.didTapOnViewAllPromoCodesBtn(cell: self)
    }
    
    
    @IBAction func didTapOnApplyPromosCodesBtn(_ sender: Any) {
        //        defaults.set(promoCodesList[self.index].promo_code, forKey: UserDefaultsKeys.promocodecode)
        //        defaults.set(promoCodesList[self.index].value, forKey: UserDefaultsKeys.promocodeval)
        delegate?.didTapOnApplyPromosCodesBtn(cell: self)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "apply"), object: self.index)
    }
    
}



extension UsePromoCodesTVCell:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? RadioButtonTVCell {
            cell.titlelbl.text = "Use Code  & Save Up to KWD 5 "
            ccell = cell
        }
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RadioButtonTVCell {
            cell.show()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RadioButtonTVCell {
            cell.hide()
        }
    }
    
    
}
