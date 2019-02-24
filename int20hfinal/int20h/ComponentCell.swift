//
//  ComponentCell.swift
//  int20h
//
//  Created by Alex Vihlayew on 2/24/19.
//  Copyright © 2019 Alex Vihlayew. All rights reserved.
//

import UIKit

class ComponentCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var background: UIView!
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        background.layer.cornerRadius = 16.0
    }
    
}
