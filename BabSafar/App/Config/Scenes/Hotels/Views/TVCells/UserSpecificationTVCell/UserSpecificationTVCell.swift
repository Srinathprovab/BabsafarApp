//
//  UserSpecificationTVCell.swift
//  BabSafar
//
//  Created by FCI on 01/09/23.
//

import UIKit

class UserSpecificationTVCell: TableViewCell, UITextViewDelegate {
    
    
    @IBOutlet weak var specificationTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var yourTextView: UITextView!
    
    
    let placeholderText = "Enter your remarks..."
    let placeholderColor = UIColor.lightGray
    var specificationArray = userspecification
    var SelectedSpecificationArray = [String]()
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
        
        tvHeight.constant = CGFloat(specificationArray.count * 44)
        specificationTV.reloadData()
        
    }
    
    
    func setupUI(){
        
        yourTextView.delegate = self
        yourTextView.text = placeholderText
        yourTextView.textColor = UIColor.lightGray
        
        yourTextView.layer.cornerRadius = 4
        yourTextView.layer.borderWidth = 1
        yourTextView.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        setupTV()
    }
    
    
    func textViewDidChange(descriptionField: UITextView) {
        if yourTextView.text.isEmpty == false {
            yourTextView.text = ""
        } else {
            yourTextView.text = placeholderText
        }
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        if yourTextView.textColor == UIColor.lightGray {
            yourTextView.text = ""
            yourTextView.textColor = UIColor.black
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {

        if yourTextView.text == "" {

            yourTextView.text = placeholderText
            yourTextView.textColor = UIColor.lightGray
        }
    }
    
}


extension UserSpecificationTVCell:UITableViewDelegate, UITableViewDataSource {
    
    func setupTV() {
        specificationTV.delegate = self
        specificationTV.dataSource = self
        specificationTV.register(UINib(nibName: "UserSpecificationOptionsTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        specificationTV.isScrollEnabled = false
        specificationTV.separatorStyle = .none
        specificationTV.allowsMultipleSelection = true
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specificationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? UserSpecificationOptionsTVCell {
            cell.selectionStyle = .none
            cell.titlelbl.text = specificationArray[indexPath.row]
            ccell = cell
        }
        
        return ccell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? UserSpecificationOptionsTVCell {
            cell.chkImg.image = UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal)
            
            if !SelectedSpecificationArray.contains(cell.titlelbl.text ?? "") {
                SelectedSpecificationArray.append(cell.titlelbl.text ?? "")
            }
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? UserSpecificationOptionsTVCell {
            cell.chkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
            
            if let deselectedItemIndex = SelectedSpecificationArray.firstIndex(of: cell.titlelbl.text ?? "") {
                SelectedSpecificationArray.remove(at: deselectedItemIndex)
            }
        }
        
        
    }
    
    
    
}
