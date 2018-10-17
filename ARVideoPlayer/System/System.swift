//
//  System.swift
//  ARVideoPlayer
//
//  Created by 윤중현 on 2018. 10. 17..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import ARKit

class System {
    
    /// MARK Status
    var status: Status = .setup
    
    /// MARK Delegate
    weak var delegate: SystemDelegate? = nil
    
    /// MARK Device
    let device: MTLDevice? = MTLCreateSystemDefaultDevice()
    
    /// MARK Selected Plane
    var selectedPlane: Plane?
}
