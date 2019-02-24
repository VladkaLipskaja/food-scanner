//
//  ViewController.swift
//  int20h
//
//  Created by Alex Vihlayew on 2/23/19.
//  Copyright © 2019 Alex Vihlayew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        sleep(2)
        
        if Preferences.undesiredProducts.isEmpty {
            print("Products are not configured. Starting setup")
            performSegue(withIdentifier: "Settings", sender: nil)
        } else {
            print("Products are configured. Starting scan for: \(Preferences.undesiredProducts)")
            performSegue(withIdentifier: "Scan", sender: nil)
        }
    }


}

