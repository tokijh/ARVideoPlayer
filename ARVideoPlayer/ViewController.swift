//
//  ViewController.swift
//  ARVideoPlayer
//
//  Created by 윤중현 on 2018. 10. 17..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    typealias Action = System.Action
    typealias Command = System.Command

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        system.set(action: .viewDidAppear)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        system.set(action: .viewWillDisappear)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        system.set(action: .viewDidDisappear)
    }

    private func setup() {
        setupSystem()
        setupSceneView()
        setupGesture()
        setupStatusLabel()
    }
    
    /// MARK System
    let system = System()
    
    private func setupSystem() {
        system.delegate = self
    }
    
    /// MARK SceneView
    @IBOutlet weak var sceneView: ARSCNView!
    
    private func setupSceneView() {
        #if DEBUG
        sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
        sceneView.showsStatistics = true
        #endif
        sceneView.delegate = self
    }
    
    private func run(configure: ARConfiguration, options: ARSession.RunOptions) {
        sceneView.session.run(configure, options: options)
    }
    
    private func pause() {
        sceneView.session.pause()
    }
    
    /// MARK Gesture
    private func setupGesture() {
        setupTapGesture()
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapSceneView(_:)))
        sceneView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapSceneView(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: sceneView)
        let hitResults = sceneView.hitTest(location, types: .existingPlaneUsingExtent)
        guard let anchor = hitResults.first?.anchor,
            let node = sceneView.node(for: anchor),
            let plane = node.childNodes.first as? Plane
            else { return }
        system.set(action: .didTap(plane: plane))
    }
    
    /// MARK Status Label
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    private func setupStatusLabel() {
        statusView.isHidden = true
        statusLabel.text = ""
    }
    
    private func set(message: String?) {
        statusView.isHidden = message == nil
        statusLabel.text = message
    }
}

extension ViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        system.set(action: .didAdd(node: node, anchor: anchor))
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        system.set(action: .didUpdate(node: node, anchor: anchor))
    }
}

extension ViewController {
    
}

extension ViewController: SystemDelegate {
    func command(_ system: System, command: Command) {
        switch command {
        case let .run(configure, options):
            run(configure: configure, options: options)
        case .pause:
            pause()
        case let .setStatusText(message):
            set(message: message)
        }
    }
}
