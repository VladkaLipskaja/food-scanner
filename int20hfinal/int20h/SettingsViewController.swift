//
//  SettingsViewController.swift
//  int20h
//
//  Created by Alex Vihlayew on 2/23/19.
//  Copyright © 2019 Alex Vihlayew. All rights reserved.
//

import UIKit
import Magnetic

class SettingsViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var bubblePickerContentView: UIView!
    
    var components = [String]()
    
    var magnetic: Magnetic?
    var selectedComponents = Preferences.undesiredProducts
    
    let colors = [UIColor(red: 255 / 256, green: 199 / 256, blue: 199 / 256, alpha: 1.0),
                  UIColor(red: 248 / 256, green: 154 / 256, blue: 154 / 256, alpha: 1.0),
                  UIColor(red: 255 / 256, green: 135 / 256, blue: 135 / 256, alpha: 1.0),
                  UIColor(red: 245 / 256, green: 108 / 256, blue: 108 / 256, alpha: 1.0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        API.getAllComponents { (error, comp) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.components = comp
                self.createMagnetic(with: nil)
            }
        }
    }
    
    func createMagnetic(with searchText: String?) {
        let magneticView = MagneticView(frame: bubblePickerContentView.bounds)
        magnetic = magneticView.magnetic
        magnetic?.magneticDelegate = self
        bubblePickerContentView.addSubview(magneticView)
        
        for component in components {
            let nodeText = component
            let addNode = {
                let node = Node(text: nodeText, image: UIImage(named: "food"), color: self.colors[Int(arc4random_uniform(4))], radius: 40.0 + (20 * (CGFloat(arc4random()) / CGFloat(UINT32_MAX))))
                node.isSelected = self.selectedComponents.contains(nodeText)
                self.magnetic?.addChild(node)
            }
            if let searchText = searchText, searchText != "" {
                if nodeText.contains(searchText) {
                    addNode()
                }
            } else {
                addNode()
            }
        }
    }
    
    @IBAction func done(_ sender: Any) {
        Preferences.save(undesired: selectedComponents)
        performSegue(withIdentifier: "Scan", sender: nil)
    }
    
}

extension SettingsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else {
            return
        }
        bubblePickerContentView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        createMagnetic(with: searchText)
    }
    
}

extension SettingsViewController: MagneticDelegate {
    
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        selectedComponents.append(node.text!)
    }
    
    func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
        selectedComponents = selectedComponents.filter({ $0 != node.text })
    }
    
}
