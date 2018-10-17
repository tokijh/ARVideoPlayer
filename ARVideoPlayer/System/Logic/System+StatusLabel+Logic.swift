//
//  System+Status+Logic.swift
//  ARVideoPlayer
//
//  Created by 윤중현 on 17/10/2018.
//  Copyright © 2018 tokijh. All rights reserved.
//

extension System.Status {
    var description: String? {
        switch self {
        case .setup: return nil
        case .tracking: return "Tracking...\nSelect Plane for playing video"
        case .playingVideo: return "Playing...\nPinch and Rotate video!"
        }
    }
}

extension System {
    func setStatusText() {
        send(command: .setStatusText(status.description))
    }
}
