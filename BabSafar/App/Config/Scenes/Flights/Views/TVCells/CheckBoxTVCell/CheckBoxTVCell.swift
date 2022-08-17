//
//  CheckBoxTVCell.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit
protocol CheckBoxTVCellDelegate {
    func didTapOnCheckBoxDropDownBtn(cell:CheckBoxTVCell)
    func didTapOnShowMoreBtn(cell:CheckBoxTVCell)
    
}

class CheckBoxTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var checkOptionsTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var downImg: UIImageView!
    @IBOutlet weak var downBtn: UIButton!
    // @IBOutlet weak var showMoreBtn: UIButton!
    
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var btnViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var btnlbl: UILabel!
    @IBOutlet weak var showMoreBtn: UIButton!
    
    
    var b = true
    var nameArray = [String]()
    var tvheight = CGFloat()
    var delegate:CheckBoxTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
        if selected == true {
            expand()
        }else {
            hide()
        }
    }
    
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        nameArray = cellInfo?.data as? [String] ?? []
        //  showMoreBtn.isHidden = true
        
        switch titlelbl.text {
        case "Stops":
            downBtn.isHidden = true
            downImg.isHidden = true
            expand()
            break
            
        case "Airlines":
            //   showMoreBtn.isHidden = false
            break
            
            
        case "multicity":
            titlelbl.text = ""
            tvHeight.constant = CGFloat(nameArray.count * 50)
            break
        default:
            break
        }
        
        checkOptionsTV.reloadData()
    }
    
    func setupUI() {
        
        showMoreBtn.setTitle("", for: .normal)
        btnView.isHidden = true
        btnViewHeight.constant = 0
        tvHeight.constant = 0
        downImg.image = UIImage(named: "down")
        holderView.backgroundColor = .WhiteColor
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.LatoMedium(size: 17)
        titlelbl.numberOfLines = 0
        
        btnlbl.text = "+ Show More"
        btnlbl.textColor = .AppTabSelectColor
        btnlbl.font = UIFont.LatoRegular(size: 18)
        
        downBtn.setTitle("", for: .normal)
        downBtn.addTarget(self, action: #selector(didTapOnCheckBoxDropDownBtn(_:)), for: .touchUpInside)
        downBtn.isHidden = true
    }
    
    func setupTV() {
        checkOptionsTV.register(UINib(nibName: "checkOptionsTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        checkOptionsTV.delegate = self
        checkOptionsTV.dataSource = self
        checkOptionsTV.separatorStyle = .none
        checkOptionsTV.tableFooterView = UIView()
        checkOptionsTV.isScrollEnabled = false
        checkOptionsTV.allowsMultipleSelection = true
    }
    
    
    @objc func didTapOnCheckBoxDropDownBtn(_ sender: UIButton){
        delegate?.didTapOnCheckBoxDropDownBtn(cell: self)
    }
    
    
    func hide() {
        tvHeight.constant = 0
        btnView.isHidden = true
        btnViewHeight.constant = 0
    }
    func expand() {
        tvHeight.constant = CGFloat(nameArray.count * 50)
        if nameArray.count > 3 {
            btnView.isHidden = false
            btnViewHeight.constant = 30
        }else {
            btnView.isHidden = true
            btnViewHeight.constant = 0
        }
    }
    
    @IBAction func didTapOnShowMoreBtn(_ sender: Any) {
        delegate?.didTapOnShowMoreBtn(cell: self)
    }
    
    
}


extension CheckBoxTVCell:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if nameArray.count > 3 {
            return 3
        }else {
            return nameArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? checkOptionsTVCell {
            cell.selectionStyle = .none
            cell.titlelbl.text = nameArray[indexPath.row]
            commonCell = cell
        }
        return commonCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? checkOptionsTVCell
        print(cell?.titlelbl.text as Any)
        cell?.checkImg.image = UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? checkOptionsTVCell
        cell?.checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
    }
    
}
