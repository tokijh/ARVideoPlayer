//
//  MeshPlane.swift
//  ARVideoPlayer
//
//  Created by 윤중현 on 2018. 10. 17..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import ARKit

@available(iOS 11.3, *)
class MeshPlane: Plane {
    init(planeGeometry: ARSCNPlaneGeometry, planeColor: UIColor?) {
        super.init()
        self.planeColor = planeColor
        self.planeGeometry = planeGeometry
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// MARK Update
    public func update(anchor: ARPlaneAnchor) {
        planeGeometry?.update(from: anchor.geometry)
    }
    
    /// MARK Plane Color
    var planeColor: UIColor? = nil {
        didSet {
            updatePlaneColor()
        }
    }
    
    private func updatePlaneColor() {
        geometry?.firstMaterial?.diffuse.contents = planeColor
    }
    
    /// MARK PlaneGeometry
    var planeGeometry: ARSCNPlaneGeometry? {
        get {
            return geometry as? ARSCNPlaneGeometry
        }
        set {
            updatePlaneGeometry(newValue)
            updatePlaneColor()
        }
    }
    
    private func updatePlaneGeometry(_ geometry: ARSCNPlaneGeometry?) {
        self.geometry = geometry
    }
}
