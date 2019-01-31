//
//  ViewController.swift
//  UnitCircle
//
//  Created by Usman Rashid on 1/28/19.
//  Copyright © 2019 Usman Rashid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var qView: UIQuartzView!
    @IBOutlet weak var fracView: UIFractionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fracView.setFraction(top: "2𝜋", bottom: "3")
    }
}

