//
//  RXTableView0Controller.swift
//  LearnSwift
//
//  Created by admin on 2020/9/9.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

/**
 不同类型的单元格混用
 
 样式修改
 
 */
class RXTableView0Controller: UIViewController {

    @IBOutlet weak var tabview: UITableView!
    
    var dataSource:RxTableViewSectionedReloadDataSource<MySection_>?
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let sections = Observable.just([
            MySection_(header: "我是第一个分区", items: [
                .TitleImageSectionItem(title: "image1", image: UIImage(named: "swift")!),
                .TitleImageSectionItem(title: "image2", image: UIImage(named: "react")!),
                .TitleSwitchSectionItem(title: "switch1", enabled: true)
            ]),
            MySection_(header: "我是第二个分区", items: [
                .TitleSwitchSectionItem(title: "switch2", enabled: false),
                .TitleImageSectionItem(title: "image3", image: UIImage(named: "php")!),
                .TitleSwitchSectionItem(title: "switch3", enabled: true)
            ])
        ])
        
        let datasource = RxTableViewSectionedReloadDataSource<MySection_>(
            configureCell: { datasource, tableview, index, item  in
                switch datasource[index]{
                case let .TitleImageSectionItem(title: title, image: image):
                    let cell = tableview.dequeueReusableCell(withIdentifier: "titleImageCell", for: index)
                    (cell.viewWithTag(1) as! UILabel).text = title
                    (cell.viewWithTag(2) as! UIImageView).image = image
                    return cell
                    
                case let .TitleSwitchSectionItem(title: title, enabled: enabled):
                    
                    let cell = tableview.dequeueReusableCell(withIdentifier: "titleSwitchCell", for: index)
                    (cell.viewWithTag(1) as! UILabel).text = title
                    (cell.viewWithTag(2) as! UISwitch).isOn = enabled
                    return cell
                }
                
                
            },titleForHeaderInSection: {
                ds,index in
                return ds.sectionModels[index].header
            })
        
        self.dataSource = datasource
        sections
            .bind(to: self.tabview.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
        
        tabview.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    

}

extension RXTableView0Controller:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //返回分区头部视图
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int)
         -> UIView? {
         let headerView = UIView()
         headerView.backgroundColor = UIColor.black
         let titleLabel = UILabel()
         titleLabel.text = self.dataSource?[section].header
         titleLabel.textColor = UIColor.white
         titleLabel.sizeToFit()
         titleLabel.center = CGPoint(x: self.view.frame.width/2, y: 20)
         headerView.addSubview(titleLabel)
         return headerView
     }
      
     //返回分区头部高度
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int)
         -> CGFloat {
         return 30
     }
    
}


enum SectionItem {
    case TitleImageSectionItem(title: String, image: UIImage)
    case TitleSwitchSectionItem(title: String, enabled: Bool)
}
 
//自定义Section
struct MySection_ {
    var header: String
    var items: [SectionItem]
}
 
extension MySection_ : SectionModelType {
    
    typealias Item = SectionItem
     
    init(original: MySection_, items: [Item]) {
        self = original
        self.items = items
    }
}
