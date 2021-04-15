//
//  LandscapeViewController.swift
//  StoreSearch
//
//  Created by admin on 2021/4/13.
//

import UIKit

class LandscapeViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollview: UIScrollView!
    var search: Search!
    private var firstTime = true
    private var downloads = [URLSessionDownloadTask]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.removeConstraints(view.constraints)
        view.translatesAutoresizingMaskIntoConstraints = true
        //This allows you to position and size your views manually by changing their frame property.
        pageControl.removeConstraints(pageControl.constraints)
        pageControl.translatesAutoresizingMaskIntoConstraints = true
        scrollview.removeConstraints(scrollview.constraints)
        scrollview.translatesAutoresizingMaskIntoConstraints = true
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "LandscapeBackground")!)
    
        pageControl.numberOfPages = 0
        scrollview.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let safeFrame = view.safeAreaLayoutGuide.layoutFrame
        scrollview.frame = safeFrame
        pageControl.frame = CGRect(x: safeFrame.origin.x,
                                   y: safeFrame.size.height - pageControl.frame.size.height,
                                   width: safeFrame.size.width,
                                   height: pageControl.frame.size.height)
        if firstTime {
            firstTime = false
            switch search.state {
            case .notSearchedYet:
                break
            case .loading:
                showSpinner()
                break
            case .noResults:
                showNothingFoundLabel()
                break
            case .results(let list):
                tileButtons(list)
            }
        }
    }
    private func tileButtons(_ seachResults:[SearchResult]) {
        var columnsPerPage = 6
        var rowsPerPage = 3
        var itemWidth: CGFloat = 94
        var itemHeight: CGFloat = 88
        var marginX: CGFloat = 2
        var marginY: CGFloat = 20
        
        let viewWidth = scrollview.bounds.size.width
        switch viewWidth {
        case 568:
            break
        case 667:
            // 4.7-inch device
            columnsPerPage = 7
            itemWidth = 95
            itemHeight = 98
            marginX = 1
            marginY = 29
        case 736:
            //5.5
            columnsPerPage = 8
            rowsPerPage = 4
            itemWidth = 92
            marginX = 0
        case 724:
            //iPhone X
            columnsPerPage = 8
            rowsPerPage = 3
            itemWidth = 90
            itemHeight = 98
            marginX = 2
            marginY = 29
            
        default:
            break
        }
        //Button size
        let buttonWidth:CGFloat = 82
        let buttonHeight:CGFloat = 82
        let paddingHorz = (itemWidth - buttonWidth)
        let paddingVert = (itemHeight - buttonHeight)
        
        var row = 0
        var column = 0
        var x = marginX
        for (index, result) in seachResults.enumerated() {
            // 1
            let button = UIButton(type: .custom)
            button.tag = 2000 + index
            button.addTarget(self, action: #selector(buttonPressed),for: .touchUpInside)
            downloadImage(for: result, andPlaceOn: button)
            button.frame = CGRect(x: x + paddingHorz,
                                  y: marginY + CGFloat(row)*itemHeight + paddingVert,
                                  width: buttonWidth, height: buttonHeight)
            // 3
            scrollview.addSubview(button)
            // 4
            row += 1
            if row == rowsPerPage {
                row = 0; x += itemWidth; column += 1
                if column == columnsPerPage {
                    column = 0; x += marginX * 2
                }
            }
            
        }
        
        // Set scroll view content size
        let buttonsPerPage = columnsPerPage * rowsPerPage
        let numPages = 1 + (seachResults.count - 1) / buttonsPerPage
        scrollview.contentSize = CGSize(width: CGFloat(numPages) * viewWidth, height: scrollview.bounds.size.height)
        print("Number of pages: \(numPages)")
        pageControl.numberOfPages = numPages
        pageControl.currentPage = 0
    }
    // MARK:- Private Methods

    private func downloadImage(for searchResult: SearchResult,andPlaceOn button: UIButton?) {
        if let url = URL(string: searchResult.imageSmall) {
            let task = URLSession.shared.downloadTask(with: url) { [weak button] url, respones, error in
                if error == nil,let url = url,
                   let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        if let button = button {
                            button.setImage(image, for: .normal)
                        }
                    }
                }
                
            }
            task.resume()
            downloads.append(task)
        }
        
    }
    
    private func showSpinner(){
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = CGPoint(x: scrollview.bounds.midX + 0.5 , y: scrollview.bounds.midY + 0.5)
        spinner.tag = 1000
        view.addSubview(spinner)
        spinner.startAnimating()
    }
    
    private func hideSpinner(){
        view.viewWithTag(1000)?.removeFromSuperview()
    }
    
    private func showNothingFoundLabel() {
        let label = UILabel(frame: CGRect.zero)
        label.text = NSLocalizedString("Nothing Found", comment: "Search results: Nothing Found")
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.clear
        label.sizeToFit()
        var rect = label.frame
        rect.size.width = ceil(rect.size.width/2) * 2
        rect.size.height = ceil(rect.size.height/2) * 2 // make even label.frame = rect
        label.center = CGPoint(x: scrollview.bounds.midX, y: scrollview.bounds.midY)
        view.addSubview(label)
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowDetail", sender: sender)
   }
    // MARK:- Public Methods
    func searchResultReceived() {
        hideSpinner()
        switch search.state {
        case .noResults:
            showNothingFoundLabel()
        case .notSearchedYet,.loading:
            break
        case .results(let list):
            tileButtons(list)
        }
    }
    
    // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if case .results(let list) = search.state {
                let detailViewController = segue.destination as! DetailViewController
                let searchResult = list[(sender as! UIButton).tag - 2000]
                detailViewController.searchResult = searchResult
                detailViewController.ispop_up = true
            }
        }
    }
    
    deinit {
        print("deinit: \(self)")
        for task in downloads {
            task.cancel()
        }
    }
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [.curveEaseInOut],
                       animations: {
                        self.scrollview.contentOffset = CGPoint(x: self.scrollview.bounds.size.width * CGFloat(sender.currentPage), y: 0)},
                       completion: nil)
    }
}
extension LandscapeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollview.bounds.size.width
        let page = Int((scrollview.contentOffset.x + width/2)/width)
        pageControl.currentPage = page
        
    }
}
