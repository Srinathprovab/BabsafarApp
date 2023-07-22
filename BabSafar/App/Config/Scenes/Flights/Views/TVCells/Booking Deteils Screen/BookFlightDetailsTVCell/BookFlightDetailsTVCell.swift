//
//  BookFlightDetailsTVCell.swift
//  BabSafar
//
//  Created by FCI on 07/12/22.
//

import UIKit

protocol BookFlightDetailsTVCellDelegate {
    func didTapOnviewFlifgtDetailsBtn(cell:BookFlightDetailsTVCell)
}

class BookFlightDetailsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var detailsTV: UITableView!
    @IBOutlet weak var refundlbl: UILabel!
//    @IBOutlet weak var kwdlbl: UILabel!
//    @IBOutlet weak var perpersonlbl: UILabel!
    @IBOutlet weak var viewFlightDetailsBtnView: UIView!
    @IBOutlet weak var viewFlifgtDetailslbl: UILabel!
    @IBOutlet weak var viewFlifgtDetailsBtn: UIButton!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    var mbdetails:[Summary]?
    var delegate:BookFlightDetailsTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        
        tvHeight.constant = CGFloat((mbSummery.count ) * 105)
        self.detailsTV.reloadData()
    }
    
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 5)
        setuplabels(lbl: refundlbl, text: "", textcolor: HexColor("#288419"), font: .LatoRegular(size: 14), align: .center)
//        setuplabels(lbl: kwdlbl, text: "Refundable", textcolor: .RefundableColor, font: .LatoBold(size: 16), align: .right)
//        setuplabels(lbl: perpersonlbl, text: "\(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy")", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .right)
//
//
//        perpersonlbl.isHidden = true
//        kwdlbl.isHidden = true
        
        viewFlightDetailsBtnView.backgroundColor = HexColor("#FFCC33")
        viewFlightDetailsBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 5)
        setuplabels(lbl: viewFlifgtDetailslbl, text: "Flight Details", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .center)
        viewFlifgtDetailsBtn.setTitle("", for: .normal)
        
        
    }
    
    
    func setupTV() {
        
        let nib = UINib(nibName: "ViewFlightFromToDetailsTVCell", bundle: nil)
        detailsTV.register(nib, forCellReuseIdentifier: "cell")
        detailsTV.delegate = self
        detailsTV.dataSource = self
        detailsTV.isScrollEnabled = false
        detailsTV.showsHorizontalScrollIndicator = false
        detailsTV.tableFooterView = UIView()
        detailsTV.separatorStyle = .none
    }
    
    
    @IBAction func didTapOnviewFlifgtDetailsBtn(_ sender: Any) {
        delegate?.didTapOnviewFlifgtDetailsBtn(cell: self)
    }
    
    
}



extension BookFlightDetailsTVCell :UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mbSummery.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ViewFlightFromToDetailsTVCell {
            cell.selectionStyle = .none
            
            let data = mbSummery[indexPath.row]
            cell.fromtimelbl.text = data.origin?.time
            cell.fromCityShortlbl.text = data.origin?.city
            cell.totimelbl.text = data.destination?.time
            cell.toCityShortlbl.text = data.destination?.city
            cell.hourslbl.text = data.duration
            cell.noStopslbl.text = "\(String(data.no_of_stops ?? 0)) Stops"
            cell.airwaysImg.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            cell.titlelbl.text = data.operator_name
            cell.subtitlelbl.text = "(\(data.operator_code ?? "") \(data.flight_number ?? ""))"
            
            if cellInfo?.title == "Refundable" {
                setuplabels(lbl: refundlbl, text: "Refundable", textcolor: HexColor("#2FA804"), font: .LatoRegular(size: 14), align: .center)

                
            }else {
                setuplabels(lbl: refundlbl, text: "Non Refundable", textcolor: HexColor("#EC441E"), font: .LatoRegular(size: 14), align: .center)

            }
            
            
            commonCell = cell
        }
        return commonCell
    }
    
    
}
