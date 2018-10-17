//
//  BorderPlaneGeometry.swift
//  ARVideoPlayer
//
//  Created by 윤중현 on 2018. 10. 17..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import ARKit

class BorderPlaneGeometry: SCNPlane {
    init(borderColor: UIColor?) {
        super.init()
        self.borderColor = borderColor
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupShader()
    }
    
    /// MARK Update
    public func update(anchor: ARPlaneAnchor) {
        width = CGFloat(anchor.extent.x)
        height = CGFloat(anchor.extent.z)
    }
    
    /// MARK Border Color
    var borderColor: UIColor? = nil {
        didSet {
            updateBorderColor()
        }
    }
    
    private func updateBorderColor() {
        firstMaterial?.diffuse.contents = borderColor
    }
    
    /// MARK Shader
    private func setupShader() {
        guard let path = Bundle.main.path(forResource: "wireframe_shader", ofType: "metal", inDirectory: "Assets.scnassets")
            else { fatalError("Can't find wireframe shader") }
        do {
            let shader = try String(contentsOfFile: path, encoding: .utf8)
            firstMaterial?.shaderModifiers = [.surface: shader]
        } catch {
            fatalError("Can't load wireframe shader: \(error)")
        }
    }
}
