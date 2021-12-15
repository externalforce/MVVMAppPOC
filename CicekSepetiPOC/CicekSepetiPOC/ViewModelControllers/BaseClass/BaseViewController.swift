//
//  BaseViewController.swift
//  CicekSepetiPOC
//
//  Created by BEGUMKIRKGOZ on 14.10.2020.
//

import UIKit
import CoreData

class BaseViewController: UIViewController {
    
    var filterButton:       UIButton?
    var applyButton:        UIButton?
    var deleteFilterButton: UIButton?
    var vSpinner:           UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
    }
    
//MARK: NavigationBar Funcs
    func setupNavigationBar() {
        switch self {
        case is ProductListViewController:
            self.setNavigationTitle(title: homePageTitle)
            self.hideLefttBarBack()
            self.setRightFilterTypeButton()
            break
        case is ProductListFilterViewController:
            self.setNavigationTitle(title: filterPageTitle)
            self.setLeftBackButton()
            self.setRightApplyTypeButton()
            break
        default:
            break
        }
    }
    
    func setNavigationTitle(title: String) {
        self.navigationController?.navigationBar.topItem?.title = title
    }
    
    func setLeftBackButton() {
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        backButton.setImage(UIImage(named:"close-icon")!, for: .normal)
        let textAttributes = [NSAttributedString.Key:Any]()
        _ = NSAttributedString(string: "", attributes: textAttributes)
        backButton.contentMode = .left
        backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16.0)
        backButton.addTarget(self, action: #selector(self.dismissPageBack), for: .touchUpInside)
        let backItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftItemsSupplementBackButton = false
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    func setRightFilterTypeButton() {
        filterButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        filterButton!.setImage(UIImage(named:"filter-icon")!, for: .normal)
        filterButton!.contentMode = .right
        filterButton!.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        filterButton!.addTarget(self, action: #selector(processFilterPage), for: .touchUpInside)
        let rightItem = UIBarButtonItem(customView: filterButton!)
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = rightItem
    }
    
    func setRightApplyTypeButton() {
        applyButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        applyButton!.setTitle(apply, for: .normal)
        applyButton!.contentMode = .right
        applyButton!.setTitleColor( .blue, for: .normal)
        applyButton!.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
        let rightItemFilter = UIBarButtonItem(customView: applyButton!)
        
        deleteFilterButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        deleteFilterButton!.setTitle(deleteFilterStr, for: .normal)
        deleteFilterButton!.contentMode = .right
        deleteFilterButton!.setTitleColor( .black, for: .normal)
        deleteFilterButton!.addTarget(self, action: #selector(deleteFilter), for: .touchUpInside)
        let rightItemDelete = UIBarButtonItem(customView: deleteFilterButton!)
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItems = [rightItemFilter, rightItemDelete]
    }
    
    func hideLefttBarBack(){
        self.navigationItem.leftBarButtonItem = nil
    }
    
    func hideRightBarSearch() {
        self.navigationItem.rightBarButtonItems = nil
    }

//MARK: Called from VC to Override
    @objc func processFilterPage() {
    }
    
    @objc func applyFilter() {
        self.dismissPageBack()
    }
    
    @objc func deleteFilter() {
        self.dismissPageBack()
    }
    
    @objc func dismissPageBack(){
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
//MARK: Spinner Funcs
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let indicator = UIActivityIndicatorView.init(style: .whiteLarge)
        indicator.startAnimating()
        indicator.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(indicator)
            onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    
//MARK: Show Error MEthods
    func showErrorVC(message: String) {
        DispatchQueue.main.async {
            let errorAlert = UIAlertController(title: "Hata", message: message, preferredStyle: UIAlertController.Style.alert)
            errorAlert.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: { (action: UIAlertAction!) in
              }))
            self.present(errorAlert, animated: true, completion: nil)
        }
    }
}


