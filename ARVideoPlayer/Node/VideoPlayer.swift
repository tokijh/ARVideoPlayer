//
//  VideoPlayer.swift
//  ARVideoPlayer
//
//  Created by 윤중현 on 18/10/2018.
//  Copyright © 2018 tokijh. All rights reserved.
//

import ARKit

class VideoPlayer: SCNNode {
    
    init(url: URL) {
        super.init()
        name = "VideoPlayer"
        self.url = url
        updateUrl()
    }
    
    override init() {
        super.init()
        name = "VideoPlayer"
        guard let path = Bundle.main.path(forResource: "sample", ofType: "mp4")
            else { fatalError("Can't find wireframe shader") }
        self.url = URL(fileURLWithPath: path)
        updateUrl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// MARK url
    var url: URL? {
        didSet {
            updateUrl()
        }
    }
    
    private func updateUrl() {
        guard let url = url else {
            player = nil
            return
        }
        player = AVPlayer(url: url)
    }
    
    /// MARK PlaneGeometry
    var planeGeometry: SCNPlane?
    
    public var planeSize = CGSize(width: 1, height: 1) {
        didSet {
            updateSize()
        }
    }
    
    /// MARK VideoNode
    var skScene: SKScene? = nil
    
    private func updateSize() {
        planeGeometry?.width = planeSize.width
        planeGeometry?.height = planeSize.height
        let sceneSize = CGSize(width: planeSize.width * 1000, height: planeSize.height * 1000)
        skScene?.size = sceneSize
        videoNode?.size = sceneSize
        videoNode?.position = CGPoint(x: sceneSize.width / 2, y: sceneSize.height / 2)
    }
    
    /// MARK VideoNode
    var videoNode: SKVideoNode? = nil
    
    /// MARK Player
    var player: AVPlayer? {
        didSet {
            updatePlayer()
        }
    }
    
    private func updatePlayer() {
        clearPlayer()
        guard let player = player else { return }
        setupPlayer(player: player)
    }
    
    private func clearPlayer() {
        geometry?.firstMaterial?.diffuse.contents = nil
    }
    
    private func setupPlayer(player: AVPlayer) {
        let planeGeometry = SCNPlane(width: planeSize.width, height: planeSize.height)
        
        let skScene = SKScene(size: CGSize(width: planeSize.width * 1000, height: planeSize.height * 1000))
        let videoNode = SKVideoNode(avPlayer: player)
        skScene.addChild(videoNode)
        
        videoNode.position = CGPoint(x: skScene.size.width / 2, y: skScene.size.height / 2)
        videoNode.size = skScene.size
        
        planeGeometry.firstMaterial?.diffuse.contents = skScene
        planeGeometry.firstMaterial?.isDoubleSided = true
        
        self.planeGeometry = planeGeometry
        self.skScene = skScene
        self.videoNode = videoNode
        geometry = planeGeometry
        eulerAngles = SCNVector3(Double.pi / 2,0,0)
        
        play()
    }
    
    public func play() {
        player?.play()
    }
    
    public func pause() {
        player?.pause()
    }
    
    public func toggle() {
        guard let player = player else { return }
        if player.isPlaying {
            pause()
        } else {
            play()
        }
    }
}
