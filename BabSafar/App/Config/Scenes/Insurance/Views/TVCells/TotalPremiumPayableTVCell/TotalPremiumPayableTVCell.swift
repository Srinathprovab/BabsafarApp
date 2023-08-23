//
//  TotalPremiumPayableTVCell.swift
//  BabSafar
//
//  Created by FCI on 23/08/23.
//

import UIKit

protocol TotalPremiumPayableTVCellDelegate {
    func didTapOnCloseBtnAction(cell:TotalPremiumPayableTVCell)
}

class TotalPremiumPayableTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var plancontentTV: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    
    var delegate:TotalPremiumPayableTVCellDelegate?
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
        pricelbl.text = cellInfo?.title ?? ""
        
        tvheight.constant = CGFloat(selectedPlanContent.count * 100)
        plancontentTV.reloadData()
    }
    
    
    func setupUI() {
        setupTV(tv: plancontentTV)
    }
    
    
    func setupTV(tv:UITableView) {
        plancontentTV.isScrollEnabled = false
        let nib = UINib(nibName: "PlanContentTVCell", bundle: nil)
        tv.register(nib, forCellReuseIdentifier: "cell")
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView()
        tv.separatorStyle = .none
    }
    
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        delegate?.didTapOnCloseBtnAction(cell: self)
    }
    
    
    
}


extension TotalPremiumPayableTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedPlanContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PlanContentTVCell {
            cell.selectionStyle = .none
            
            let data = selectedPlanContent[indexPath.row]
            cell.titlelbl.text = data.title ?? ""
            cell.logoimg.sd_setImage(with: URL(string: data.image ?? "" ), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            c = cell
        }
        return c
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
