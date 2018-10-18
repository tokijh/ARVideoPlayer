//
//  System+Action.swift
//  ARVideoPlayer
//
//  Created by 윤중현 on 2018. 10. 17..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import ARKit

extension System {
    enum Action {
        case viewDidAppear
        case viewWillDisappear
        case viewDidDisappear
        case didAdd(node: SCNNode, anchor: ARAnchor)
        case didUpdate(node: SCNNode, anchor: ARAnchor)
        case didRemove(node: SCNNode, anchor: ARAnchor)
        case didTap(plane: Plane)
        case didPinch(scale: CGFloat)
        case didRotate(rotation: CGFloat)
    }
    
    public func set(action: Action) {
        switch action {
        case .viewDidAppear: actionViewDidAppear()
        case .viewWillDisappear: actionViewWillDisappear()
        case .viewDidDisappear: actionViewDidDisappear()
        case let .didAdd(node, anchor): actionDidAdd(node: node, anchor: anchor)
        case let .didUpdate(node, anchor): actionDidUpdate(node: node, anchor: anchor)
        case let .didRemove(node, anchor): actionDidRemove(node: node, anchor: anchor)
        case let .didTap(plane): actionDidTap(plane: plane)
        case let .didPinch(scale): actionDidPinch(scale: scale)
        case let .didRotate(rotation): actionDidRotate(rotation: rotation)
        }
    }
}

extension System {
    private func actionViewDidAppear() {
        if status == .setup {
            startSession()
        } else {
            resumeSession()
        }
    }
    
    private func actionViewWillDisappear() {
        pauseSession()
    }
    
    private func actionViewDidDisappear() {
        stopSession()
    }
    
    private func actionDidTap(plane: Plane) {
        didTap(plane: plane)
    }
    
    private func actionDidPinch(scale: CGFloat) {
        didPinch(scale: scale)
    }
    
    private func actionDidRotate(rotation: CGFloat) {
        didRotate(rotation: rotation)
    }
}

extension System {
    private func actionDidAdd(node: SCNNode, anchor: ARAnchor) {
        if let planeAnchor = anchor as? ARPlaneAnchor {
            didAdd(node: node, planeAnchor: planeAnchor)
        }
    }
    
    private func actionDidUpdate(node: SCNNode, anchor: ARAnchor) {
        if let planeAnchor = anchor as? ARPlaneAnchor {
            didUpdate(node: node, planeAnchor: planeAnchor)
        }
    }
    
    private func actionDidRemove(node: SCNNode, anchor: ARAnchor) {
        if let planeAnchor = anchor as? ARPlaneAnchor {
            didRemove(node: node, planeAnchor: planeAnchor)
        }
    }
}
