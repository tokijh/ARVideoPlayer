//
//  Plane.swift
//  ARVideoPlayer
//
//  Created by 윤중현 on 2018. 10. 17..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import ARKit

class Plane: SCNNode {
    
    @available(iOS 11.3, *)
    convenience init(planeGeometry: ARSCNPlaneGeometry) {
        self.init()
        setupMeshPlane(planeGeometry: planeGeometry)
    }
    
    override init() {
        self.borderPlane = BorderPlane(borderColor: .blue)
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupBorderPlane()
    }
    
    /// MARK Status Value
    public private(set) var isShowingVideoPlayer: Bool = false {
        didSet {
            if isShowingVideoPlayer {
                setupPlayer()
            }
        }
    }
    public private(set) var isSelected: Bool = false {
        didSet {
            if isShowingVideoPlayer {
                borderPlane.isHidden = !isSelected
            }
        }
    }
    
    /// MARK Selection
    public func select() {
        guard isShowingVideoPlayer else { return }
        setupPlayer()
        isSelected = true
    }
    
    public func deselect() {
        guard isShowingVideoPlayer else { return }
        isSelected = false
    }
    
    /// MARK Pich
    public func pinch(_ scale: CGFloat) {
        guard isShowingVideoPlayer, isSelected else { return }
        let action = SCNAction.scale(by: scale, duration: 0.1)
        runAction(action)
    }
    
    /// MARK Rotation
    public func rotate(_ rotation: CGFloat) {
        guard isShowingVideoPlayer, isSelected else { return }
        let action = SCNAction.rotate(by: rotation, around: SCNVector3(0, -1, 0), duration: 0.1)
        runAction(action)
    }
    
    /// MARK Update
    public func update(anchor: ARPlaneAnchor) {
        if isShowingVideoPlayer {
            updateBorderPlane(anchor: anchor)
            borderPlane.isHidden = !isSelected
        } else {
            updateBorderPlane(anchor: anchor)
            if #available(iOS 11.3, *) {
                updateMeshPlane(anchor: anchor)
            }
        }
    }
    
    /// MARK BorderPlane
    public let borderPlane: BorderPlane
    
    private func setupBorderPlane() {
        addChildNode(borderPlane)
    }
    
    private func updateBorderPlane(anchor: ARPlaneAnchor) {
        borderPlane.update(anchor: anchor)
    }
    
    /// MARK MeshPlane
    public private(set) var meshPlane: Any? = nil
    
    @available(iOS 11.3, *)
    private func setupMeshPlane(planeGeometry: ARSCNPlaneGeometry) {
        let meshPlane = MeshPlane(planeGeometry: planeGeometry, planeColor: UIColor.white.withAlphaComponent(0.3))
        addChildNode(meshPlane)
        self.meshPlane = meshPlane
    }
    
    @available(iOS 11.3, *)
    private func removeMeshPlane() {
        guard let meshPlane = self.meshPlane as? MeshPlane else { return }
        meshPlane.removeFromParentNode()
    }
    
    @available(iOS 11.3, *)
    private func updateMeshPlane(anchor: ARPlaneAnchor) {
        guard let meshPlane = self.meshPlane as? MeshPlane else { return }
        meshPlane.update(anchor: anchor)
    }
    
    /// MARK VideoPlayer
    public private(set) var videoPlayer: VideoPlayer? {
        didSet {
            updateVideoPlayer()
        }
    }
    
    private func updateVideoPlayer() {
        guard let videoPlayer = self.videoPlayer else { return }
        // Clear Mesh Plane
        if #available(iOS 11.3, *) {
            removeMeshPlane()
        }
        
        setupVideoPlayer(videoPlayer: videoPlayer)
    }
    
    private func setupVideoPlayer(videoPlayer: VideoPlayer) {
        guard !childNodes.contains(videoPlayer) else { return }
        addChildNode(videoPlayer)
    }
    
    public func setupPlayer() {
        guard videoPlayer == nil else { return }
        videoPlayer = VideoPlayer()
        guard let borderPlaneGeometry = borderPlane.borderPlaneGeometry else { return }
        videoPlayer?.simdPosition = borderPlane.simdPosition
        videoPlayer?.planeSize = CGSize(width: borderPlaneGeometry.width - 0.01, height: borderPlaneGeometry.height - 0.01)
        deselect()
    }
    
    public func showPlayer() {
        isShowingVideoPlayer = true
    }
    
    public func playVideo() {
        videoPlayer?.play()
    }
    
    public func pauseVideo() {
        videoPlayer?.pause()
    }
    
    public func toggleVideo() {
        videoPlayer?.toggle()
    }
}
