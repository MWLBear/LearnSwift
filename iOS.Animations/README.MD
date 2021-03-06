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

##### Transitions 
`transition(with:duration: options:animations:completion:)`

- .transitionFlipFromLeft
- .transitionFlipFromRight
- .transitionCurlUp
- .transitionCurlDown
- .transitionCrossDissolve 
-  .transitionFlipFromTop
- .transitionFlipFromBottom

##### Keyframe animations 
- `addKeyframe（withRelativeStartTime：relativeDuration：animations :)`是您第一次在本书的动画中使用相对时长。 关键帧的开始时间及其持续时间用相对于动画整个持续时间的百分比表示。 例如，0.1将是总持续时间的10％，0.25将是25％，而1.0将是总持续时间的100％。

##### Auto Layout

## Layer Animations
`Views`:

- 复杂的视图层次结构布局，自动布局等。
- 用户交互。
- 通常具有在CPU的主线程上执行的自定义逻辑或自定义图形代码。
- 非常灵活，功能强大，有很多子类可以继承。

`Layers`:

- 更简单的层次结构，更快的布局解析速度，更快的绘制速度。
- 没有响应者链开销。
- 默认情况下没有自定义逻辑。并直接在GPU上绘制。
- 不够灵活，可以减少子类的类。

##### Animatable properties

- `Position and size`
	- `bounds`: 修改此项以使图层的边界框动起来。
	- `position`: 修改此位置以使该图层在其父图层中的位置具有动画效果。如果只想控制一个轴的运动，则可以分别为position.x或position.y设置动画
	- `transform`: 修改此选项可移动，缩放和旋转图层。您甚至可以为3D空间中的图层设置动画，这是单独使用视图无法做到的
- `Border`
	- `borderColor`: 修改此项以更改边界色调。
	- `borderWidth`: 修改此项以增加或缩小边框的宽度
	- `cornerRadius`: 修改此项以更改图层圆角的半径。
- Shadow
	- `shadowOffset`: 修改此选项可使阴影看起来更靠近或远离图层。
	- `shadowOpacity: 修改此项以使阴影淡入或淡出
	- `shadowPath`: 改此选项可更改图层阴影的形状。您可以创建不同的3D效果，以使图层看起来像在浮动时具有不同的阴影形状和位置。
	- `shadowRadius`: 修改此项以控制阴影的模糊；当模拟视图朝向或远离投射阴影的表面的运动时，此功能特别有用
- `Contents`
	- `contents`: 修改此内容以将原始TIFF或PNG数据分配为图层内容。
	- `mask`: 修改此选项可建立用于遮罩图层可见内容的形状或图像；
	- `opacity`: 修改此项以设置图层内容的透明度

`CABasicAnimation`的一个实例描述了一种潜在的图层动画：您可以选择立即运行，稍后运行或根本不运行。 由于动画没有绑定到特定的图层，因此您可以在其他图层上重复使用该动画，并且每个图层将独立运行该动画的副本
`add（_：forKey :)`复制动画对象，并告诉Core Animation在图层上运行它。

- CABasicAnimation对象只是一个数据模型，未绑定到任何特定层。
- add（_：forKey :)复制动画对象。
- fillMode:控制动画序列的开头和结尾的行为。
	-  `CAMediaTimingFillMode.removed`是fillMode的默认值。这会在定义的beginTime时（或未设置beginTime的情况下）立即启动动画，并在动画完成时删除在动画过程中所做的更改：
	-  backwards:无论动画的实际开始时间如何，CAMediaTimingFillMode.backwards都会在屏幕上立即显示动画的第一帧，并在以后的时间开始动画。
	-  forwards:CAMediaTimingFillMode.forwards会照常播放动画，但会在屏幕上保留动画的最后一帧，直到您删除动画为止：
	-  both:CAMediaTimingFillMode.both是向前和向后的组合； 如您所愿，这会使动画的第一帧立即显示在屏幕上，并在动画结束时将最后一帧保留在屏幕上：

##### CAAnimationGroup
CAMediaTimingFunction

- `.linear`在整个动画过程中以相等的速度运行动画。 
- `.easeIn`更改动画，使其开始较慢，并以较快的速度结束。
- `.easeOut`产生与.easeIn相反的效果：动画开始时较快，结束时则变慢。
- `.easeInEaseOut`在开始和结束时减慢动画的速度，但在中间部分增加速度。

##### CASpringAnimation

- `damping`：应用于系统的阻尼
- `mass`：系统中重量的质量
- `stiffness`：附加到配重的弹簧的刚度
- `initialVelocity`：施加到配重的初始推力。

##### CAKeyframeAnimation
Animating struct values

- 您可以使用CAKeyframeAnimation类轻松创建图层关键帧动画。
- 与视图不同，图层关键帧动画在多个可能的关键点上以连续动画的形式对单个属性进行动画处理。
- 您可以通过将复杂的属性数据类型包装为NSValue类型来制作动画。

##### CAShapeLayer

- path：将图层的形状变形为其他形状。
- fillColor：将形状的填充色调更改为其他颜色。
- lineDashPhase：在形状周围创建选取框或“行进蚂蚁”效果。
- lineWidth：增大或缩小形状的描边线的大小。

##### Gradient Animations

`Animatable properties`:

- colors：对渐变的颜色进行动画处理以使其具有色调。
- locations：对颜色里程碑位置进行动画处理以使颜色移动
在渐变内部。
- startPoint和endPoint：对渐变的布局范围进行动画处理。

##### Stroke & Path Animations
- `strokeStart` 把一个圆先画完，然后 再慢慢减少
- `strokeEnd` 从原点开始画，然后把圆画完整
- 您可以通过动画CAShapeLayer的strokeStart和strokeEnd属性来动画化在屏幕上绘制形状的整个过程。
- 您可以通过使用关键帧动画并使用给定的CGPath动画化该图层的position属性，从而在屏幕上沿路径设置动画。

##### Replicating Animations
`CAReplicatorLayer`:

- `instanceCount`：设置所需的副本数
- `instanceTransform`：设置要在副本之间应用的变换
- `instanceDelay`：设置副本之间的动画延迟

CAReplicator图层特有的可设置动画的属性包括以下内容:

- `instanceDelay`：对实例之间的延迟量进行动画处理
- `instanceTransform`：动态更改复制之间的转换
- `instanceColor`：更改用于所有实例的混合颜色
- `instanceRedOffse`，`instanceGreenOffset`，`instanceBlueOffset`：应用增量以应用于每个实例颜色分量
- `instanceAlphaOffset`：更改应用于每个实例的不透明度增量


## Layer Presentation Controller & Orientation Animations


过渡上下文对象有两个非常方便的方法，可让您访问过渡播放器：

- view（forKey :)：这使您可以分别通过参数UITransitionContextViewKeyKey.from或UITransitionContextViewKey.to访问“旧”和“新”视图控制器的视图。
- viewController（forKey :)：这使您可以分别通过参数UITransitionContextViewControllerKey.from或UITransitionContextViewControllerKey.to访问“旧”和“新”视图控制器。

##### UINavigationController Custom Transition Animations

- 要启用和自定义自定义导航过渡，您可以在其中一种类型中采用UINavigationControllerDelegate协议，并使其成为导航委托。
- 要执行任何自定义导航过渡动画，请采用UIViewControllerAnimatedTransitioning协议作为过渡的动画制作者。
- 只要正确包装过渡并最后调用必要的UIKit方法，就可以成功地将图层动画用于自定义过渡。
- 要保留导航过渡的上下文并在整个过渡期间进行异步访问，可以将其保留在动画师类型的UIViewControllerContextTransitioning属性中。


- 通过在过渡动画制作器中采用UIPercentDrivenInteractiveTransition协议，可以轻松地向自定义过渡添加交互性。
- 交互式过渡通常由用户手势驱动。 UIPanGestureRecognizer是一种方便的类，可为您提供连续的手势反馈。
- 您可以通过在UIPercentDrivenInteractiveTransition上设置Interactive属性的值来在交互式和非交互式转换模式之间切换。

## Animations with UIViewPropertyAnimator
- 使用UIViewPropertyAnimator类型时，可以创建一个对象，向其添加动画和/或完成闭包，并在方便时启动动画。
- 在类实例中包含动画闭包为通过动画工厂重用动画提供了全新的方法。
- 要创建视图关键帧动画，您仍然需要使用旧的api UIView.animateKeyframes（withDuration：delay：keyframes :)。
- 使用UIViewPropertyAnimator，可以为UIBlurEffect值设置动画并创建令人印象深刻的模糊动画。
- 您可以使用UIViewPropertyAnimator的两个控制点自定义Bézier曲线来创建自己的自定义动画定时，并远离预定义的缓动常数。

- 最后但并非最不重要的一点是，您可以将预定义的UIKit过渡API（如UIView.transition（with：duration：options：animations：completion））与其他UIViewPropertyAnimator动画混合使用，它们将“一起工作”。



UIPercentDrivenInteractiveTransition 是一个定义基于“百分比”的转换方法的类，例如：

- update(_:) 倒带过渡。
- cancel() 取消视图控制器转换。
- finish() 播放过渡直到它完成。
- timingCurve：如果您的用户以交互方式驱动过渡并在您需要播放过渡到结束时放手，您可以通过设置此属性为动画提供自定义时间曲线。这可以是三次、弹簧或其他自定义计时提供程序。
- WantInteractiveStart：默认情况下这是真的，因为您可能主要将这个类用于交互式过渡。但是，如果您将该属性设置为 false，过渡将以非交互方式开始，您可以暂停它并稍后进入交互模式。
- pause()：调用此方法可暂停非交互式转换并切换到交互式模式。