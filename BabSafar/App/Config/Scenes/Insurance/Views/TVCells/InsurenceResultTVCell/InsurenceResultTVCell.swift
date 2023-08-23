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

class InsurenceResultTVCell: UITableViewCell {
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var planContentTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
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
    
    
    override func prepareForReuse() {
        hide()
    }
    
    func setupUI() {
        bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        bottomView.layer.cornerRadius = 10
        bottomView.clipsToBounds = true
        setupTV()
        
    }
    
    
    func setupTV() {
        planContentTV.register(UINib(nibName: "PlanContentTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        planContentTV.delegate = self
        planContentTV.dataSource = self
        planContentTV.tableFooterView = UIView()
        planContentTV.showsHorizontalScrollIndicator = false
        planContentTV.separatorStyle = .none
        planContentTV.isScrollEnabled = false
        
        show()
    }
    
    
    func show(){
        self.planContentTV.isHidden = false
        self.tvHeight.constant = 200
        self.planContentBool = false
        self.planContentTV.reloadData()
    }
    
    func hide(){
        self.planContentTV.isHidden = true
        self.tvHeight.constant = 0
        self.planContentBool = true
        self.planContentTV.reloadData()
    }
    
    
    @IBAction func didTapOnSelectInsurenceBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectInsurenceBtnAction(cell: self)
    }
    
    @IBAction func didTapOnKeyBenifitsBtnAction(_ sender: Any) {
        delegate?.didTapOnKeyBenifitsBtnAction(cell: self)
    }
    
   
    
    
    
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
