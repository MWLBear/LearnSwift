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

##### Adding view transitions

使用`transition(_)`修饰符向视图添加过渡效果,`transition（_）`修饰符采用类型为AnyTransition的参数，`which is a type erased transition`

- `AnyTransition.opacity`：交叉淡入淡出效果，可以淡入或淡出视图。
- `AnyTransition.slide`：一种过渡，在添加时在视图中从左侧滑动，在移除时在视图中向右侧滑动。
- `AnyTransition.move（edge :)`：创建一个过渡，将视图移入和移出屏幕给定的边缘。
- `AnyTransition.offset（_）`：创建一个将视图移动给定偏移量的过渡。
- `AnyTransition.scale（scale：anchor :)`：创建一个用于放大或缩小视图的过渡。

##### Interactive animations
使用`gesture(_)`修饰符，可以通过实例化DragGesture将新手势添加到视图中

## View Animations

##### Animatable properties
- `Position and size` (位置和大小)
	- `bounds`：设置此属性的动画以在视图框架内重新放置视图内容。
	- `frame`：对此属性设置动画以移动和/或缩放视图。
	- `center`：当您要将视图移动到新位置时，对此属性进行动画处理在屏幕上。

- `Appearance`
	- `backgroundColor`：更改视图的此属性，以使UIKit随时间逐渐改变背景色。
	- `alpha`：更改此属性以创建淡入和淡出效果。
- Transformation
	- `transform`：在动画块中修改此属性，以动画化视图的旋转，缩放和/或位置。
	
----
```
   UIView.animate(withDuration: 0.5, delay: 0.4, options: [], animations: {
            self.password.center.x += self.view.bounds.width
        }, completion: nil)

```
- `withDuration`：动画的持续时间。
- `delay`：UIKit在开始动画之前将等待的秒数。
- `options`：使您可以自定义有关动画的许多方面。 稍后您将了解有关此参数的更多信息，但现在您可以传递一个空数组[]表示“无特殊选项”。
	- `repeat`：包括此选项以使动画永久循环。
   - `autoreverse`：仅与.repeat一起包括此选项； 此选项会反复向前播放动画，然后反向播放。
   - Animation easing
     - curveLinear：此选项不对动画应用加速或减速。 
     - curveEaseIn：此选项将加速应用于动画的开始。
	  - curveEaseOut：此选项将减速应用于动画的结尾。
	  - curveEaseInOut：此选项将加速度应用于动画的开始，并将减速度应用于动画的结束。
- `animations`：用于提供动画的闭包表达式。
- `completion`：动画结束时执行的代码关闭。 当您要执行一些最终的清理任务或一个接一个地链接动画时，此参数通常会派上用场。

----

```
animate（withDuration：delay：usingSpringWithDamping：initialSpringVeloci ty：options：animations：completion :)

```
- usingSpringWithDamping：控制在动画接近其最终状态时应用于动画的阻尼或减少量。此参数接受介于0.0和1.0之间的值。接近0.0的值将创建更生动的动画，而接近1.0的值将创建僵硬的效果。您可以将此值视为弹簧的“刚度”。
- initialSpringVelocity：控制动画的初始速度。值1.0设置动画的初始速度以覆盖一秒跨度内的总距离。较大和较小的值将导致动画具有或多或少的速度，并会影响弹簧的沉降方式。但是请注意，弹簧计算会很快修改初始速度，并且动画将始终在持续时间结束之前结束。

----




























