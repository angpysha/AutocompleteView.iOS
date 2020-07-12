//
//  AutoCompleteTextFieldDelegate.swift
//  AutoCompleteView
//
//  Created by Admin on 30.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol AutoCompleteTextFieldDelegate {
    @objc optional func onRowTap(onTableView tableView: UITableView, withIndex index: Int)
}

