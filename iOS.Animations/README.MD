## SwiftUI Animations
##### The Animation type
- `Animation.easeIn（duration :)`：一种产生基本动画的方法，该动画具有缓入的时序曲线和给定的持续时间。其他预设时序曲线也有一些变体`.easeOut`，`.easeInOut`和`linear`。省略持续时间将为您提供默认的持续时间0.35秒。 `.default`是一个基本动画，持续时间为0.35秒，并具有缓进缓出的时序曲线。
- `Animation.interpolatingSpring（mass：stiffness：damping：initialVelocity）`：此方法创建一个弹簧驱动的动画，该动画在视图的先前状态和当前状态之间进行插值，但根据其参数，可能会超出其最终值以产生“弹性”动画。	
- `Animation.spring（response：dampingFraction：blendDuration :)`：一种创建不同类型的弹簧驱动动画的方法，该动画具有不同的配置，允许您创建更多的“流体”效果。
创建动画实例后，可以使用以下修饰符来进一步更改动画：
	- `delay（_）`：在动画开始之前添加特定时间的延迟。
	- `repeatCount（_：autoreverses :)`：将动画配置为重复给定次数。如果设置了autoreverses，它将向前和向后播放效果，而不是在每次重复时重新启动动画。
	- `repeatsForever（autoreverses :)`：与上面一样，此修改器使动画重复，但它会无限期重复，而不是重复给定次数。
	- `speed（_）`：允许您加快或减慢动画。

- `saturation(_)` 修改当前视图的颜色饱和度。
- `offset(x:y:)`: Offset this view by the specified horizontal and vertical distances.


