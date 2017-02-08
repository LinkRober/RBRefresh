//
//  RBBallScaleHeader.swift
//  RBRefresh
//
//  Created by 夏敏 on 08/02/2017.
//  Copyright © 2017 夏敏. All rights reserved.
//

import UIKit

class RBBallScaleHeader: UIView ,RBPullDownToRefreshViewDelegate{

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: CGFloat(237 / 255.0), green: CGFloat(85 / 255.0), blue: CGFloat(101 / 255.0), alpha: 1)
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        
        path.addArc(withCenter: CGPoint.init(x: 15, y: 15), radius: 15, startAngle: 0, endAngle: 2*CGFloat(M_PI), clockwise: false)
        layer.path = path.cgPath
        layer.fillColor = UIColor.white.cgColor
        layer.frame = CGRect.init(x: (frame.size.width - 30)/2, y: (frame.size.height - 30)/2, width: 30, height: 30)
        let animtaion = getAnimation()
        layer.add(animtaion, forKey: "animation")
        self.layer.addSublayer(layer)
        
        
    }
    
    func getAnimation() -> CAAnimationGroup {
        
        let duration:CFTimeInterval = 1
        
        //scale
        let scaleAnimation = CABasicAnimation.init(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.duration = duration
        
        //opacity
        let opacityAnimation = CABasicAnimation.init(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.duration = duration
        
        //group
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [scaleAnimation,opacityAnimation]
        animationGroup.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        animationGroup.duration = duration
        animationGroup.repeatCount = HUGE
        animationGroup.isRemovedOnCompletion = false
        
        return animationGroup
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
