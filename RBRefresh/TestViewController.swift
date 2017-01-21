//
//  TestViewController.swift
//  RBRefresh
//
//  Created by 夏敏 on 20/01/2017.
//  Copyright © 2017 夏敏. All rights reserved.
//

import UIKit

class TestViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    lazy var tableview:UITableView = {
        let tableview = UITableView.init(frame: CGRect(x:0,y:0,width:self.view.frame.size.width,height:self.view.frame.size.height - 64), style: .plain)
        return tableview
    }()
    var type:Type = .Normal
    var datasource = [1,2,3,4,5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.tableview.delegate = self
        self.tableview.dataSource = self
        view.addSubview(self.tableview)
        
        if type == .Normal {
            self.tableview.rb_addHeaderRefreshBlock({
                DispatchQueue.main.asyncAfter(deadline:.now() + 1) {
                    self.datasource.removeAll()
                    self.tableview.reloadData()
                    for _ in 0 ..< 10 {
                        self.datasource.append(self.randNumber())
                    }
                    self.tableview.rb_resetNoMoreData()
                    self.tableview.rb_endHeaderRefresh()
                    self.tableview.reloadData()
                }
            }, animator:RBNormalHeader.init(frame: CGRect(x:0,y:0,width:0,height:50)))
        }else {
            self.tableview.rb_addHeaderRefreshBlock({
                DispatchQueue.main.asyncAfter(deadline:.now() + 1) {
                    self.datasource.removeAll()
                    self.tableview.reloadData()
                    for _ in 0 ..< 10 {
                        self.datasource.append(self.randNumber())
                    }
                    self.tableview.rb_resetNoMoreData()
                    self.tableview.rb_endHeaderRefresh()
                    self.tableview.reloadData()
                }
            }, animator:RBGifHeader.init(frame: CGRect(x:0,y:0,width:0,height:80)))
        }
        
        
        
        
        
        self.tableview.rb_addFooterRefreshBlock({
            OperationQueue().addOperation {
                sleep(1)
                OperationQueue.main.addOperation {
                    self.tableview.rb_endFooterRefresh()
                    self.datasource.append(contentsOf: [24,25].map({ (n:Int) -> Int in
                        return self.randNumber()
                    }))
                    self.tableview.reloadData()
                }
            }
        }, animator: RBNormalFooter.init(frame: CGRect(x:0,y:0,width:0,height:50)))
        
//        self.tableview.beginHeaderRefresh()
        
    }
    
    
    func randNumber() -> Int {
        return Int(arc4random_uniform(100))
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "")
        cell.textLabel?.text = "\(datasource[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    

}
