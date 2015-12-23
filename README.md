# foldView
一个简单的 cell展开折叠动画 不过运用在TableView有些bug...不过没时间去研究...只是提供思路参考
大致思路就是 cell展开的瞬间 将要显示的部分截取成image形式 并拆分成上下2张, 也可以拆分成 2n张
然后利用旋转动画实现类似的效果效果就行 动画完成的时候 需要移除图片layer

![image](https://github.com/h5865885/foldView/blob/master/%E6%8A%98%E5%8F%A0.gif?raw=true)  
