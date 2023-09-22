//
//  InsurenceResultTVCell.swift
//  BabSafar
//
//  Created by FCI on 22/08/23.
//

import UIKit

protocol InsurenceResultTVCellDelegate {
    func didTapOnSelectInsurenceBtnAction(cell:InsurenceResultTVCell)
    func didTapOnKeyBenifitsBtnAction(cell:InsurenceResultTVCell)
}

class InsurenceResultTVCell: TableViewCell {
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var planContentTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var paxCountlbl: UILabel!
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var holderView: UIView!
    
    var isExpanded = false
    var exactprice = ""
    var currency = ""
    var row = Int()
    var plancode = ""
    var plandetails = ""
    var planContent = [PlanContent]()
    var planContentBool = true
    var indexvalue = 0
    var delegate:InsurenceResultTVCellDelegate?
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
        titlelbl.text = cellInfo?.title ?? ""
        paxCountlbl.text = "For \(cellInfo?.buttonTitle ?? "") Traveller"
       
        if cellInfo?.key == "bc" {
            bottomView.isHidden = true
            selectView.isHidden = true
            bottomViewHeight.constant = 0
            contentView.backgroundColor = .WhiteColor
            self.logo.sd_setImage(with: URL(string: cellInfo?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        
            holderView.layer.cornerRadius = 4
            holderView.layer.borderWidth = 0.5
            holderView.layer.borderColor = UIColor.AppBorderColor.cgColor

        }
        
    }
    
    
    override func prepareForReuse() {
        // hide()
    }
    
    func setupUI() {
        bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        bottomView.layer.cornerRadius = 10
        bottomView.clipsToBounds = true
        paxCountlbl.text = "For \(itotalPax) Traveller"
        planContentTV.isHidden = true
     //   setupTV()
        
    }
    
    
    func setupTV() {
        planContentTV.register(UINib(nibName: "PlanContentTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        planContentTV.delegate = self
        planContentTV.dataSource = self
        planContentTV.tableFooterView = UIView()
        planContentTV.showsHorizontalScrollIndicator = false
        planContentTV.separatorStyle = .none
        planContentTV.isScrollEnabled = false
        hide()
    }
    
    
    func show() {
        planContentTV.isHidden = false
        tvHeight.constant = CGFloat(100 * planContent.count)
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded() // Animate the height change
        }
        
        planContentTV.reloadData()
    }
    
    func hide() {
        planContentTV.isHidden = true
        tvHeight.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded() // Animate the height change
        }
    }
    
    
    
    
    @IBAction func didTapOnSelectInsurenceBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectInsurenceBtnAction(cell: self)
    }
    
    @IBAction func didTapOnKeyBenifitsBtnAction(_ sender: Any) {
//        isExpanded.toggle()
//
//        updateUI()
        delegate?.didTapOnKeyBenifitsBtnAction(cell: self)
    }
    
//    private func updateUI() {
//        // Modify the UI elements in the cell based on isExpanded
//        if isExpanded {
//            // Show additional content or expand the cell as needed
//            show()
//        } else {
//            // Hide additional content or collapse the cell as needed
//            hide()
//        }
//    }
    
    
    
}


extension InsurenceResultTVCell:UITableViewDataSource,UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PlanContentTVCell {
            cell.selectionStyle = .none
            
            
            let data = planContent[indexPath.row]
            cell.titlelbl.text = data.title ?? ""
            cell.logoimg.sd_setImage(with: URL(string: data.image ?? "" ), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            
            ccell = cell
        }
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
