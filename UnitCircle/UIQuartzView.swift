//
//  UIQuartzView.swift
//  UnitCircle
//
//  Created by Usman Rashid on 1/28/19.
//  Copyright © 2019 Usman Rashid. All rights reserved.
//

import UIKit

class UIQuartzView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {

        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        context.setLineWidth(2.0)
        context.setStrokeColor(red:0.333, green:0.333, blue:0.333, alpha:1.0);
        context.setFillColor(red:0.0, green:0.0, blue:0.0, alpha:1.0);
        
        drawBorder(context)
    }
    
    func drawBorder(_ context:CGContext) {
        // Top-Left corner of the view
        let origin = CGPoint (x:0.0, y:0.0)

        // Bottom-Right corner of the view
        let diagPt =  CGPoint (x:self.frame.size.width, y:self.frame.size.height)
        
        // Draw using the properties set in the context
        context.move(to: origin)
        context.addLine(to: CGPoint(x:diagPt.x, y:origin.y))
        context.addLine(to: diagPt)
        context.addLine(to: CGPoint(x:origin.x, y:diagPt.y))
        context.addLine(to: origin)
        context.strokePath()
    }
}
