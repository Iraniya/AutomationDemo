//
//  BreathView.swift
//  AutomationDemo
//
//  Created by Iraniya Naynesh on 27/03/22.
//

import Foundation
import UIKit

protocol BreatheViewDelegate: AnyObject {
    func didCompletedAnimation()
}

public final class BreatheView: UIView, CAAnimationDelegate {
    
    weak var delegate: BreatheViewDelegate?
    
    public static let nodeColor: UIColor = UIColor(red: 100/255, green: 190/255, blue: 230/255, alpha: 1)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        replicatorLayer.position = center
    }
    
    // MARK: - Public API
    
    public var isAnimating: Bool {
        return _isAnimating
    }
    
    public var nodesCount: Int = 8 {
        didSet {
            stopAnimations()
            updateReplicatorLayers()
        }
    }
    
    public func startAnimations() {
        _isAnimating = true
        applyReplicatorLayerAnimations(true)
    }
    
    public func stopAnimations() {
        _isAnimating = false
        applyReplicatorLayerAnimations(false)
    }
    
    // MARK: - Private API
    
    private var _isAnimating: Bool = false
    
    private lazy var replicatorLayer = makeReplicatorLayer(withInstanceCount: nodesCount)
    
    private lazy var radius: CGFloat = {
        return min(bounds.width, bounds.height)/2
    }()
    
    private lazy var node: CALayer = {
        let circle = CALayer()
        circle.compositingFilter = "screenBlendMode"
        circle.frame = CGRect(origin: CGPoint(x: 0, y: -radius/2), size: CGSize(width: radius, height: radius))
        circle.backgroundColor = BreatheView.nodeColor.withAlphaComponent(0.75).cgColor
        circle.cornerRadius = radius/2
        return circle
    }()
    
    private var nodeAngleTransformValue: CATransform3D {
        let angle = -CGFloat.pi * 2.0 / CGFloat(nodesCount)
        return CATransform3DMakeRotation(angle, 0, 0, -1)
    }
    
    private func commonInit() {
        backgroundColor = UIColor.clear
        layer.backgroundColor = UIColor.clear.cgColor
        layer.addSublayer(replicatorLayer)
    }
    
    private func makeReplicatorLayer(withInstanceCount instanceCount: Int) -> CAReplicatorLayer {
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.addSublayer(node)
        replicatorLayer.instanceCount = instanceCount
        replicatorLayer.instanceBlueOffset = (-0.33 / Float(nodesCount))
        replicatorLayer.instanceTransform = nodeAngleTransformValue
        return replicatorLayer
    }
    
    private func updateReplicatorLayers() {
        replicatorLayer.instanceCount = nodesCount
        replicatorLayer.instanceTransform = nodeAngleTransformValue
    }
    
    private func applyReplicatorLayerAnimations(_ apply: Bool) {
        if apply {
            let center = CGPoint(x: layer.bounds.width/2 - radius, y: layer.bounds.height/2 - radius)
            let moveAndReverseAnimation = CABasicAnimation.Custom.MoveAndReverse.animation(from: node.position, to: center)
            moveAndReverseAnimation.delegate = self
            node.add(moveAndReverseAnimation, forKey: CABasicAnimation.Custom.MoveAndReverse.key)
            
            node.add(CABasicAnimation.Custom.ScaleDownAndReverse.animation,
                     forKey: CABasicAnimation.Custom.ScaleDownAndReverse.key)
            
            replicatorLayer.add(CABasicAnimation.Custom.RotateAndReverse.animation,
                                forKey: CABasicAnimation.Custom.RotateAndReverse.key)
            
        } else {
            node.removeAllAnimations()
            replicatorLayer.removeAllAnimations()
        }
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("animationDidStop")
        guard let delegate = delegate else {
            return
        }
        
        delegate.didCompletedAnimation()
    }
    
}
