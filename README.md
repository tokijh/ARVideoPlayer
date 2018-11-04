# ARVideoPlayer

## Intoduction
🌃 View, Play your Video in Argument Reality Place! 

![demo](img/demo.gif)

## Requirements

`ARVideoPlayer` is written in Swift 4.2. Compatible with iOS 10.0+

## Usage
Make your own `system` for your need
```Swift 

// Add New Plane 
system.set(action: .didTap(plane: plane))

// Add UIPinchGestureRecognizer
system.set(action: .didPinch(scale: scale))

// Add UIRotationGestureRecognizer
system.set(action: .didRotate(rotation: rotation))

// Call delegate method in ARSCNViewDelegate
extension ViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        system.set(action: .didAdd(node: node, anchor: anchor))
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        system.set(action: .didUpdate(node: node, anchor: anchor))
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        system.set(action: .didRemove(node: node, anchor: anchor))
    }
}
```

## Author
tokijh

## License
ARVideoPlayer is available under the MIT license. See the LICENSE file for more info.
