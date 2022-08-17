//
//  AddTravellerTVCell.swift
//  BabSafar
//
//  Created by MA673 on 25/07/22.
//

import UIKit
protocol AddTravellerTVCellDelegate {
    func didTapOnAddAdultBtn(cell:AddTravellerTVCell)
    func didTapOnAddChildBtn(cell:AddTravellerTVCell)
    
    func didTapOnEditAdultBtn(cell:AddTravellerTVCell)
    func didTapOnEditChildtBtn(cell:AddTravellerTVCell)
    
    
}
class AddTravellerTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titleHolderView: UIView!
    @IBOutlet weak var travelImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var addAdultHolderView: UIView!
    @IBOutlet weak var addChildHolderView: UIView!
    @IBOutlet weak var adultlbl: UILabel!
    @IBOutlet weak var childlbl: UILabel!
    @IBOutlet weak var addAdultBtnView: UIView!
    @IBOutlet weak var addlbl: UILabel!
    @IBOutlet weak var addAdultBtn: UIButton!
    @IBOutlet weak var addChildBtnView: UIView!
    @IBOutlet weak var addchildlbl: UILabel!
    @IBOutlet weak var addChildBtn: UIButton!
    @IBOutlet weak var totalNoOfTravellerlbl: UILabel!
    @IBOutlet weak var addAdultTV: UITableView!
    @IBOutlet weak var adultTVHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var addChildTV: UITableView!
    @IBOutlet weak var addChildTVHeight: NSLayoutConstraint!
    var delegate:AddTravellerTVCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupAdultTV()
        setupChildTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        //         adultsArray = cellInfo?.moreData as? [String] ?? []
        //        childArray = cellInfo?.moreData as? [String] ?? []
        
        print("adultsArray[0] -- > \(adultsArray.count)")
        //        adultsArray = ["adult1","adult2"]
        //        childArray = ["child1","child2"]
        
        switch cellInfo?.key {
        case "hotel":
            travelImg.image = UIImage(named: "travel")
            titlelbl.text = cellInfo?.title
            totalNoOfTravellerlbl.text = cellInfo?.subTitle
        default:
            break
        }
        
        
        if adultsArray.count > 0 {
            let height = adultsArray.count * 50
            adultTVHeight.constant = CGFloat(height)
        }
        
        
        if childArray.count > 0 {
            let height = childArray.count * 50
            addChildTVHeight.constant = CGFloat(height)
        }
        
        self.contentView.layoutIfNeeded()
        self.addAdultTV.reloadData()
        self.addChildTV.reloadData()
    }
    
    func setupUI() {
        adultTVHeight.constant = 0
        addChildTVHeight.constant = 0
        
        contentView.backgroundColor = .AppBorderColor
        setupViews(v: holderView, radius: 4, color: .WhiteColor)
        holderView.layer.borderColor = UIColor.WhiteColor.cgColor
        setupViews(v: titleHolderView, radius: 0, color: .WhiteColor)
        titleHolderView.addBottomBorderWithColor(color: .AppBorderColor, width: 1)
        addAdultHolderView.addBottomBorderWithColor(color: .AppBorderColor, width: 1)
        addChildHolderView.addBottomBorderWithColor(color: .AppBorderColor, width: 1)
        setupViews(v: addAdultHolderView, radius: 0, color: .WhiteColor)
        setupViews(v: addChildHolderView, radius: 0, color: .WhiteColor)
        setupViews(v: addAdultBtnView, radius: 15, color: HexColor("#FCEDFF"))
        setupViews(v: addChildBtnView, radius: 15, color: HexColor("#FCEDFF"))
        // setupViews(v: adultTVView, radius: 0, color: .green)
        
        travelImg.image = UIImage(named: "travel")?.withRenderingMode(.alwaysOriginal)
        setupLabels(lbl: titlelbl, text: "Traveller Details", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16))
        setupLabels(lbl: adultlbl, text: "Adult", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: childlbl, text: "Child", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: addlbl, text: "+ Add", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: addchildlbl, text: "+ Add", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: totalNoOfTravellerlbl, text: "Total No Of  Tra : 2", textcolor: .AppCalenderDateSelectColor, font: .LatoRegular(size: 12))
        
        addAdultBtn.setTitle("", for: .normal)
        addChildBtn.setTitle("", for: .normal)
        
        
    }
    
    
    func setupAdultTV() {
        addAdultTV.register(UINib(nibName: "AddAdultsOrGuestTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        addAdultTV.delegate = self
        addAdultTV.dataSource = self
        addAdultTV.tableFooterView = UIView()
        addAdultTV.separatorStyle = .none
        addAdultTV.showsHorizontalScrollIndicator = false
    }
    
    func setupChildTV() {
        addChildTV.register(UINib(nibName: "AddAdultsOrGuestTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
        addChildTV.delegate = self
        addChildTV.dataSource = self
        addChildTV.tableFooterView = UIView()
        addChildTV.separatorStyle = .none
        addChildTV.showsHorizontalScrollIndicator = false
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    @objc func didTapOnEditAdultBtn(_ sender:UIButton) {
        delegate?.didTapOnEditAdultBtn(cell: self)
    }
    
    
    @objc func didTapOnEditChildtBtn(_ sender:UIButton) {
        delegate?.didTapOnEditChildtBtn(cell: self)
    }
    
    
    @IBAction func didTapOnAddAdultBtn(_ sender: Any) {
        delegate?.didTapOnAddAdultBtn(cell: self)
    }
    
    
    @IBAction func didTapOnAddChildBtn(_ sender: Any) {
        delegate?.didTapOnAddChildBtn(cell: self)
    }
    
}


extension AddTravellerTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == addAdultTV {
            return adultsArray.count
        }else {
            return childArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if tableView == addAdultTV {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddAdultsOrGuestTVCell {
                cell.selectionStyle = .none
                cell.titlelbl.text = adultsArray[indexPath.row]
                cell.editBtn.addTarget(self, action: #selector(didTapOnEditAdultBtn(_:)), for: .touchUpInside)
                ccell = cell
            }
            
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? AddAdultsOrGuestTVCell {
                cell.selectionStyle = .none
                cell.titlelbl.text = childArray[indexPath.row]
                cell.editBtn.addTarget(self, action: #selector(didTapOnEditChildtBtn(_:)), for: .touchUpInside)
                ccell = cell
            }
        }
        
        return ccell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
