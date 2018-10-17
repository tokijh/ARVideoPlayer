//
//  SystemDelegate.swift
//  ARVideoPlayer
//
//  Created by 윤중현 on 2018. 10. 17..
//  Copyright © 2018년 tokijh. All rights reserved.
//

protocol SystemDelegate: class {
    func command(_ system: System, command: System.Command)
}

extension SystemDelegate {
    func command(_ system: System, command: System.Command) {
        
    }
}
