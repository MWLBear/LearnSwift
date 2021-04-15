//
//  ViewController.swift
//  StoreSearch
//
//  Created by admin on 2021/4/12.
//

import UIKit

struct TableView {
    struct CellIdentifiers {
        static let searchResultCell = "SearchResultCell"
        static let nothingFoundCell = "NothingFoundCell"
        static let loadingCell = "LoadingCell"
    }
}
class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    private let search = Search()
    var landscapeVC: LandscapeViewController?
    weak var splitViewDetail: DetailViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 108, left: 0, bottom: 0, right: 0)
        var cellNib = UINib(nibName: TableView.CellIdentifiers.searchResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.searchResultCell)
        cellNib = UINib(nibName: TableView.CellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.nothingFoundCell)
        cellNib = UINib(nibName: TableView.CellIdentifiers.loadingCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.loadingCell)
        
        
        let segmentColor = UIColor(red: 10/255, green: 80/255, blue: 80/255, alpha: 1)
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        let normalTextAttributes = [NSAttributedString.Key.foregroundColor:segmentColor]
        segmentedControl.selectedSegmentTintColor = segmentColor
        segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .highlighted)
        title = NSLocalizedString("Search", comment: "split view master button")
        if UIDevice.current.userInterfaceIdiom != .pad {
            searchBar.becomeFirstResponder()
        }
    }
    //MARK:- IPAD
    private func hideMasterPane() {
        UIView.animate(withDuration: 0.25) {
            self.splitViewController!.preferredDisplayMode = .primaryHidden
        } completion: { _ in
            self.splitViewController!.preferredDisplayMode = .automatic
        }

    }
    
    //MARK:- Helper Methods
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        performSearch()
    }
    
    
    func showNetError() {
        let alert = UIAlertController(title: NSLocalizedString("Whoops...", comment: "Network error Alert title"), message: NSLocalizedString("There was an error accessing the iTunes Store. Please try again.", comment: "Network error message"), preferredStyle: .alert)
        
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button title"), style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: false, completion: nil)
    }
    
    func performSearch(){
        if let category = Search.Category(rawValue: segmentedControl.selectedSegmentIndex) {
            search.performSearch(for: searchBar.text!,category: category) { sucess in
                if !sucess {
                    self.showNetError()
                }else {
                    self.tableView.reloadData()
                    self.landscapeVC?.searchResultReceived()
                }
            }
        }
        
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    // MARK:- Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            
            if case .results(let list) = search.state {
                let controller = segue.destination as! DetailViewController
                controller.ispop_up = true
                let indePath = sender as! IndexPath
                let searchResult = list[indePath.row]
                controller.searchResult = searchResult
            }
         
        }
    }
    
    //MARK:- device rotation
    //The wC and hR are the size class for this particular device: The size class for the width is compact (wC), and the size class for the height is regular (hR).
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        let rect = UIScreen.main.bounds
        if  (rect.width == 736 && rect.height == 414) || // portrait
                (rect.width == 414 && rect.height == 736) {// landscape
            if presentedViewController != nil {
                dismiss(animated: true, completion: nil)
            }
        }else if UIDevice.current.userInterfaceIdiom != .pad {
            switch newCollection.verticalSizeClass {
            case .compact: //紧凑
                showLandscape(with: coordinator)
            case .regular,.unspecified: //常规
                hideLandscape(with: coordinator)
            @unknown default:
               fatalError()
            }
        }
    }
    
    func showLandscape(with coordinator: UIViewControllerTransitionCoordinator) {
        guard landscapeVC == nil else { return }
        landscapeVC = storyboard!.instantiateViewController(identifier: "LandscapeViewController") as? LandscapeViewController
        if let controller = landscapeVC {
            controller.search = search
            controller.view.frame = view.bounds
            controller.view.alpha = 0
            view.addSubview(controller.view)
            addChild(controller)
            coordinator.animate { _ in
                controller.view.alpha = 1
                self.searchBar.resignFirstResponder()
                
                if self.presentedViewController != nil{
                    self.dismiss(animated: true, completion: nil)
                }
                
            } completion: { _ in
                controller.didMove(toParent: self)
            }
        }
        
        
    }
    func hideLandscape(with coordinator: UIViewControllerTransitionCoordinator) {
        if let controller = landscapeVC {
            controller.willMove(toParent: nil)
            coordinator.animate { _ in
                controller.view.alpha = 0
                if self.presentedViewController != nil {
                    self.dismiss(animated: true, completion: nil)
                }
            } completion: { _ in
                controller.view.removeFromSuperview()
                controller.removeFromParent()
                self.landscapeVC = nil
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch()
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension SearchViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch search.state {
        case .notSearchedYet: return 0
        case .loading: return 1
        case .noResults: return 1
        case .results(let list): return list.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch search.state {
        case .notSearchedYet:
            fatalError("Should never get here")
            
        case .loading :
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.loadingCell,for: indexPath)
            let spinner = cell.viewWithTag(100) as! UIActivityIndicatorView
            spinner.startAnimating()
            return cell
            
        case .noResults :
            return tableView.dequeueReusableCell(withIdentifier:TableView.CellIdentifiers.nothingFoundCell,for: indexPath)
            
        case .results(let list):
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.searchResultCell, for: indexPath) as! SearchResultCell
            let searchResult = list[indexPath.row]
            cell.configure(for: searchResult)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        if view.window!.rootViewController!.traitCollection.horizontalSizeClass == .compact {
            tableView.deselectRow(at: indexPath, animated: true)
            performSegue(withIdentifier: "ShowDetail", sender: indexPath)
        }else {
            if case .results(let list) = search.state {
                splitViewDetail?.searchResult = list[indexPath.row]
                if splitViewController!.displayMode != .allVisible {
                    hideMasterPane()
                }
            }
        }
        
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        switch search.state {
        case .notSearchedYet ,.loading,.noResults:
            return nil
        case .results:
            return indexPath
        }
    }

}
