//
//  ViewController.swift
//  ReachabilityManager
//
//  Created by dcortes22 on 04/21/2020.
//  Copyright (c) 2020 dcortes22. All rights reserved.
//

import UIKit
import ReachabilityManager

class ViewController: UIViewController {
    
    var manager:ReachabilityManager!
    @IBOutlet weak var connectionImage: UIImageView!
    @IBOutlet weak var connectionLabel: UILabel!
    let connectionSuccessImage = UIImage(named: "Success")!.withRenderingMode(.alwaysTemplate)
    let connectionErrorImage = UIImage(named: "Error")!.withRenderingMode(.alwaysTemplate)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = SemanticColor.backgroundTintColor
        self.connectionLabel.textColor = SemanticColor.labelTintColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager = ReachabilityManager()
        manager.onConnectionReachable = { (manager) in
            self.connectionImage.image = self.connectionSuccessImage
            self.connectionImage.tintColor = UIColor.green
            self.connectionLabel.text = "We are online everything looks good, using the current \(manager.currentAdapterMode) adapter"
        }
        
        manager.onConnectionUnReachable = { (manager) in
            self.connectionImage.image = self.connectionErrorImage
            self.connectionImage.tintColor = UIColor.red
            self.connectionLabel.text = "We are offline on the \(manager.currentAdapterMode) adapter"
        }
        
        manager.startManager()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

