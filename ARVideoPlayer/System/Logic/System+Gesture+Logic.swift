//
//  System+Gesture+Logic.swift
//  ARVideoPlayer
//
//  Created by 윤중현 on 17/10/2018.
//  Copyright © 2018 tokijh. All rights reserved.
//

import ARKit
extension System {
    func didTap(plane: Plane) {
        set(status: .playingVideo)
        resumeSession()
        plane.showPlayer()
    }
}
