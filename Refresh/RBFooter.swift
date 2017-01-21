//
//  RBFooter.swift
//  RBRefresh
//
//  Created by 夏敏 on 30/12/2016.
//  Copyright © 2016 夏敏. All rights reserved.
//

import UIKit
private var KVOContext = "RefresherFooterKVOContext"
private let ContentOffsetKeyPath = "contentOffset"
private var KVOContentSize = "KVOContentSize"
private let ContentSizeKeyPath = "contentSize"

class RBFooter: RBView {
    
    var action:(()->()) = {}
    var animator:PullUpToRefreshViewDelegate?
    var loadmore:Bool = false
    var enableLoadMore:Bool = true
    //MARK:- LifyCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect,animator:PullUpToRefreshViewDelegate) {
        self.animator = animator
        super.init(frame: frame)
        loadmore = false
    }
    
    convenience init(frame: CGRect,action:@escaping () -> (),animator:PullUpToRefreshViewDelegate,subView:UIView) {
        self.init(frame: frame,animator:animator)
        self.action = action
        subView.frame = bounds
        self.addSubview(subView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        superview?.removeObserver(self, forKeyPath: ContentOffsetKeyPath, context: &KVOContext)
        if let scrollow = newSuperview as? UIScrollView {
            scrollow.addObserver(self, forKeyPath: ContentOffsetKeyPath, options: .initial, context: &KVOContext)
            scrollow.addObserver(self, forKeyPath: ContentSizeKeyPath, options: .initial, context: &KVOContentSize)
        }
    }
    
    deinit {
        let scrollow  = self.superview as? UIScrollView
        scrollow?.removeObserver(self, forKeyPath: ContentOffsetKeyPath, context: &KVOContext)
        scrollow?.removeObserver(self, forKeyPath: ContentSizeKeyPath, context: &KVOContentSize)
    }
    
    //MARK:- Action
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if context == &KVOContentSize {
            guard !loadmore  else {
                return
            }
            if let scrollow = self.superview as? UIScrollView {
                let height = self.frame.size.height
                self.frame = CGRect(x:0,y:scrollow.contentSize.height,width:kScreenWidth,height:height)
            }
        }
        
        guard enableLoadMore else {
            return
        }
        
        if context == &KVOContext {
            if let scrollow = self.superview as? UIScrollView {
                
                guard scrollow.contentSize.height != 0 else {
                    return
                }
                if (scrollow.contentOffset.y + scrollow.frame.size.height) >= (self.frame.size.height + scrollow.contentSize.height) {
                    if scrollow.isDragging == false && loadmore == false{
                        //拉到可以加载更多的位置，并且开始加载更多
                        if scrollow.contentSize.height < scrollow.frame.size.height {
                            footerNoMoreData()
                        }else {
                            //正在刷新
                            startAnimation()
                        }
                    }else if scrollow.isDragging == true && loadmore == false {
                        //释放加载更多
                        self.animator?.pullUpToRefresh(self, stateDidChange: .releaseToLoadMore)
                    }
                }else {
                    //上拉加载更多
                    self.animator?.pullUpToRefresh(self, stateDidChange: .pullUpToRefresh)
                }
            }
        }
    }
    
    //MARK:- Public
    func endFooterRefrsh(){
        stopAnimation()
    }
    
    func footerNoMoreData(){
        self.animator?.pullUpToRefreshAnimationNoticeNoMore(self)
        self.enableLoadMore = false
    }
    
    func footerResetMoreData(){

        self.animator?.pullUpToRefreshAnimationResetNoMore(self)
        self.enableLoadMore = true
    }
    
    //MARK:- Pirvate
    func startAnimation(){
        loadmore = true
        self.animator?.pullUpToRefresh(self, stateDidChange: .loading)
        let scrollow = self.superview as! UIScrollView
        UIView.animate(withDuration: 0.3, animations: {
            scrollow.contentInset.bottom = self.frame.size.height
        }) { (finished:Bool) in
            self.action()
        }
    }
    
    func stopAnimation(){
        self.loadmore = false
        let scrollow = self.superview as! UIScrollView
        self.animator?.pullUpToRefreshAnimationDidEnd(self)
        UIView.animate(withDuration: 0.3, animations: {
            scrollow.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }) { (finished:Bool) in
            self.animator?.pullUpToRefreshAnimationDidStart(self)
        }
    }
    
    
}
