//
//  FilterSectionView.swift
//  CicekSepetiPOC
//
//  Created by BEGUMKIRKGOZ on 17.10.2020.
//

import UIKit

class FilterSectionView: UIView {
    
    @IBOutlet weak var categoryNameLbl: UILabel! {
        didSet {
            self.categoryNameLbl.text = ""
            self.categoryNameLbl.layer.applySketchShadow(color: .black, alpha: 0.1, x: 0, y: 0, blur: 7, spread: 0)
        }
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }

}
