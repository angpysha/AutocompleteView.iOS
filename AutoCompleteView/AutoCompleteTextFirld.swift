//
//  AutoCompleteTextFirld.swift
//  AutoCompleteView
//
//  Created by Admin on 28.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

@objc @IBDesignable public class AutoCompleteTextFirld: UITextField, UITableViewDelegate, UITableViewDataSource {
    private var cells: [CellIdentity]? = nil
    private var tableView:UITableView? = nil
    private var tableViewFrame:CGRect? = nil
    private var rootView:UIView? = nil
    private var container:UIView? = nil
    public var items: [String]? = nil
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (DataSource != nil) {
            return DataSource!.RowsCount()
        }
        
        return items?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (DataSource != nil) {
            return DataSource?.GetCell(textField: self, index: indexPath.row, withTableView: tableView) ?? UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "AutoCompleteViewTableCellTableViewCell") as! AutoCompleteViewTableCellTableViewCell
        if (items != nil) {
            cell.OutletTitle.text = items![indexPath.row]
            
        }
        return cell
    }
    
    @objc @IBInspectable public var tableBackgroundColor: UIColor? = nil {
        didSet {
            if (tableView != nil) {
                tableView?.backgroundColor = tableBackgroundColor
            }
        }
    }
    
    @objc @IBInspectable public var tableBorderWidth: CGFloat = 0 {
        didSet {
            if (tableView != nil) {
                tableView?.layer.borderWidth = tableBorderWidth
            }
        }
    }
    
    @objc @IBInspectable public var tableHasSeparator: Bool = false {
        didSet {
            if (tableView != nil) {
                if (tableHasSeparator == false)
                {
                    tableView?.separatorStyle = .none
                } else {
                    tableView?.separatorStyle = .singleLine
                }
            }
        }
    }
    
    @objc @IBInspectable public var tableHeight: CGFloat = 250
    
    @objc @IBInspectable public var tableViewDefaultCellFont: UIFont? = nil
    
    @objc @IBInspectable public var tableViewVisible: Bool = false {
        didSet {
           // tableView?.isHidden = !tableViewVisible
            container?.isHidden = !tableViewVisible
        }
    }
    
    @objc @IBInspectable public var tableCornerRadius: CGFloat  = 0
    
    @objc @IBInspectable public var showTextOnSelect: Bool = true
    
    private var shouldShowAutomplete: Bool = true
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        container?.isHidden = true
        tableDelegate?.onRowTap?(onTableView: tableView, withIndex: indexPath.row)
//        (tableDelegate?.onRowTap ?? <#default value#>)(onTableView: tableView, withIndex: indexPath.row)
//        weakTableDelegate?.onRowTap(onTableView: tableView, withIndex: indexPath.row)
    }
    
    @objc public var DataSource: AutoCompleteFieldDataSource? = nil
    @objc public var tableDelegate: AutoCompleteTextFieldDelegate? = nil
    @objc public weak var weakTableDelegate: AutoCompleteTextFieldDelegate? = nil
    
    
    @objc public override func draw(_ rect: CGRect) {
        super.draw(rect)
//        let keyWindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive})
//            .map({$0 as? UIWindowScene})
//            .compactMap({$0})
//            .first?.windows
//            .filter({$0.isKeyWindow}).first
        let keyWindow = UIApplication.shared.windows.first
        var vc = keyWindow?.rootViewController
        if (vc != nil) {
            while (vc?.presentedViewController != nil) {
                vc = vc?.presentedViewController
                
            }
            rootView = vc?.view
        }
        
        let scrollView = GetParentScrollView(view: self)
        if (scrollView != nil) {
            rootView = scrollView
        }
        let relativeFrame = self.convert(superview!.frame, to: keyWindow)
        let rect = self.frame
        tableViewFrame = CGRect(x: relativeFrame.origin.x, y: relativeFrame.origin.y+rect.height, width: rect.width, height: tableHeight)
        let tableFrameIntenal = CGRect(x:0,y:0,width: rect.width, height: tableHeight)
        tableView = UITableView(frame: tableFrameIntenal)
             tableView?.dataSource = self
        tableView?.register(UINib(nibName: "AutoCompleteViewTableCellTableViewCell", bundle: Bundle(for: AutoCompleteViewTableCellTableViewCell.self)), forCellReuseIdentifier: "AutoCompleteViewTableCellTableViewCell")
   
        tableView?.separatorStyle = tableHasSeparator ? .singleLine : .none
        tableView?.layer.borderWidth = tableBorderWidth
        tableView?.backgroundColor = tableBackgroundColor
        tableView?.delegate = self
       // tableView?.isHidden = true
        if (cells != nil) {
            for cell in cells! {
                tableView?.register(cell.nib, forCellReuseIdentifier: cell.id!)
            }
        }
       // tableView?.backgroundColor = UIColor.red
        container = UIView()
        container!.backgroundColor = UIColor.white
        container!.frame = tableViewFrame!
        
        container!.layer.borderColor = UIColor.lightGray.cgColor
        container!.layer.borderWidth = tableBorderWidth
        container!.layer.cornerRadius = tableCornerRadius
        container!.clipsToBounds = true
        
        container!.addSubview(tableView!)
        container!.isHidden = true
        rootView?.addSubview(container!)
    }
    
    @objc private func GetParentScrollView(view: UIView?) -> UIScrollView? {
        if (view?.superview == nil)
        {
            return nil
        }
        var scroll = superview as? UIScrollView
        return scroll ?? GetParentScrollView(view: view?.superview)
    }
    
    @objc public func AddCell(nib: UINib, id: String) {
        if (cells == nil) {
            cells = [CellIdentity]()
        }
        cells?.append(CellIdentity(fromNib: nib, andId: id))
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
