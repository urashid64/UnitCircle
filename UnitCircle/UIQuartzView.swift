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
        
//        context.setLineWidth(2.0)
//        context.setStrokeColor(red:0.333, green:0.333, blue:0.333, alpha:1.0);
//        context.setFillColor(red:0.0, green:0.0, blue:0.0, alpha:1.0);
        
        drawBorder(context)
        drawGrid(context)
    }
    
    func drawBorder(_ context:CGContext) {
        // Top-Left corner of the view in view coordinates
        let origin = CGPoint (x:0.0, y:0.0)

        // Bottom-Right corner of the view in view coordinates
        let diagPt =  CGPoint (x:self.frame.width, y:self.frame.height)
        
        // Draw using the properties set in the context
        context.move(to: origin)
        context.addLine(to: CGPoint(x:diagPt.x, y:origin.y))
        context.addLine(to: diagPt)
        context.addLine(to: CGPoint(x:origin.x, y:diagPt.y))
        context.addLine(to: origin)

        context.strokePath()
    }
    
    func drawGrid (_ context:CGContext) {
        // Drawing Area Size
        let width = self.frame.width
        let height = self.frame.height
        
        // Origin of the drawing area
        let origin = CGPoint(x:0.0, y:0.0)

        // Center point of the drawing area
        let center = CGPoint (x:self.frame.width/2.0, y:self.frame.height/2.0)
        
        // Vertical Axis
        context.move(to: CGPoint(x:center.x, y:origin.y))
        context.addLine(to: CGPoint(x:center.x, y:height))

        // Horizontal Axis
        context.move(to: CGPoint(x:origin.x, y:center.y))
        context.addLine(to: CGPoint(x:width, y:center.y))
        
        let gridSpacing = width / 12.0
        context.addArc(center: center, radius: gridSpacing*5, startAngle: 0.0, endAngle: 2*CGFloat.pi, clockwise: false)

        context.strokePath()
    }
}
