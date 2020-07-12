//
//  CelIdentity.swift
//  AutoCompleteView
//
//  Created by Admin on 29.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

@objc public class CellIdentity : NSObject {
    public init(fromNib nib: UINib, andId id: String) {
        self.nib = nib
        self.id = id
    }
    @objc public var nib: UINib? = nil
    @objc public var id: String? = nil
    
}
