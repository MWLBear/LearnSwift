- Attributes
属性是“自动版式”用于在两个视图之间创建关系的视图功能。 有两种类型的属性：位置和大小。 位置属性包括视图的前缘，后缘，顶部和底部边缘。 大小属性包括视图的宽度和高度。 不同的用户界面具有不同的属性集。
- Multiplier
乘数是您可以应用于两个项目属性之间的关系的比率。 例如，您可以使标签B的高度是标签A高度的两倍。
- Constant
常数是您添加到约束中的固定值。 例如，标签A的前缘空间与超级视图的前缘相距16点。
- Priorities
有时，“自动布局”无法满足视图层次结构中应用的所有约束。在这种情况下，您可能会遇到视图争夺空间的情况。使用优先级，可以帮助自动布局解决这些布局决策。
- Constraint priority
约束优先级是关于哪个约束对自动版式更重要的是要满足。使用1到1000之间的值定义约束优先级。不需要使用1到999之间的约束优先级。要求约束优先级为1000。添加约束时，默认约束优先级为1000，这是必需的。
- Content hugging priorities
内容包含优先级可以帮助“自动布局”确定将哪个视图拉伸得大于其固有尺寸。每个视图都有一个包含优先级的水平和垂直内容。具有较高内容优先级的视图可以避免被拉伸，反之亦然。
在两个视图之间进行选择并确定要拉伸的视图时，布局引擎会调查包含优先级的内容。具有较低内容的视图具有优先级。视图的默认内容包含优先级因其类型和实例化视图的方式而异。使用Interface Builder和以编程方式实例化视图时，默认内容包含优先级可能会有所不同。

- Compression resistance priorities
压缩抗性优先级可帮助“自动版面配置”确定缩小的视图小于其固有尺寸。每个视图还具有水平和垂直压缩阻力优先级。具有较高抗压缩性优先级的视图可避免收缩，反之亦然。
每个视图都有默认的750水平和垂直压缩阻力优先级。与内容包含优先级不同，所有视图对象都具有相同的默认抗压缩性优先级，而与视图类型或实例化方法无关。在两个视图之间进行选择并决定缩小视图时，布局引擎会考虑抗压缩优先级。具有较低含量抗压缩优先级的视图缩小。


#### Stack View
###### `Alignment`控制着垂直于轴的视图布局,`Distribution`控制视图平行于轴的布局。

- Alignment 
	-  horizontal stack view
		-  `fill` alignment makes the views take up all of the vertical space inside the stack view.在每种情况下，最高视图的高度决定了堆栈视图的高度。并且由于对齐方式已填充，因此堆栈视图中的每个其他视图都与该高度匹配。
		-  Horizontal axis top, bottom and center alignments
		-  Horizontal axis first baseline and last baseline alignments
	-  Vertical axis alignments
		- leading, trailing, fill and center.
- distribution
	-  Fill: 调整子视图的大小以填充沿轴的所有空间，但是一个视图的大小可能与其他视图不同。
	-  Fill Equally:调整子视图的大小以填充沿轴的所有空间，但使每个子视图具有相同的大小。
	-  Fill Proportionally: 调整子视图的大小以填充沿轴的所有空间，但按其固有尺寸成比例地调整每个子视图的大小。
	-  Equal Spacing:根据子视图的固有大小或其他约束来调整子视图的大小，但要对其进行定位，以使每个子视图之间的间隔相等，并且至少要具有堆栈视图的Spacing属性。
	-  Equal Centering: 根据子视图的内在大小或其他约束来调整子视图的大小，但要放置它们，以使每个中心之间的距离相等。
