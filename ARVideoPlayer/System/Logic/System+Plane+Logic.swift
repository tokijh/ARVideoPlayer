//
//  System+Plane+Logic.swift
//  ARVideoPlayer
//
//  Created by 윤중현 on 17/10/2018.
//  Copyright © 2018 tokijh. All rights reserved.
//

import ARKit

extension System {
    func didAdd(node: SCNNode, planeAnchor: ARPlaneAnchor) {
        let plane: Plane
        if #available(iOS 11.3, *),
            let device = device,
            let planeGeometry = ARSCNPlaneGeometry(device: device) {
            plane = Plane(planeGeometry: planeGeometry)
        } else {
            plane = Plane()
        }
        node.addChildNode(plane)
        plane.update(anchor: planeAnchor)
    }
    
    func didUpdate(node: SCNNode, planeAnchor: ARPlaneAnchor) {
        guard let plane = node.childNodes.first as? Plane else { return }
        plane.update(anchor: planeAnchor)
    }
}
