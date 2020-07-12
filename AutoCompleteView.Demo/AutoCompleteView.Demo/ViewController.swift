//
//  ViewController.swift
//  AutoCompleteView.Demo
//
//  Created by Admin on 29.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import AutoCompleteView

class ViewController: UIViewController /*, AutoCompleteFieldDataSource*/, UITextFieldDelegate, AutoCompleteTextFieldDelegate {
    @IBOutlet weak var OutletAutompleteTextVIewField: AutoCompleteTextFirld!
    
    let items: [String] = ["test1", "test2", "test3"]
    
    func RowsCount() -> Int {
        return items.count
    }
    
//    func GetCell(textField: AutoCompleteTextFirld, index: Int) -> UITableViewCell {
//
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        OutletAutompleteTextVIewField.items = items
        OutletAutompleteTextVIewField.delegate = self
        OutletAutompleteTextVIewField.tableDelegate = self
        OutletAutompleteTextVIewField.addTarget(self, action: #selector(textFieldChnaged), for: .editingChanged)
        // OutletAutompleteTextVIewField.AddCell(nib: <#T##UINib#>, id: <#T##String#>)
        // Do any additional setup after loading the view.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var ii = 0
    }

    @objc func textFieldChnaged() {
        if (ignoreAutoCompletetableView) {
            ignoreAutoCompletetableView = false
            return
        }
        var length = OutletAutompleteTextVIewField.text?.count ?? 0
        if (length >= 3) {
            OutletAutompleteTextVIewField.tableViewVisible = true
        } else     {
            OutletAutompleteTextVIewField.tableViewVisible = false
        }
    }
    private var ignoreAutoCompletetableView: Bool = false
    func onRowTap(onTableView tableView: UITableView, withIndex index: Int) {
        ignoreAutoCompletetableView=true
        OutletAutompleteTextVIewField.text = items[index]
    }
}

