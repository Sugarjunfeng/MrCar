# MrCar
##1.该项目用到了自己修改过后的SugarLeftMenu库，效果如下。

![侧边栏](https://github.com/Sugarjunfeng/MrCar/blob/master/Mr.Car/picture/Demo.gif)

##2.我自定义了一个class，叫做LineLayout，继承自UICollectionFlowLayout。直接在UICollectionViewController中引入，并且初始化，自定义UICollectionCell之后，显示效果如下。有点类似iOS 9的多任务视图，这个效果在模拟器上测试，目前只支持iPhone 5S，iPhone 6，iPhone6S，因为使用的是代码布局，但是没有用到Masonry布局，直接利用＃define获取了当前屏幕的宽和高，所以其他设备可能会有出入。后续我会做出修改。

![效果](https://github.com/Sugarjunfeng/MrCar/blob/master/Mr.Car/picture/sliding.gif)


##3.还加入了Bugtags的SDK，用了一下，感觉不错，对于中小型项目会比较方便。
