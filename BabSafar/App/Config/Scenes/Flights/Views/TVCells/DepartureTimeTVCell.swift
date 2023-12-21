//
//  DepartureTimeTVCell.swift
//  BabSafar
//
//  Created by FCI on 30/11/23.
//

import UIKit

protocol DepartureTimeTVCellDelegate {
    func didSelectDepartureTime(cell:DepartureTimeCVCell)
    func didDeSelectDepartureTime(cell:DepartureTimeCVCell)
}

class DepartureTimeTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var departureTimeCV: UICollectionView!
    
    
    var delegate:DepartureTimeTVCellDelegate?
    var selectedIndices = [IndexPath]()
    var timeImages = ["mor1","mor2","mor3","mor4"]
    var timeArray = ["12AM - 6AM","6AM - 12PM","12PM - 6PM","6PM - 12AM"]
    var selectBool = true
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        departureTimeCV.reloadData()
    }
    
    @IBAction func didTapOnDropDownBtnAction(_ sender: Any) {
        selectBool.toggle()
//        if selectBool {
//            departureTimeCV.isHidden = true
//        }else {
//            departureTimeCV.isHidden = false
//        }
    }
}



extension DepartureTimeTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func setupCV() {
        departureTimeCV.layer.cornerRadius = 4
        departureTimeCV.clipsToBounds = true
        departureTimeCV.layer.borderWidth = 1
        departureTimeCV.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        
        let nib = UINib(nibName: "DepartureTimeCVCell", bundle: nil)
        departureTimeCV.register(nib, forCellWithReuseIdentifier: "cell")
        departureTimeCV.delegate = self
        departureTimeCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 90, height: 80)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        departureTimeCV.collectionViewLayout = layout
        departureTimeCV.allowsMultipleSelection = true
        departureTimeCV.isScrollEnabled = false
        departureTimeCV.bounces = false
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DepartureTimeCVCell {
            
            cell.titlelbl.text = timeArray[indexPath.row]
            cell.img.image = UIImage(named: timeImages[indexPath.row])
            
            
            // Check if this indexPath is in the selectedIndices array
            if selectedIndices.contains(indexPath) {
                cell.titlelbl.textColor = .WhiteColor
                cell.img.image = UIImage(named: timeImages[indexPath.row])?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
                cell.contentView.backgroundColor = .AppCalenderDateSelectColor
            } else {
                cell.titlelbl.textColor = .AppLabelColor
                cell.img.image = UIImage(named: timeImages[indexPath.row])?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
                cell.contentView.backgroundColor = .WhiteColor
            }
            
            
            cell.filterTitle = cellInfo?.title ?? ""
           
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DepartureTimeCVCell {
            
            if !selectedIndices.contains(indexPath) {
                selectedIndices.append(indexPath)
                cell.titlelbl.textColor = .WhiteColor
                cell.img.image = UIImage(named: timeImages[indexPath.row])?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
                cell.contentView.backgroundColor = .AppCalenderDateSelectColor
                
            }
            
            delegate?.didSelectDepartureTime(cell: cell)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DepartureTimeCVCell {
            
            if let index = selectedIndices.firstIndex(of: indexPath) {
                selectedIndices.remove(at: index)
                cell.titlelbl.textColor = .AppLabelColor
                cell.img.image = UIImage(named: timeImages[indexPath.row])?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
                cell.contentView.backgroundColor = .WhiteColor
                
            }
            
            
            delegate?.didDeSelectDepartureTime(cell: cell)
        }
    }
    
    
    
}


extension DepartureTimeTVCell {
    
    func showSelectedFlightsFilterValues(cell:DepartureTimeCVCell,indexPath:IndexPath) {
        
        
        // Check the section title to determine which filter to apply
        switch titlelbl.text {
            
            
        case "Departure Time":
            if !filterModel.departureTime.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if filterModel.departureTime.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.titlelbl.textColor = .WhiteColor
                        cell.img.image = UIImage(named: self.timeImages[indexPath.row])?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
                        cell.contentView.backgroundColor = .AppCalenderDateSelectColor
                        self.selectedIndices.append(indexPath)
                        self.departureTimeCV.selectItem(at: indexPath, animated: true, scrollPosition: .left)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.titlelbl.textColor = .AppLabelColor
                        cell.img.image = UIImage(named: self.timeImages[indexPath.row])?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
                        cell.contentView.backgroundColor = .WhiteColor
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.titlelbl.textColor = .AppLabelColor
                    cell.img.image = UIImage(named: self.timeImages[indexPath.row])?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
                    cell.contentView.backgroundColor = .WhiteColor
                }
            }
            
            
            
        case "Arrival Time":
            if !filterModel.arrivalTime.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if filterModel.arrivalTime.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.titlelbl.textColor = .WhiteColor
                        cell.img.image = UIImage(named: self.timeImages[indexPath.row])?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
                        cell.contentView.backgroundColor = .AppCalenderDateSelectColor
                        self.selectedIndices.append(indexPath)
                        self.departureTimeCV.selectItem(at: indexPath, animated: true, scrollPosition: .left)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.titlelbl.textColor = .AppLabelColor
                        cell.img.image = UIImage(named: self.timeImages[indexPath.row])?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
                        cell.contentView.backgroundColor = .WhiteColor
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.titlelbl.textColor = .AppLabelColor
                    cell.img.image = UIImage(named: self.timeImages[indexPath.row])?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
                    cell.contentView.backgroundColor = .WhiteColor
                }
            }
            
            
            
            
            
        default:
            break
        }
    }
}
