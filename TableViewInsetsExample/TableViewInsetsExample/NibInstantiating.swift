//
//  NibInstantiating.swift
//  TableViewInsetsExample
//
//  Created by Kyle Kendall on 6/14/16.
//  Copyright © 2016 Kyle Kendall. All rights reserved.
//

import UIKit


/**
 Your UIView subclass should conform to this when you want to instantiate a view from a nib.
 By default it will use the name of the class to find the nib. You can implement this yourself
 if the class name is different than the .xib name.
 */
protocol NibInstantiating {
    /**
     The default implementation returns (`Self.self`). The class in string format. Which assumes the class name is the
     same as the '.xib' name. If they are different you can override it to provide the correct '.xib' name.
     */
    static var nibName: String { get }
}

extension NibInstantiating {
    
    /**
     Creates a UIView (or subclass) using `nibName` to generate it.
     
     - returns: `Self` This should be a subclass of `UIView`.
     
     - seealso: `nibName` This is used to determine which '.xib' file to use
     
     */
    static func viewFromNib() -> Self {
        var view: Self!
        let objects = NSBundle.mainBundle().loadNibNamed(nibName, owner: nil, options: nil)
        for object in objects {
            guard let foundView = object as? Self else { break }
            view = foundView
        }
        assert(view != nil, "Could not find object of type: \(Self.self) \(#function)")
        return view
    }
    
    static var nibName: String { return String(Self.self) }
    
}
