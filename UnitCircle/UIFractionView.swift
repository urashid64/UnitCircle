//
//  UIFractionView.swift
//  UnitCircle
//
//  Created by Usman Rashid on 1/30/19.
//  Copyright © 2019 Usman Rashid. All rights reserved.
//

import UIKit

class UIFractionView: UIView {
    var numerator: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
//        label.backgroundColor = .red
        return label
    }()
    
    var embar: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        label.textAlignment = .center
        label.numberOfLines = 1
        label.backgroundColor = .clear
        return label
    }()

    var denominator: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    override init (frame : CGRect) {
        super.init(frame : frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        backgroundColor = .white
        
        // Embar in the middle
        embar.frame = CGRect(x:0, y:0, width:self.frame.width, height:self.frame.height)
        //        embar.frame = CGRect(x:0, y:self.frame.height/2 - 0.1 * self.frame.height, width:self.frame.width, height:self.frame.height * 0.2)
        addSubview(embar)
        
        // Top half for numerator
        numerator.frame = CGRect(x:0, y:0, width:self.frame.width, height:self.frame.height/2)
        addSubview(numerator)
        
        // Bottom half for denominator
        denominator.frame = CGRect(x:0, y:self.frame.height/2, width:self.frame.width, height:self.frame.height/2)
        addSubview(denominator)
    }
    
    func setFraction (top: String, bottom: String)
    {
        numerator.text = top
        embar.font = UIFont.init(name:"Symbol", size:16)
        embar.text = "\u{23AF}\u{23AF}"
        denominator.text = bottom
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    /*
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

