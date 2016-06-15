//
//  TableViewAdjustProtocol.swift
//  Hayabusa
//
//  Created by Kyle Kendall on 3/25/16.
//  Copyright © 2016 Domo Inc. All rights reserved.
//

import UIKit

/// Adjusts the tableView's `contentInset` and `scrollIndicatorInsets` properties when the keyboard changes it's height.
protocol TableViewInsetsAdjusting: class {
    /// This tableviews insets will be adjusted
    var tableView: UITableView! { get }
    var view: UIView! { get set }
    var inverted: Bool { get }
}

extension TableViewInsetsAdjusting {
    var inverted: Bool { return false }
}

extension TableViewInsetsAdjusting {
    
    /// Sets up all Notifications used to update `keyboardHeight`.
    func setupInsetAdjust() {
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
            self?.updateTableViewInsets(fromNotification: notification)
        }
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardDidChangeFrameNotification, object: nil, queue: nil) { [weak self] notification in
            self?.updateTableViewInsets(fromNotification: notification)
        }
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: nil) { [weak self] notification in
            self?.updateTableViewInsets(fromNotification: notification)
        }
    }
    
    /// Call this to take down anything from setup.
    func takeDownInsetAdjust() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    /**
     Call this to get the keyboard height from the notification.
     
     - parameter notification: `NSNotification` A keyboard NSNotification.
     
     */
    private func updateTableViewInsets(fromNotification notification: NSNotification) {
        let keyboardHeight = self.view.keyboardHeightFromBottomWithNotification(notification)
        updateTableViewInsets(forKeyboardHeight: keyboardHeight)
    }
    
    /**
     Updates the tableView insets with `keyboardHeight`.
     
     - parameter keyboardHeight: `CGFloat` Keyboard height used to update insets.
     
     */
    private func updateTableViewInsets(forKeyboardHeight keyboardHeight: CGFloat) {
        var tableViewInset = tableView.contentInset
        if inverted {
            tableViewInset.top = keyboardHeight
        } else {
            tableViewInset.bottom = keyboardHeight
        }
        
        tableView.scrollIndicatorInsets = tableViewInset
        tableView.contentInset = tableViewInset
    }
    
}


extension UIView {
    
    /**
     Get the height of the keyboard, including any inputAccessory views.
     
     - parameter notification: `NSNotification` The notification that the keyboard's height was changed.
     
     - returns: `CGFloat` Height of keyboard.
     
     */
    func keyboardHeightFromBottomWithNotification(notification: NSNotification) -> CGFloat {
        guard let userInfo = notification.userInfo as? [String:AnyObject] else { return 0 }
        guard let rectValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return 0 }
        guard let window = self.window else { return 0 }
        
        let keyboardFrame = rectValue.CGRectValue()
        guard keyboardFrame.maxY >= window.bounds.maxY else { return 0 }
        
        let convertedFrame = self.convertRect(keyboardFrame, fromView: window)
        return CGRectIntersection(convertedFrame, self.bounds).height
    }
    
}

