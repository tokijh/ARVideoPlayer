//
//  System+Command.swift
//  ARVideoPlayer
//
//  Created by 윤중현 on 2018. 10. 17..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import ARKit

extension System {
    enum Command {
        case run(configure: ARConfiguration, options: ARSession.RunOptions)
        case pause
        case setStatusText(String?)
    }
    
    func send(command: Command) {
        delegate?.command(self, command: command)
    }
}
