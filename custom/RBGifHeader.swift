//
//  RBGifHeader.swift
//  RBRefresh
//
//  Created by 夏敏 on 20/01/2017.
//  Copyright © 2017 夏敏. All rights reserved.
//

import UIKit

class RBGifHeader: UIView,RBPullDownToRefreshViewDelegate {

    lazy var loadingImageView:UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(loadingImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        self.addConstraint(NSLayoutConstraint.init(item: loadingImageView
            , attribute: .centerX
            , relatedBy: .equal
            , toItem: self
            , attribute: .centerX
            , multiplier: 1.0
            , constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: loadingImageView
            , attribute: .bottom
            , relatedBy: .equal
            , toItem: self
            , attribute: .bottom
            , multiplier: 1.0
            , constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: loadingImageView
            , attribute: .width
            , relatedBy: .equal
            , toItem: nil
            , attribute: .notAnAttribute
            , multiplier: 1.0
            , constant: 80))
        self.addConstraint(NSLayoutConstraint.init(item: loadingImageView
            , attribute: .height
            , relatedBy: .equal
            , toItem: nil
            , attribute: .notAnAttribute
            , multiplier: 1.0
            , constant: 80))
        
        
        super.layoutSubviews()
    }
    
    
    
    
    //MARK:- PullDownToRefreshViewDelegate
    
    func pullDownToRefreshAnimationDidEnd(_ view: RBHeader) {
        //
        self.loadingImageView.image = UIImage.init(named: "refresh01")
    }
    
    func pullDownToRefreshAnimationDidStart(_ view: RBHeader) {
        //
        self.loadingImageView.image = UIImage.init(named: "refresh01")
    }
    
    func pullDownToRefresh(_ view: RBHeader, progressDidChange progress: CGFloat) {
        //
    }
    
    func pullDownToRefresh(_ view: RBHeader, stateDidChange state: RBPullDownToRefreshViewState) {
        //
        if state == .loading {
            self.loadingImageView.image = UIImage.gif(name: "vivasam_currency_refresh")
        }else if state == .pullDownToRefresh {
            self.loadingImageView.image = UIImage.init(named: "refresh01")
        }else if state == .releaseToRefresh {
            self.loadingImageView.image = UIImage.init(named: "refresh02")
        }
    }
    
    func pullDownToRefreshAnimationHeight(_ view: RBHeader) -> CGFloat {
        return 80.0
    }

}
