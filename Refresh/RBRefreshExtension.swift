//
//  RBRefreshExtension.swift
//  RBRefresh
//
//  Created by 夏敏 on 30/12/2016.
//  Copyright © 2016 夏敏. All rights reserved.
//

import UIKit
let kScreenWidth:CGFloat = UIScreen.main.bounds.width
private let kHeaderViewTag = 10001
private let kFooterViewTag = 10002


public enum PullDownToRefreshViewState {
    case loading
    case pullDownToRefresh
    case releaseToRefresh
}
public enum PullUpToRefreshViewState {
    case loading
    case pullUpToRefresh
    case releaseToLoadMore
}

protocol PullDownToRefreshViewDelegate {
    func pullDownToRefreshAnimationDidStart(_ view: RBHeader)
    func pullDownToRefreshAnimationDidEnd(_ view: RBHeader)
    func pullDownToRefresh(_ view: RBHeader, progressDidChange progress: CGFloat)
    func pullDownToRefresh(_ view: RBHeader, stateDidChange state: PullDownToRefreshViewState)
}

protocol PullUpToRefreshViewDelegate {
    func pullUpToRefreshAnimationDidStart(_ view: RBFooter)
    func pullUpToRefreshAnimationDidEnd(_ view: RBFooter)
    func pullUpToRefresh(_ view: RBFooter, progressDidChange progress: CGFloat)
    func pullUpToRefresh(_ view: RBFooter, stateDidChange state: PullUpToRefreshViewState)
    func pullUpToRefreshAnimationNoticeNoMore(_ view: RBFooter)
    func pullUpToRefreshAnimationResetNoMore(_ view: RBFooter)
}

extension UIScrollView {
    
    var headerView:RBHeader?{
        get{
            let pullToRefreshView = viewWithTag(kHeaderViewTag)
            return pullToRefreshView as? RBHeader
        }
    }
    
    var footerView:RBFooter?{
        get{
            let pullToRefreshView = viewWithTag(kFooterViewTag)
            return pullToRefreshView as? RBFooter
        }
    }
    
    //MARK:- Public
    func addHeaderRefreshBlock<T:UIView>(_ refreshCompleteBlock:@escaping (()->())
        ,animator:T)
        where T:PullDownToRefreshViewDelegate
    {
        let headerView = RBHeader.init(frame: CGRect(x:0,y:-animator.bounds.size.height,width: kScreenWidth,height: animator.bounds.size.height),
                                       action: refreshCompleteBlock,
                                       animator: animator,
                                       subView: animator)
        headerView.tag = kHeaderViewTag
        addSubview(headerView)
    }
    
    func addFooterRefreshBlock<T:UIView>(_ refreshCompleteBlock:@escaping (()->()),
                               animator:T)
        where T:PullUpToRefreshViewDelegate
    {
        let footerView = RBFooter.init(frame: CGRect(x:0,y:0,width: kScreenWidth,height: animator.bounds.height),
                                       action: refreshCompleteBlock,
                                       animator: animator,
                                       subView: animator)
        footerView.tag = kFooterViewTag
        addSubview(footerView)
    }
    
    func beginHeaderRefresh(){
        self.headerView?.autociallyRefreshHeader()
    }
    
    func endHeaderRefresh(){
        headerView?.endHeaderRefresh()
    }
    
    func endFooterRefresh(){
        footerView?.endFooterRefrsh()
    }
    
    func noticeNoMoreData(){
        footerView?.footerNoMoreData()
    }
    
    func resetNoMoreData(){
        footerView?.footerResetMoreData()
    }
    
}
