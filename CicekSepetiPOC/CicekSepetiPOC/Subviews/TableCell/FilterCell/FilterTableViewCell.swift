//
//  FilterTableViewCell.swift
//  CicekSepetiPOC
//
//  Created by BEGUMKIRKGOZ on 16.10.2020.
//

import UIKit

protocol FilterTableViewCellDelegate: AnyObject {
    func selectFilterProcess(valueModel: ValuesModel)
}

class FilterTableViewCell: UITableViewCell {
    
    weak var delegate: FilterTableViewCellDelegate?
    
    var valueModel: ValuesModel! {
        didSet {
            filterNameLbl.text = valueModel.name
        }
    }
    
    @IBOutlet weak var radioImageView: UIImageView! {
        didSet {
        }
    }
    
    @IBOutlet weak var filterNameLbl: UILabel! {
        didSet {
            self.filterNameLbl.text = ""
        }
    }
    
    func selectFilter(){
        self.radioImageView.image = UIImage (named: "on-button")
        delegate?.selectFilterProcess(valueModel: valueModel)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
