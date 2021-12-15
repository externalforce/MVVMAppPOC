//
//  ProductListTableViewCell.swift
//  CicekSepetiPOC
//
//  Created by BEGUMKIRKGOZ on 15.10.2020.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {
    
    var productModel: ProductModel! {  
        didSet {
            self.productNameLbl.text = productModel.name
            productNameLblHeight.constant = 20
            productNameLbl.numberOfLines = 1
            if let lineNumber = productNameLbl?.calculateMaxLines(), lineNumber > 1 {
                productNameLblHeight.constant = CGFloat(20 * lineNumber)
                productNameLbl.numberOfLines = lineNumber
            }
            self.productPriceLbl.text = "\(productModel.price?.current ?? 0) \(productModel.price?.currency ?? "")"
            self.productImageView.imageFromServerURL(productModel.mediumImage ?? "", placeHolder: UIImage (named: "product-placeholder"))
        }
    }
    
    @IBOutlet weak var productImageView: UIImageView! {
        didSet {
        }
    }
    
    @IBOutlet weak var productNameLbl: UILabel! {
        didSet {
            self.productNameLbl.text = ""
        }
    }
    
    @IBOutlet weak var productPriceLbl: UILabel! {
        didSet {
            self.productPriceLbl.text = ""
        }
    }
    
    @IBOutlet weak var productNameLblHeight: NSLayoutConstraint!
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.containerView.layer.cornerRadius = 5.0
            self.containerView.layer.masksToBounds = false
            self.containerView.layer.applySketchShadow(color: .black, alpha: 0.1, x: 0, y: 0, blur: 7, spread: 0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.containerView.layer.cornerRadius = 5.0
        self.containerView.layer.masksToBounds = false
        self.containerView.layer.applySketchShadow(color: .black, alpha: 0.1, x: 0, y: 0, blur: 7, spread: 0)
        
        self.productImageView.layer.cornerRadius = 5.0
        self.productImageView.layer.masksToBounds = false
        self.productImageView.layer.applySketchShadow(color: .black, alpha: 0.1, x: 0, y: 0, blur: 7, spread: 0)
    }

}


