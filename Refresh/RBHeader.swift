//
//  RBHeader.swift
//  RBRefresh
//
//  Created by 夏敏 on 30/12/2016.
//  Copyright © 2016 夏敏. All rights reserved.
//

import UIKit
private var KVOContext = "RefresherHeaderKVOContext"
private let ContentOffsetKeyPath = "contentOffset"
private let stagnate_padding:CGFloat = 30

class RBHeader: RBView {
    
    var action:(() -> ()) = {}
    var animator:PullDownToRefreshViewDelegate?
    var loading:Bool = false {
        didSet {
            if loading != oldValue {
                if loading {
                    startAnimation()
                }else {
                    stopAnimation()
                }
            }
        }
    }
    
    var headerHeight:CGFloat {
        get{
            return self.bounds.height
        }
    }
    
    //MARK:- LifyCycle
     init(frame: CGRect,animator:PullDownToRefreshViewDelegate) {
        self.animator = animator
        super.init(frame: frame)

    }
    
    convenience init(frame: CGRect,action:@escaping (() -> ()),animator:PullDownToRefreshViewDelegate) {
        self.init(frame: frame,animator:animator)
        self.action = action
    }
    
    convenience init(frame: CGRect,action:@escaping (() -> ()),animator:PullDownToRefreshViewDelegate,subView:UIView) {
        self.init(frame: frame,animator:animator)
        self.action = action
        addSubview(subView)
        subView.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        superview?.removeObserver(self, forKeyPath: ContentOffsetKeyPath, context: &KVOContext)
        if let scrollow = newSuperview as? UIScrollView {
            scrollow.addObserver(self, forKeyPath: ContentOffsetKeyPath, options: .initial, context: &KVOContext)
        }
    }
    
    //MARK:- Action
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &KVOContext {
            
            if let scrollow = self.superview as? UIScrollView {
                if scrollow.contentOffset.y <= -headerHeight {
                    if scrollow.isDragging == false && loading == false{
                        //拉到可以释放的范围，并释放
                        loading = true
                    }else if (loading == true && scrollow.isDragging == false) {
                        //释放的时候，悬浮刷新
                    }else if scrollow.isDragging == true && loading == false {
                        //释放刷新
                        self.animator?.pullDownToRefresh(self, stateDidChange: .releaseToRefresh)
                    }
                }else {
                    //下拉刷新
                    self.animator?.pullDownToRefresh(self, stateDidChange: .pullDownToRefresh)
                }
            }
        }
    }
    
    //MARK:- Public
    func endHeaderRefresh(){
        self.loading = false
    }
    
    func autociallyRefreshHeader(){
        let scrollow = self.superview as! UIScrollView
        UIView.animate(withDuration: 0.3) {
            scrollow.contentInset = UIEdgeInsetsMake(self.headerHeight, 0, 0, 0)
        }
    }
    
    
    //MARK:- Private
    func startAnimation(){
        self.animator?.pullDownToRefresh(self, stateDidChange: .loading)
        let scrollow = self.superview as! UIScrollView
        UIView.animate(withDuration: 0.3, animations: {
            scrollow.contentInset = UIEdgeInsetsMake(self.headerHeight, 0, 0, 0)
        }) { (finished:Bool) in
            if finished {
                self.action()
            }
        }
    }
    
    func stopAnimation(){
        let scrollow = self.superview as! UIScrollView
        self.animator?.pullDownToRefreshAnimationDidEnd(self)
        UIView.animate(withDuration: 0.3, animations: {
            scrollow.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }) { (finished:Bool) in
            self.animator?.pullDownToRefreshAnimationDidStart(self)
        }
    }
    
    deinit {
        let scrollow  = self.superview as? UIScrollView
        scrollow?.removeObserver(self, forKeyPath: ContentOffsetKeyPath, context: &KVOContext)
    }
}
