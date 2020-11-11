//
//  DotsActivityIndicator.swift
//  animation_training
//
//  Created by mnem on 10/8/20.
//

import UIKit
@IBDesignable
class DotsActivityIndicator: UIView {
    
    enum AnimationKeys {
        static let group = "scaleGroupAnimation"
    }
    
    enum AnimationConstans {
        static let dotScale: CGFloat = 1.5
        static let scaleUpDuraion: TimeInterval = 0.2
        static let scaleDownDuration: TimeInterval = 0.2
        static let offset: TimeInterval = 0.2
        static var totalScaleDuration: TimeInterval {
            return scaleUpDuraion + scaleDownDuration
        }
    }
    
    
    
    var dots: [CALayer] = []
    
    @IBInspectable
    var dotsCount: Int = 3 {
        didSet {
            removeDots()
            configureDots()
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    var dotRadius: CGFloat = 8.0 {
        didSet {
            for dot in dots {
                configureDotSize(dot)
            }
            setNeedsLayout()
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            for dot in dots {
                configureDotColor(dot)
            }
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    var dotSpacing: CGFloat = 8.0
    
    var dotSize: CGSize {
        return CGSize(width: dotRadius * 2, height: dotRadius * 2)
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureDots()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let center = CGPoint(x: frame.width/2, y: frame.height/2)
        let middle = dots.count/2
        for i in 0..<dots.count {
            let x = center.x + CGFloat(i - middle)*(dotSize.width + dotSpacing)
            let y = center.y
            dots[i].position = CGPoint(x: x, y: y)
        }
    }
    
    
    func configureDots() {
        for _ in 0..<dotsCount {
            let dot = CALayer()
            configureDotSize(dot)
            configureDotColor(dot)
            dots.append(dot)
            layer.addSublayer(dot)
        }
        startAnimation()
    }
    
    func removeDots() {
        for dot in dots {
            dot.removeFromSuperlayer()
        }
        dots.removeAll()
    }
    
    func configureDotSize(_ dot: CALayer) {
        dot.frame.size = CGSize(width: dotRadius * 2, height: dotRadius * 2)
        dot.cornerRadius = dotRadius
    }
    func configureDotColor(_ dot:CALayer) {
        dot.backgroundColor = tintColor.cgColor
    }
    
    func startAnimation() {
        var offset: TimeInterval = 0
        for dot in dots {
            dot.removeAnimation(forKey: AnimationKeys.group)
            let animation = scaleAnimation(offset)
            dot.add(animation, forKey: AnimationKeys.group)
            offset = offset + AnimationConstans.offset
        }
        
    }
    
    func stopAnimation() {
        
        
    }
    
    func scaleAnimation(_ after: TimeInterval) -> CAAnimationGroup {
        let scaleUP = CABasicAnimation(keyPath: "transform.scale")
        scaleUP.beginTime = after
        scaleUP.fromValue = 1
        scaleUP.toValue = AnimationConstans.dotScale
        scaleUP.duration = AnimationConstans.scaleUpDuraion
        
        let scaleDown = CABasicAnimation(keyPath: "transform.scale")
        scaleDown.beginTime = after + scaleUP.duration
        scaleDown.fromValue = AnimationConstans.dotScale
        scaleDown.toValue = 1
        scaleDown.duration = AnimationConstans.scaleDownDuration
        
        let group = CAAnimationGroup()
        group.animations = [scaleUP, scaleDown]
        group.repeatCount = .infinity
        group.duration = AnimationConstans.totalScaleDuration * TimeInterval(dots.count)
        return group
    }
    
}
