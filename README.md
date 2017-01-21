# RBRefresh

###How to use

####pod 'RBRefresh'
#### support swift3.0

```
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
```
```
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

```

