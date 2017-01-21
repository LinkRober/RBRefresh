//
//  RBNormalHeader.swift
//  RBRefresh
//
//  Created by 夏敏 on 19/01/2017.
//  Copyright © 2017 夏敏. All rights reserved.
//

import UIKit

class RBNormalHeader: UIView,PullDownToRefreshViewDelegate {
    lazy var activity:UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView.init(activityIndicatorStyle: .white)
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    lazy var timeLabel:UILabel = {
        let timeLabel = UILabel.init()
        timeLabel.textColor = UIColor.black
        timeLabel.text = "下拉刷新"
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(activity)
        addSubview(timeLabel)
        self.backgroundColor = UIColor.blue
    }
    
    
    override func layoutSubviews() {
        self.addConstraint(NSLayoutConstraint.init(item: timeLabel
            , attribute: .centerX
            , relatedBy: .equal
            , toItem: self
            , attribute: .centerX
            , multiplier: 1.0
            , constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: timeLabel
            , attribute: .centerY
            , relatedBy: .equal
            , toItem: self
            , attribute: .centerY
            , multiplier: 1.0
            , constant: 0))
        
        self.addConstraint(NSLayoutConstraint.init(item: activity
            , attribute: .leading
            , relatedBy: .equal
            , toItem: timeLabel
            , attribute: .trailing
            , multiplier: 1.0
            , constant: 10))
        self.addConstraint(NSLayoutConstraint.init(item: activity
            , attribute: .centerY
            , relatedBy: .equal
            , toItem: self
            , attribute: .centerY
            , multiplier: 1.0
            , constant: 0))
        
        
        super.layoutSubviews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- PullDownToRefreshViewDelegate
    func pullDownToRefresh(_ view: RBHeader, stateDidChange state: PullDownToRefreshViewState) {
        if state == .loading {
            self.activity.startAnimating()
            self.timeLabel.text = "刷新中..."
        }else if state == .pullDownToRefresh {
            self.timeLabel.text = "下拉刷新"
        }else if state == .releaseToRefresh {
            self.timeLabel.text = "释放刷新"
        }
    }
    
    func pullDownToRefreshAnimationDidEnd(_ view: RBHeader) {
        self.activity.stopAnimating()
        self.timeLabel.text = "刷新停止"
    }
    
    func pullDownToRefreshAnimationDidStart(_ view: RBHeader) {
        self.timeLabel.text = "下拉刷新"
    }
    
    func pullDownToRefresh(_ view: RBHeader, progressDidChange progress: CGFloat) {
        //
    }
    
}
