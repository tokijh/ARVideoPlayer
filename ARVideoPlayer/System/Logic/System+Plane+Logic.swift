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
        addBorderPlane(node: node, planeAnchor: planeAnchor)
        if #available(iOS 11.3, *) {
            addMeshPlane(node: node, planeAnchor: planeAnchor)
        }
    }
    
    func didUpdate(node: SCNNode, planeAnchor: ARPlaneAnchor) {
        updateBorderPlane(node: node, planeAnchor: planeAnchor)
        if #available(iOS 11.3, *) {
            updateMeshPlane(node: node, planeAnchor: planeAnchor)
        }
    }
}

extension System {    
    private func addBorderPlane(node: SCNNode, planeAnchor: ARPlaneAnchor) {
        let borderPlane = BorderPlane(borderColor: .blue)
        node.addChildNode(borderPlane)
        borderPlane.update(anchor: planeAnchor)
    }
    
    @available(iOS 11.3, *)
    private func addMeshPlane(node: SCNNode, planeAnchor: ARPlaneAnchor) {
        guard let planeGeometry = ARSCNPlaneGeometry(device: device) else { return }
        let meshPlane = MeshPlane(planeGeometry: planeGeometry, planeColor: UIColor.white.withAlphaComponent(0.3))
        node.addChildNode(meshPlane)
        meshPlane.update(anchor: planeAnchor)
    }
    
    private func updateBorderPlane(node: SCNNode, planeAnchor: ARPlaneAnchor) {
        let borderPlanes = node.childNodes.map({ $0 as? BorderPlane }).compactMap({ $0 })
        borderPlanes.forEach({
            $0.update(anchor: planeAnchor)
        })
    }
    
    @available(iOS 11.3, *)
    private func updateMeshPlane(node: SCNNode, planeAnchor: ARPlaneAnchor) {
        let meshPlanes = node.childNodes.map({ $0 as? MeshPlane }).compactMap({ $0 })
        meshPlanes.forEach({
            $0.update(anchor: planeAnchor)
        })
    }
}
