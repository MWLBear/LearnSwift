

import UIKit

@IBDesignable final class DJControllerView: UIControl {
  // MARK: - Properties
  private lazy var view = instantiateNib(view: self)
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    addSubview(view)
    view.fillSuperview(self)
  }
  
  // MARK: - Interface Builder
  //在将视图加载到Interface Builder中之后，您将注入代码以在Interface Builder中添加描述自定义视图的标签。
  override func prepareForInterfaceBuilder() {
    superview?.prepareForInterfaceBuilder()
    addLabelDescribing(view: self, insideSuperview: view)
  }
}
