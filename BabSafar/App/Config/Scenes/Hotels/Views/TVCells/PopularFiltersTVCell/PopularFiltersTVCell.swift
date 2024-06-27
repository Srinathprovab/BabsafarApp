//
//  PopularFiltersTVCell.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit

protocol PopularFiltersTVCellDelegate {
    func didTapOnStarRatingCell(cell:StarRatingCVCell)
}

class PopularFiltersTVCell: TableViewCell {
    
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var starratingCV: UICollectionView!
    
    
    
    var delegate:PopularFiltersTVCellDelegate?
    var starArray = ["1","2","3","4","5"]
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
        
        if startRatingArray.count == 0 {
            hotelfiltermodel.starRatingNew = starRatingInputArray
            startRatingArray = starRatingInputArray
        }else {
            hotelfiltermodel.starRatingNew =  startRatingArray
        }
        
        setupCV()
    }
    
    func setupUI() {
        
    }
    
    
}



extension PopularFiltersTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func setupCV() {
        
        
        let nib = UINib(nibName: "StarRatingCVCell", bundle: nil)
        starratingCV.register(nib, forCellWithReuseIdentifier: "cell")
        starratingCV.delegate = self
        starratingCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 55, height: 35)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        // layout.sectionInset = UIEdgeInsets(top: 16, left: 10, bottom: 16, right: 10)
        starratingCV.collectionViewLayout = layout
        starratingCV.backgroundColor = .clear
        starratingCV.layer.cornerRadius = 4
        starratingCV.clipsToBounds = true
        starratingCV.showsHorizontalScrollIndicator = false
        starratingCV.bounces = false
        starratingCV.allowsMultipleSelection = true
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return starArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? StarRatingCVCell {
            cell.titlelbl.text = starArray[indexPath.row]
            
            
            
            
            if hotelstarratingArray.contains(cell.titlelbl.text ?? "") {
                cell.holderView.alpha = 1
                cell.isUserInteractionEnabled = true
                
                
                if hotelfiltermodel.starRatingNew.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.holderView.backgroundColor = HexColor("34C759")
                        cell.titlelbl.textColor = .WhiteColor
                        cell.starimg.tintColor = .lightGray
                        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
                    }
                    
                } else {
                    
                    DispatchQueue.main.async {
                        cell.holderView.backgroundColor = UIColor.AppBorderColor
                        cell.titlelbl.textColor = .titleLabelColor
                        cell.starimg.tintColor = .black
                    }
                    
                }
                
                
            } else {
                cell.holderView.alpha = 0.3
                cell.isUserInteractionEnabled = false
            }
            
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? StarRatingCVCell {
            
            cell.holderView.backgroundColor = HexColor("34C759")
            cell.titlelbl.textColor = .WhiteColor
            cell.starimg.tintColor = .lightGray
            startRatingArray.append(cell.titlelbl.text ?? "")
            
            delegate?.didTapOnStarRatingCell(cell: cell)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? StarRatingCVCell {
            
            cell.holderView.backgroundColor = UIColor.AppBorderColor
            cell.titlelbl.textColor = .titleLabelColor
            cell.starimg.tintColor = .black
            
            if let index1 = startRatingArray.firstIndex(of: cell.titlelbl.text ?? "") {
                startRatingArray.remove(at: index1)
            }
            
            delegate?.didTapOnStarRatingCell(cell: cell)
            
        }
    }
    
}
