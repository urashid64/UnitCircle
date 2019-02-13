//
//  UIFractionView.swift
//  UnitCircle
//
//  Created by Usman Rashid on 1/30/19.
//  Copyright © 2019 Usman Rashid. All rights reserved.
//

import UIKit

class UIFractionView: UIView {
    private var numerator: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    
    private var embar: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        label.textAlignment = .center
        label.numberOfLines = 1
        label.backgroundColor = .clear
        return label
    }()

    private var denominator: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()

    private var font: UIFont = {
        let font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return font
    }()
    
    // Init from Code
    override init (frame : CGRect) {
        super.init(frame : frame)
        setupView()
    }
    
    // Init from Storyboard or Xib
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // Place UILabels for numerator, denominator and middle bar
    private func setupView() {
        // Top half for numerator
        numerator.frame = CGRect(x:0, y:0, width:frame.width, height:frame.height/2)
        addSubview(numerator)
        
        // Bottom half for denominator
        denominator.frame = CGRect(x:0, y:frame.height/2, width:frame.width, height:frame.height/2)
        addSubview(denominator)

        // Embar covers the whole frame, can be used for non-fractional text or middle bar
        embar.frame = CGRect(x:0, y:0, width:frame.width, height:frame.height)
        addSubview(embar)
    }
    
    // Function to parse a string formatted as fraction
    // Valid formats are:
    // ""       For empty string
    // "nn"     For number
    // "nn/nn"  For fraction
    // Everything else is disregarded
    func setFraction (_ str: String)
    {
        let components = str.components(separatedBy: "/")
//        print ("String: \(str), Components: \(components)")
        
        switch components.count {
        case 1:
            setLabels(top: components[0], bottom: "")
//            print ("Number or Empty String")

        case 2:
            if !components[0].isEmpty && !components[1].isEmpty {
                setLabels(top: components[0], bottom: components[1])
//                print ("Valid Fraction")
            }
//            else {
//                print ("Invalid Format")
//            }
 
        default:
//            print ("Invalid Format")
            break
        }
    }

    // Text color for component UILabels
    func setTextColor (color: UIColor)
    {
        numerator.textColor = color
        embar.textColor = color
        denominator.textColor = color
    }

    // Font for component UILabels
    func setFont (font: UIFont)
    {
        self.font = font
        numerator.font = font
        embar.font = font
        denominator.font = font
    }
    
    // Show values in labels
    private func setLabels (top: String, bottom: String)
    {
        // Format: "nn/nn" - Show fraction
        // Use symbol font for the middle bar
        if (top.count > 0 && bottom.count > 0) {
            numerator.text = top
            embar.font = UIFont.init(name:"Symbol", size:16)
            embar.text = "\u{23AF}\u{23AF}"
            denominator.text = bottom
        }
        // Format: "nn" - Show number (or empty)
        else {
            numerator.text = ""
            denominator.text = ""
            embar.font = self.font
            embar.text = top
        }
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    /*
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

