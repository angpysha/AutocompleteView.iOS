//
//  AutoCompleteViewTableCellTableViewCell.swift
//  AutoCompleteView
//
//  Created by Admin on 29.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

public class AutoCompleteViewTableCellTableViewCell: UITableViewCell {
    @IBOutlet weak var OutletTitle: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
