//
//  ProductListViewController.swift
//  CicekSepetiPOC
//
//  Created by BEGUMKIRKGOZ on 14.10.2020.
//

import UIKit

class ProductListViewController: BaseViewController {

    private var productList: [ProductModel]?
    private var productListData: ProductListDataModel?
    private var requestModel: RequestModel?
    
    private var isFilterApplied: Bool = false
    
    lazy var productListViewModel: ProductListViewModel = {
        ProductListViewModel()
    }()
    
    @IBOutlet weak var productsTableView: UITableView!

    //MARK: Override VC Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initVM()
    }
    
    override func processFilterPage() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "ProductListFilterViewController") as! ProductListFilterViewController
        let nav = UINavigationController(rootViewController: controller)
        controller.delegate = self
        controller.filters = productListData?.mainFilter?.dynamicFilter
        if isFilterApplied {
            controller.productListFilterViewModel.requestModel = self.requestModel!
        }
        self.present(nav, animated: true, completion: nil)
    }
    
//MARK: UI Funcs
    private func initView() {
        self.callProductService()
        self.productsTableView.register(UINib(nibName: "ProductListTableViewCell", bundle: .main), forCellReuseIdentifier: "ProductListTableViewCell")
    }
    
//MARK:ViewModel Funcs
    private func initVM() {
        productListViewModel.processProductList = { [weak self] data in 
            self?.removeSpinner()
            self?.productList = data?.products
            self?.productListData = data
            DispatchQueue.main.async {
                self?.productsTableView.reloadData()
            }
        }
        
        productListViewModel.showError = { [weak self] in
            self?.removeSpinner()
            self?.showErrorVC(message: serviceError)
        }
        
        productListViewModel.showErrorWithServiceMessage = { message in
            self.removeSpinner()
            self.showErrorVC(message: message ?? "")
        }
    }
    
    func callProductService() {
        self.showSpinner(onView: self.view)
        productListViewModel.getProducts()
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell") as? ProductListTableViewCell{
            cell.productModel = productList?[indexPath.row]
            return cell
        }
        return UITableViewCell()

    }
}
extension ProductListViewController: ProductListFilterViewControllerDelegate {

    func deleteFilteredData() {
        isFilterApplied = false
        self.filterButton?.setImage(UIImage(named:"filter-icon")!, for: .normal)
        self.callProductService()
    }
    
    func filteredData(productListData: ProductListDataModel, requestModel: RequestModel) {
        isFilterApplied = true
        self.requestModel = requestModel
        self.filterButton?.setImage(UIImage(named:"filtered-icon")!, for: .normal)
        self.productListData = productListData
        self.productList = productListData.products
        self.productsTableView.scrollToRow(at: IndexPath(row: 0,
                                                         section: 0),
                                   at: .top,
                                   animated: true)
        DispatchQueue.main.async {
            self.productsTableView.reloadData()
        }
    }
}
