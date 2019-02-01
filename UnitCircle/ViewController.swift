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
    @IBOutlet weak var valSin: UIFractionView!
    @IBOutlet weak var valCos: UIFractionView!
    @IBOutlet weak var valTan: UIFractionView!
    @IBOutlet weak var valCosec: UIFractionView!
    @IBOutlet weak var valSec: UIFractionView!
    @IBOutlet weak var valCot: UIFractionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        valSin.setFraction(str: "1/2")
        valCos.setFraction(str: "√3/2")
        valTan.setFraction(str: "1/√3")
        
        valCot.setFraction(str: "√3")
        valCosec.setFraction(str: "2")
        valSec.setFraction(str: "2/√3")
/*
        fracView.setFraction(str: "")
        fracView.setFraction(str: "0.866")
        fracView.setFraction(str: "/")
        fracView.setFraction(str: "3𝜋")
        fracView.setFraction(str: "1/2")
        fracView.setFraction(str: "4/")
        fracView.setFraction(str: "/4")
        fracView.setFraction(str: "5///5")
        fracView.setFraction(str: "///6")
*/
//        fracView.setFraction(top: "2𝜋", bottom: "3")
//        fracView.setFraction(top: "2𝜋", bottom: "")
//        fracView.setFraction(top: "", bottom: "")
    }
}
