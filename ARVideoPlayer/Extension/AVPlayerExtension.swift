//
//  AVPlayerExtension.swift
//  ARVideoPlayer
//
//  Created by 윤중현 on 18/10/2018.
//  Copyright © 2018 tokijh. All rights reserved.
//

import AVKit

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
