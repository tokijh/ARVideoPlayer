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
        if status == .tracking {
            set(status: .playingVideo)
            resumeSession()
            planes.forEach({ $0.deselect() })
        }
        if status == .playingVideo {
            plane.showPlayer()
            if let selectedPlane = selectedPlane,
                plane == selectedPlane {
                selectedPlane.toggleVideo()
            } else {
                selectedPlane?.deselect()
                plane.select()
                selectedPlane = plane
            }
        }
    }
}
