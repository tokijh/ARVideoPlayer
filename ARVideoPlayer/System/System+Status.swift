//
//  System+Status.swift
//  ARVideoPlayer
//
//  Created by 윤중현 on 2018. 10. 17..
//  Copyright © 2018년 tokijh. All rights reserved.
//

extension System {
    enum Status {
        case setup
        case tracking
        case playingVideo
    }
    
    func set(status: Status) {
        self.status = status
    }
}
