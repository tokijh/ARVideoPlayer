//
//  System+Logic.swift
//  ARVideoPlayer
//
//  Created by 윤중현 on 2018. 10. 17..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import ARKit

extension System {
    func startSession() {
        let configure = ARWorldTrackingConfiguration()
        if #available(iOS 11.3, *) {
            configure.planeDetection = [.vertical, .horizontal]
        } else {
            configure.planeDetection = [.horizontal]
        }
        let options: ARSession.RunOptions = [.resetTracking, .resetTracking]
        send(command: .run(configure: configure, options: options))
    }
    
    func pauseSession() {
        send(command: .pause)
    }
    
    func resumeSession() {
        guard status == .playingVideo else {
            startSession()
            return
        }
        let configure = ARWorldTrackingConfiguration()
        let options: ARSession.RunOptions = [.resetTracking, .resetTracking]
        send(command: .run(configure: configure, options: options))
    }
    
    func stopSession() {
        send(command: .pause)
    }
}
