//
//  RBBallClipRoateHeader.swift
//  RBRefresh
//
//  Created by 夏敏 on 07/02/2017.
//  Copyright © 2017 夏敏. All rights reserved.
//

import UIKit

class RBBallClipRoateHeader: UIView,RBPullDownToRefreshViewDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: CGFloat(237 / 255.0), green: CGFloat(85 / 255.0), blue: CGFloat(101 / 255.0), alpha: 1)
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint.init(x: 15, y: 15), radius: 15, startAngle: -3*4*CGFloat(M_PI_4), endAngle: CGFloat(-M_PI_4), clockwise: false)
        layer.fillColor = nil
        layer.strokeColor = UIColor.white.cgColor
        layer.lineWidth = 2
        layer.path = path.cgPath
        layer.frame = CGRect.init(x: (frame.size.width - 30)/2, y: (frame.size.height - 30)/2, width: 30, height: 30)
        
        let animation = roateAnimation()
        layer.add(animation, forKey: "animation")
        
        self.layer.addSublayer(layer)
        
    }
    
    
    func roateAnimation() -> CAAnimationGroup{
        let duration: CFTimeInterval = 0.75

        //    Scale animation
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        
        scaleAnimation.keyTimes = [0, 0.5, 1]
        scaleAnimation.values = [1, 0.6, 1]
        
        // Rotate animation
        let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        
        rotateAnimation.keyTimes = scaleAnimation.keyTimes
        rotateAnimation.values = [0, M_PI, 2 * M_PI]
        
        // Animation
        let animation = CAAnimationGroup()
        
        animation.animations = [scaleAnimation, rotateAnimation]
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        
        return animation
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pullDownToRefreshAnimationDidEnd(_ view: RBHeader) {
        
    }
    func pullDownToRefreshAnimationDidStart(_ view: RBHeader) {
        
    }
    func pullDownToRefresh(_ view: RBHeader, progressDidChange progress: CGFloat) {
        
    }
    func pullDownToRefresh(_ view: RBHeader, stateDidChange state: RBPullDownToRefreshViewState) {
        
    }


}
