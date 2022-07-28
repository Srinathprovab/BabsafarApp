//
//  MyBookingVC.swift
//  BabSafar
//
//  Created by MA673 on 27/07/22.
//

import UIKit

class MyBookingVC: BaseTableVC {
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var buttonsHolderView: UIView!
    @IBOutlet weak var upCommingView: UIView!
    @IBOutlet weak var completedView: UIView!
    @IBOutlet weak var cancelledView: UIView!
    @IBOutlet weak var upComminglbl: UILabel!
    @IBOutlet weak var upCommingBtn: UIButton!
    @IBOutlet weak var completedlbl: UILabel!
    @IBOutlet weak var completedBtn: UIButton!
    @IBOutlet weak var cancelledlbl: UILabel!
    @IBOutlet weak var cancelledBtn: UIButton!
    
    @IBOutlet weak var upcomingUL: UIView!
    @IBOutlet weak var completedUL: UIView!
    @IBOutlet weak var cancelledUL: UIView!
    
    
    var tablerow = [TableRow]()
    static var newInstance: MyBookingVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? MyBookingVC
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        nav.titlelbl.text = "My Bookings"
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        nav.mainTabBtnsView.isHidden = false
        
        setupViews(v: buttonsHolderView, radius: 0, color: .WhiteColor)
        setupViews(v: upCommingView, radius: 0, color: .WhiteColor)
        setupViews(v: completedView, radius: 0, color: .WhiteColor)
        setupViews(v: cancelledView, radius: 0, color: .WhiteColor)
        upcomingUL.backgroundColor = .AppLabelColor
        completedUL.backgroundColor = .WhiteColor
        cancelledUL.backgroundColor = .WhiteColor
        
        setupLabels(lbl: upComminglbl, text: "Up Coming", textcolor: .AppLabelColor, font: .LatoRegular(size: 16))
        setupLabels(lbl: completedlbl, text: "Completed", textcolor: .AppLabelColor.withAlphaComponent(0.50), font: .LatoRegular(size: 16))
        setupLabels(lbl: cancelledlbl, text: "Cancelled", textcolor: .AppLabelColor.withAlphaComponent(0.50), font: .LatoRegular(size: 16))
        
        upCommingBtn.setTitle("", for: .normal)
        completedBtn.setTitle("", for: .normal)
        cancelledBtn.setTitle("", for: .normal)
        
        commonTableView.registerTVCells(["SearchFlightResultTVCell","EmptyTVCell"])
        setuptv()
    }
    
    
    func setuptv() {
        tablerow.removeAll()
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tablerow.append(TableRow(key:"mybooking",cellType:.SearchFlightResultTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
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
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    override func didTapOnViewVoucherBtn(cell: SearchFlightResultTVCell) {
        print("didTapOnViewVoucherBtn")
    }
    

    
    
    @IBAction func didTapOnUpComingBtn(_ sender: Any) {
        upComminglbl.textColor = .AppLabelColor
        upcomingUL.backgroundColor = .AppLabelColor
        
        completedlbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        completedUL.backgroundColor = .WhiteColor
        
        cancelledlbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        cancelledUL.backgroundColor = .WhiteColor
    }
    
    @IBAction func didTapCompletedBtn(_ sender: Any) {
        upComminglbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        upcomingUL.backgroundColor = .WhiteColor
        
        completedlbl.textColor = .AppLabelColor
        completedUL.backgroundColor = .AppLabelColor
        
        cancelledlbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        cancelledUL.backgroundColor = .WhiteColor
    }
    
    @IBAction func didTapOnCancelledBtn(_ sender: Any) {
        upComminglbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        upcomingUL.backgroundColor = .WhiteColor
        
        completedlbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        completedUL.backgroundColor = .WhiteColor
        
        cancelledlbl.textColor = .AppLabelColor
        cancelledUL.backgroundColor = .AppLabelColor
    }
    
    
}
