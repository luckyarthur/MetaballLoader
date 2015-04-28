//
//  MetaBall.swift
//  MetaSpinExample
//
//  Created by Jin Wang on 21/04/2015.
//  Copyright (c) 2015 uthoft. All rights reserved.
//

import UIKit
import GLKit

let ForceConstant: CGFloat = 6.67384
let DistanceConstant: CGFloat = 2.0
let MaximumForce: CGFloat = 10000

class MetaBall: NSObject {
    dynamic var center: GLKVector2
    var radius: CGFloat {
        didSet {
            self.mess = radius // ForceConstant * CGFloat(M_PI) * radius * radius
        }
    }
    private(set) var mess: CGFloat
    
    var borderPosition = GLKVector2Make(0, 0)
    var trackingPosition = GLKVector2Make(0, 0)
    var tracking = false
    var borderPath: CGMutablePathRef!
    var shapeLayer: CAShapeLayer = CAShapeLayer()
    
    convenience init(center: CGPoint, radius: CGFloat) {
        let centerVector = GLKVector2Make(Float(center.x), Float(center.y))
        self.init(centerVector: centerVector, radius: radius)
    }
    
    init(centerVector: GLKVector2, radius: CGFloat) {
        self.center = centerVector
        self.radius = radius
        self.mess = radius // ForceConstant * CGFloat(M_PI) * radius * radius
    }
    
    func forceAt(position: GLKVector2) -> CGFloat {
        var div = pow(distance(center, position) , DistanceConstant)
        return div == 0 ? MaximumForce : mess / div
    }
}

func distance(fromPoint: GLKVector2, toPoint: GLKVector2) -> CGFloat {
    return CGFloat(GLKVector2Distance(fromPoint, toPoint))
}