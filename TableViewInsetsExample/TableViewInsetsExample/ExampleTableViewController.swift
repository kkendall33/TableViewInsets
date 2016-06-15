//
//  ExampleTableViewController.swift
//  TableViewInsetsExample
//
//  Created by Kyle Kendall on 6/14/16.
//  Copyright © 2016 Kyle Kendall. All rights reserved.
//

import UIKit

final class ExampleTableViewController: UITableViewController, TableViewInsetsAdjusting {
    
    private var inputBar: TextInputBar = TextInputBar.viewFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInsetAdjust()
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override var inputAccessoryView: UIView? {
        return inputBar
    }
    
    deinit {
        takeDownInsetAdjust()
    }
    
}
