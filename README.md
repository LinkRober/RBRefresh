# RBRefresh

###  Introduction
> 重造一个刷新的轮子，出于正在学习Swift，新项目也是用swift写的，以前oc的刷新用起来不开森，同时也处于练练手的目的

### Install
` pod 'RBRefresh'`
#### support swift3.0
### Example

**RBNormalHeader**<br />
![](https://github.com/LinkRober/RBRefresh/blob/master/images/RBRefresh1.gif)<br />
>**RBGifHeader**<br />

![](https://github.com/LinkRober/RBRefresh/blob/master/images/RBRefresh2.gif)<br />
**RBBallRoateChaseHeader**<br />
![](https://github.com/LinkRober/RBRefresh/blob/master/images/RBRefresh3.gif)<br />
**RBBallClipRoateHeader**<br />
![](https://github.com/LinkRober/RBRefresh/blob/master/images/RBRefresh4.gif)<br />
**RBBallScaleHeader**<br />
![](https://github.com/LinkRober/RBRefresh/blob/master/images/RBRefresh5.gif)<br />

###  How to use
>所有自定义的header和footer，需要遵循 `PullDownToRefreshViewDelegate` `PullUpToRefreshViewDelegate`，并且时UIView的范型。
>在使用的时候只需要把它们作为入参传入`animator`如下
>header和footer的frame只需要传高度的参数即可

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

