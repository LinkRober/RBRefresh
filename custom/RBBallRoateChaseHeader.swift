//
//  RBBallRoateChaseHeader.swift
//  RBRefresh
//
//  Created by 夏敏 on 06/02/2017.
//  Copyright © 2017 夏敏. All rights reserved.
//

import UIKit

class RBBallRoateChaseHeader: UIView,RBPullDownToRefreshViewDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: CGFloat(237 / 255.0), green: CGFloat(85 / 255.0), blue: CGFloat(101 / 255.0), alpha: 1)
        for i in 0..<5 {
            let rate = Float(i) * 1.0 / 5
            let layer = CAShapeLayer()
            let path:UIBezierPath = UIBezierPath()
            path.addArc(withCenter: CGPoint.init(x: 4, y: 4), radius: 4, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: false)
            layer.fillColor = UIColor.white.cgColor
            layer.path = path.cgPath
            layer.frame = CGRect.init(x: (frame.size.width - 8) / 2, y: 8, width: 8, height: 8)
            let animation = roateAnimation(x:  frame.size.width / 2, y: frame.size.height / 2,rate:rate)
            layer.add(animation, forKey: "animation")
            self.layer.addSublayer(layer)
        }
        
    }
    
    func roateAnimation(x:CGFloat,y:CGFloat,rate:Float) -> CAAnimationGroup {
        let duration:CFTimeInterval = 1.5
        let fromScale = 1 - rate
        let toScale = 0.2 + rate
        let timeFunc = CAMediaTimingFunction.init(controlPoints: 0.5, 0.15 + rate, 0.25, 1.0)
        
        //scale animation
        let scaleAnimation = CABasicAnimation.init(keyPath: "transform.scale")
        scaleAnimation.duration = duration
        scaleAnimation.repeatCount = HUGE
        scaleAnimation.fromValue = fromScale
        scaleAnimation.toValue = toScale
        
        //positon animtaion
        let positionAnimation = CAKeyframeAnimation.init(keyPath: "position")
        positionAnimation.duration = duration
        positionAnimation.repeatCount = HUGE
        positionAnimation.path = UIBezierPath.init(arcCenter: CGPoint.init(x: x, y: y), radius: 15, startAngle: 3 * CGFloat(M_PI) * 0.5, endAngle: 3 * CGFloat(M_PI) * 0.5 + 2 * CGFloat(M_PI), clockwise: true).cgPath
        
        //animation
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnimation,positionAnimation]
        animation.timingFunction = timeFunc
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
