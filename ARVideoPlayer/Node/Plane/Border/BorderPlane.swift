//
//  BorderPlaneNode.swift
//  ARVideoPlayer
//
//  Created by 윤중현 on 2018. 10. 17..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import ARKit

class BorderPlane: SCNNode {
    
    init(borderColor: UIColor?) {
        super.init()
        self.borderColor = borderColor
        self.borderPlaneGeometry = BorderPlaneGeometry(borderColor: borderColor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// MARK Update
    public func update(anchor: ARPlaneAnchor) {
        borderPlaneGeometry?.update(anchor: anchor)
        simdPosition = anchor.center
        eulerAngles.x = -.pi / 2
    }
    
    /// MARK Plane Color
    var borderColor: UIColor? = nil {
        didSet {
            updatePlaneColor()
        }
    }
    
    private func updatePlaneColor() {
        borderPlaneGeometry?.borderColor = borderColor
    }
    
    /// MARK Geometry
    var borderPlaneGeometry: BorderPlaneGeometry? {
        get {
            return geometry as? BorderPlaneGeometry
        }
        set {
            updateBorderPlaneGeometry(newValue)
            updatePlaneColor()
        }
    }
    
    private func updateBorderPlaneGeometry(_ geometry: BorderPlaneGeometry?) {
        self.geometry = geometry
    }
}
