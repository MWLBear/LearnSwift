
import UIKit
import QuartzCore

// MARK: Refresh View Delegate Protocol
protocol RefreshViewDelegate: class {
    func refreshViewDidRefresh(_ refreshView: RefreshView)
}

// MARK: Refresh View
class RefreshView: UIView, UIScrollViewDelegate {
    
    weak var delegate: RefreshViewDelegate?
    var scrollView: UIScrollView
    var refreshing: Bool = false
    var progress: CGFloat = 0.0
    
    var isRefreshing = false
    
    let ovalShapeLayer: CAShapeLayer = CAShapeLayer()
    let airplaneLayer: CALayer = CALayer()
    
    init(frame: CGRect, scrollView: UIScrollView) {
        self.scrollView = scrollView
        
        super.init(frame: frame)
        
        //add the background image
        let imgView = UIImageView(image: UIImage(named: "refresh-view-bg.png"))
        imgView.frame = bounds
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        addSubview(imgView)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Scroll View Delegate methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll")
        print(scrollView.contentInset.top)
        print("================ \(scrollView.contentOffset.y)")
        
        let offsetY = max(-(scrollView.contentOffset.y + scrollView.contentInset.top), 0.0)
        progress = min(max(offsetY / frame.size.height, 0.0), 1.0)
        
        if !isRefreshing {
            redrawFromProgress(self.progress)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("scrollViewWillEndDragging")
        if !isRefreshing && self.progress >= 1.0 {
            delegate?.refreshViewDidRefresh(self)
            beginRefreshing()
        }
    }
    
    // MARK: animate the Refresh View
    
    func beginRefreshing() {
        isRefreshing = true
        
        UIView.animate(withDuration: 0.3) {
            var newInsets = self.scrollView.contentInset
            newInsets.top += self.frame.size.height
            self.scrollView.contentInset = newInsets
        }
        
    }
    
    func endRefreshing() {
        
        isRefreshing = false
        
        UIView.animate(withDuration: 0.3, delay:0.0, options: .curveEaseOut,
                       animations: {
                        var newInsets = self.scrollView.contentInset
                        newInsets.top -= self.frame.size.height
                        self.scrollView.contentInset = newInsets
                       },
                       completion: {_ in
                        //finished
                       }
        )
    }
    
    func redrawFromProgress(_ progress: CGFloat) {
        
    }
    
}
