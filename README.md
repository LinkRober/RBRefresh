# RBRefresh

###  Introduction

#### pod 'RBRefresh'
#### support swift3.0
#### Example

![](https://github.com/LinkRober/RBRefresh/blob/master/images/RBRefresh.gif)

###  How to use
>所有自定义的header和footer，需要遵循 `PullDownToRefreshViewDelegate` `PullUpToRefreshViewDelegate`，并且时UIView的范型。
>在使用的时候只需要把它们作为入参传入`animator`如下
>header和footer的高度和你传入的入参一样，其他位置参数可以随便写

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

