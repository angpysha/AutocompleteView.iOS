//
//  AutoCompleteViewDataSource.swift
//  AutoCompleteView
//
//  Created by Admin on 28.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol AutoCompleteFieldDataSource {
    @objc func RowsCount() -> Int
    @objc func GetCell(textField: AutoCompleteTextFirld, index: Int, withTableView tableView: UITableView) -> UITableViewCell
}
