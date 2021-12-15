//
//  ProductListFilterViewController.swift
//  CicekSepetiPOC
//
//  Created by BEGUMKIRKGOZ on 15.10.2020.
//

import UIKit

protocol ProductListFilterViewControllerDelegate: AnyObject {
    func filteredData(productListData: ProductListDataModel, requestModel: RequestModel)
    func deleteFilteredData()
}

class ProductListFilterViewController: BaseViewController {
    
    @IBOutlet weak var filtersTableView: UITableView!
    
    weak var delegate:      ProductListFilterViewControllerDelegate?
    var productListData:    ProductListDataModel?
    var filters:            [DynamicFilterModel]? = nil
    
    let filterTableSectionHeight = 50
    
    lazy var productListFilterViewModel: ProductListFilterViewModel = {
        ProductListFilterViewModel()
    }()
    
//MARK: Override VC Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initVM()
    }
    
    override func applyFilter() { //NAvigationBar ApplyButton Func
        if productListData != nil {
            delegate?.filteredData(productListData: self.productListData!, requestModel: productListFilterViewModel.requestModel)
            self.dismissPageBack()
        }else {
            self.showErrorVC(message: selectFilterError)
        }
    }
    
    override func deleteFilter() { //NAvigationBar DeleteButton Func
        self.dismissPageBack()
        delegate?.deleteFilteredData()
    }
    
//MARK: UI Funcs
    private func initView() {
        self.view.backgroundColor = .white
        self.filtersTableView.register(UINib(nibName: "FilterTableViewCell", bundle: .main), forCellReuseIdentifier: "FilterTableViewCell")
        self.filtersTableView.tableFooterView = UIView()
        self.filtersTableView.allowsMultipleSelection = true
        self.filtersTableView.allowsMultipleSelectionDuringEditing = true
        
        DispatchQueue.main.async {
            self.filtersTableView.reloadData()
        }
    }

//MARK:ViewModel Funcs
    private func initVM() {
        
        productListFilterViewModel.processFilteredProductList = { [weak self] data in
            self?.productListData = data
            self?.filters = data?.mainFilter?.dynamicFilter
            DispatchQueue.main.async {
                self?.filtersTableView.reloadData()
            }
            self?.removeSpinner()
        }
        
        productListFilterViewModel.processFilterWithRequestModel = { [weak self] in
            self?.showSpinner(onView: (self?.view)!)
            self?.productListFilterViewModel.getProductsByFilter(requestModel: (self?.productListFilterViewModel.requestModel)!)
        }
        
        productListFilterViewModel.showError = { [weak self] in
            self?.removeSpinner()
            self?.showErrorVC(message: serviceError)
        }
        
        productListFilterViewModel.showErrorWithServiceMessage = { message in
            self.removeSpinner()
            self.showErrorVC(message: message ?? "")
        }
    }
}

extension ProductListFilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(self.filterTableSectionHeight)
    }
//Tableview have Custom HeaderView
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: FilterSectionView = FilterSectionView.fromNib()
        headerView.categoryNameLbl.text = filters?[section].name
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters?[section].values?.count ?? 0
    }

//Tableview have Custom Cell and its Delegates
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell") as? FilterTableViewCell {
            cell.delegate = self
            cell.valueModel = filters?[indexPath.section].values?[indexPath.row]
            if cell.valueModel.group == 1 && productListFilterViewModel.requestModel.detailList.contains(String(cell.valueModel.id!)) {
                cell.radioImageView.image = UIImage (named: "on-button")
            }
            else if cell.valueModel.group == 2 && productListFilterViewModel.requestModel.checkList.contains(String(cell.valueModel.id!)) {
                cell.radioImageView.image = UIImage (named: "on-button")
            }
            else if cell.valueModel.group == 3 && productListFilterViewModel.requestModel.priceList.contains(String(cell.valueModel.id!)) {
                cell.radioImageView.image = UIImage (named: "on-button")
            }else {
                cell.radioImageView.image = UIImage (named: "off-button")
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.filtersTableView.cellForRow(at: indexPath) as! FilterTableViewCell
        cell.selectFilter()
    }
}

extension ProductListFilterViewController: FilterTableViewCellDelegate {
// it is used to call service by selected filter each time customer selects.
    func selectFilterProcess(valueModel: ValuesModel) {
        productListFilterViewModel.processRequestModelWithFilter(valueModel: valueModel)
    }
}

