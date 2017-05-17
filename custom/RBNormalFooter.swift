//
//  RBNormalFooter.swift
//  RBRefresh
//
//  Created by 夏敏 on 20/01/2017.
//  Copyright © 2017 夏敏. All rights reserved.
//

import UIKit

class RBNormalFooter: UIView,RBPullUpToRefreshViewDelegate {

    lazy var activity:UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView.init(activityIndicatorStyle: .white)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        return activity
    }()
    lazy var moreLabel:UILabel = {
        let noMoreLabel = UILabel.init()
        noMoreLabel.textColor = UIColor.black
        noMoreLabel.text = "上拉加载更多"
        noMoreLabel.translatesAutoresizingMaskIntoConstraints = false
        noMoreLabel.isHidden = false
        return noMoreLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(activity)
        addSubview(moreLabel)
        self.backgroundColor = UIColor.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        self.addConstraint(NSLayoutConstraint.init(item: activity
            , attribute: .centerX
            , relatedBy: .equal
            , toItem: self
            , attribute: .centerX
            , multiplier: 1.0
            , constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: activity
            , attribute: .centerY
            , relatedBy: .equal
            , toItem: self
            , attribute: .centerY
            , multiplier: 1.0
            , constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: moreLabel
            , attribute: .centerX
            , relatedBy: .equal
            , toItem: self
            , attribute: .centerX
            , multiplier: 1.0
            , constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: moreLabel
            , attribute: .centerY
            , relatedBy: .equal
            , toItem: self
            , attribute: .centerY
            , multiplier: 1.0
            , constant: 0))
        
        super.layoutSubviews()
    }
    
    //MARK:- PullUpToRefreshViewDelegate
    func pullUpToRefreshAnimationDidEnd(_ view: RBFooter) {
        //
        self.activity.stopAnimating()
        self.moreLabel.text = "刷新结束"
    }
    
    func pullUpToRefresh(_ view: RBFooter, progressDidChange progress: CGFloat) {
        //
    }
    
    func pullUpToRefreshAnimationDidStart(_ view: RBFooter) {
        self.moreLabel.text = "上拉加载更多"
    }
    
    func pullUpToRefresh(_ view: RBFooter, stateDidChange state: RBPullUpToRefreshViewState) {
        if state == .loading {
            self.moreLabel.isHidden = true
            self.activity.startAnimating()
        }else if state == .pullUpToRefresh {
            self.moreLabel.isHidden = false
            self.moreLabel.text = "上拉加载更多"
        }else if state == .releaseToLoadMore {
            self.moreLabel.isHidden = false
            self.moreLabel.text = "释放加载更多"
        }
    }
    
    func pullUpToRefreshAnimationResetNoMore(_ view: RBFooter) {
        self.moreLabel.isHidden = false
        self.moreLabel.text = "上拉加载更多"
    }
    
    func pullUpToRefreshAnimationNoticeNoMore(_ view: RBFooter) {
        self.moreLabel.isHidden = false
        self.moreLabel.text = "没有更多了"
    }

}
