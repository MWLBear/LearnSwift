//
//  RXUITableViewController.swift
//  LearnSwift
//
//  Created by admin on 2020/9/8.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import Alamofire
import WebKit

class RXUITableViewController: UIViewController {

    
    var tableView:UITableView!
    var searchBar:UISearchBar!
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var stop: UIBarButtonItem!
    @IBOutlet weak var refreshbutton: UIBarButtonItem!
    
    override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
//          tableView.setEditing(true, animated: true)
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        AlTool().rxdata()
        
        mapobject()
        
//        showdownFile()
        
        
        
            
        
    }
    
    func showdownFile() {
        
        let progressView = UIProgressView(frame: CGRect(x: 0, y: 65, width: self.view.frame.width, height: 2))
        progressView.tintColor = .blue
        view.addSubview(progressView)
        progressView.progress = 0
        
        AlTool().downFile(disposBag: disposeBag,progressview: progressView)

    }
    
    
    
    
    func test() {
        Observable.of(1, 2, 3, 4, 5)
            .scan(0) { acum, elem in
                print("000:\(acum)")
                print("1111:\(elem)")
                return acum + elem
        }
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
    }
    
    
    
    
    //获取数据，并转换成对应的模型。
    func JsonToModel() {
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        
        URLSession.shared.rx.json(request: request)
            .mapObject(type: Douban.self)
            .subscribe(onNext: { (douban:Douban) in
                if let dbs = douban.channels{
                    print("--- 共\(dbs.count)个频道 ---")
                    for db in dbs {
                        if let name = db.name,let channiId = db.channelId {
                            print("name:\(name) -- id:\(channiId)")
                        }
                    }
                }
                
            }).disposed(by: disposeBag)
        
    }
    
    
    
    //将结果映射成自定义对象
    
    func mapobject()  {
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        
        let data = URLSession.shared.rx.json(request: request)
            .mapObject(type: Douban.self)
            .map{$0.channels ?? []}
        
        //RxAlamofire + RxObjectMapper
        let data1 = requestJSON(.get, urlString)
            .map{$1}
            .mapObject(type: Douban.self)
            .map{$0.channels ?? []}
        
        
        
        data1.bind(to: tableView.rx.items){(tv ,row,elemet) in
            
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(row):\(elemet.name!)"
            return cell
        }.disposed(by: disposeBag)
    }
    
    
    func rx_mapobject(){
        
        
    }
    
    
    func requestdata_tableview() {
        
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
         
        
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        //        //创建并发起请求
        //        URLSession.shared.rx.data(request: request).subscribe(onNext: {
        //            data in
        //            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        //                as! [String: Any]
        //            print("--- 请求成功！返回的如下数据 ---")
        //            print(json!)
        //        }).disposed(by: disposeBag)
        
        
        let data = URLSession.shared.rx.json(request: request)
            .map { reslut -> [[String:Any]] in
                if let data = reslut as? [String:Any],
                    let channels = data["channels"] as? [[String:Any]] {
                    return channels
                }else{
                    return []
                }
        }
        
        data.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(row)：\(element["name"]!)"
            return cell
        }.disposed(by: disposeBag)
        
    
        
    }
    
    
    
    
    
    func tableview() {
        self.tableView = UITableView(frame: self.view.frame)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "mycell")
        self.view.addSubview(self.tableView)
        
        let items = Observable.just([
            "文本输入框的用法",
            "开关按钮的用法",
            "进度条的用法",
            "文本标签的用法",
        ])
        
        items
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "mycell")!
                cell.textLabel?.text = "\(row)：\(element)"
                return cell
        }
        .disposed(by: disposeBag)
        
        
        //        tableView.rx.itemSelected.subscribe(onNext: { (indePath) in
        //            print("选中的indexPath为: \(indePath)")
        //        }).disposed(by: disposeBag)
        //
        //        tableView.rx.modelSelected(String.self).subscribe(onNext: { (item) in
        //            print("选中项的标题为：\(item)")
        //        }).disposed(by: disposeBag)
        //
        Observable.zip(tableView.rx.itemSelected,tableView.rx.modelSelected(String.self))
            .bind { [weak self] indexPath,item in
                print("选中的indexPath为: \(indexPath)")
                print("选中项的标题为：\(item)")
                
        }.disposed(by: disposeBag)
        
        
        tableView.rx.itemDeselected.subscribe(onNext: { (indexPath) in
            print("取消选中:\(indexPath)")
        }).disposed(by: disposeBag)
        
        tableView.rx.itemDeleted.subscribe(onNext: { (indexPath) in
            print("删除项目:\(indexPath)")
        }).disposed(by: disposeBag)
        
        tableView.rx.itemInserted.subscribe(onNext: { [weak self] indexPath in
            print("插入项的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
        
        
        tableView.rx.itemAccessoryButtonTapped.subscribe(onNext: { [weak self] indexPath in
            print("尾部项的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
        
    }
    
    //3，单分区的 TableView
    //方式一：使用自带的Section

    func rxdatasource() {
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "mycell")
        self.view.addSubview(self.tableView)
        
        
        let items  = Observable.just([
            SectionModel(model: "", items: [
                "UILabel的用法",
                "UIText的用法",
                "UIButton的用法"
            ])
        ])
        
        let dataSource =  RxTableViewSectionedReloadDataSource<SectionModel<String,String>>(configureCell: { (datasource, tv, indexPath, element)  in
            
            let cell = tv.dequeueReusableCell(withIdentifier: "mycell")!
            cell.textLabel?.text = "\(indexPath.row)+\(element)"
            return cell

        })
        
        
        items
            .bind(to: self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    
    func rxdatasource_1() {
        
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
         
        //初始化数据
        let sections = Observable.just([
            MySection(header: "", items: [
                "UILable的用法",
                "UIText的用法",
                "UIButton的用法"
                ])
            ])
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<MySection>(
            //设置单元格
            configureCell: { ds, tv, ip, item in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")
                    ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
                cell.textLabel?.text = "\(ip.row)：\(item)"
                
                return cell
        })
        
        //绑定单元格数据
        sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    
    
    
    func much_rxdatasource() {
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        let items = Observable.just([
            SectionModel(model: "基本控件", items: [
                "UILable的用法",
                "UIText的用法",
                "UIButton的用法"
            ]),
            SectionModel(model: "高级控件", items: [
                "UITableView的用法",
                "UICollectionViews的用法"
            ])
            
        ])
        
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,String>>(configureCell: { (da, tv, index, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(index.row)：\(element)"
            return cell
        })
        dataSource.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].model
        }
        
        items.bind(to: self.tableView.rx.items(dataSource: dataSource)).disposed(by: self.disposeBag)
        
        
    }
    
    
    func refeshtableview() {
        
        
        
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        self.searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 56))
        self.tableView.tableHeaderView = self.searchBar
        
        let randomResult = refreshbutton.rx.tap.asObservable()
            .throttle(1, scheduler: MainScheduler.instance) //在主线程中操作，1秒内值若多次改变，取最后一次
            .startWith(())//加这个为了让一开始就能自动请求一次数据
            .flatMapLatest{self.getrandomResult().takeUntil(self.stop.rx.tap)}
            .flatMap(filterResult)
            .share(replay: 1)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,Int>>(configureCell: { (datasource, tv, index, element)  in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "条目\(index.row)：\(element)"
            return cell
        })
        
        randomResult.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
    }
    
    //随机数据
    func getrandomResult() -> Observable<[SectionModel<String,Int>]> {
        print("正在请求数据....")
        let items = (0..<5).map {_ in Int(arc4random())}
        let observable = Observable.just([SectionModel(model: "S", items: items)])
        return observable.delay(2, scheduler: MainScheduler.instance)
    }
    
    //获取随机数据
    func getRandomResult() -> Observable<[String]> {
        print("生成随机数据。")
        let items = (0 ..< 5).map {_ in
            "\(arc4random())"
        }
        return Observable.just(items)
    }
    
    //过滤数据
    
    func filterResult(data:[SectionModel<String,Int>])->Observable<[SectionModel<String,Int>]>  {
        
        return self.searchBar.rx.text.orEmpty.flatMapLatest { (query) -> Observable<[SectionModel<String,Int>]> in
            print("正在筛选数据,条件为:\(query)")
            if query.isEmpty{
                return Observable.just(data)
            }else{
                var newData:[SectionModel<String, Int>] = []
                
                for sectionModel in data {
                    let items = sectionModel.items.filter{ "\($0)".contains(query) }
                    newData.append(SectionModel(model: sectionModel.model, items: items))
                }
                return Observable.just(newData)
            }
        }
        
    }

    //编辑单元表格
    func rxeditbtaleview() {
        
        self.stop.title = "+"
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //表格模型
        let initialVM = TableViewModel()
        
        
        let refreshCommand = refreshbutton.rx.tap.asObservable()
            .startWith(())//加这个为了页面初始化时会自动加载一次数据
            .flatMapLatest(getRandomResult)
            .map(TableEditingCommand.setItems)
        
        let addCommand = stop.rx.tap.asObservable()
            .map{"\(arc4random())"}
            .map(TableEditingCommand.addItem)
    
        
        //移动位置命令
        let movedCommand = tableView.rx.itemMoved
            .map(TableEditingCommand.moveItem)
        
        let deleteCommand = tableView.rx.itemDeleted.asObservable()
            .map(TableEditingCommand.deleteItem)
        
    
        Observable.of(refreshCommand,addCommand,movedCommand,deleteCommand)
        .merge()
            .scan(initialVM) { (vm:TableViewModel, command:TableEditingCommand) -> TableViewModel in
                return vm.execute(command: command)
        }.startWith(initialVM)
        .map{
            [AnimatableSectionModel(model: "", items: $0.items)]
        }
        .share(replay: 1)
        .bind(to: tableView.rx.items(dataSource: RXUIViewController.dataSource()))
        .disposed(by: disposeBag)
        
    }
    
    
    //不同类型的单元格混用
    
    func differenttableview(){
        
    }
    
    
    
    
    
    
    

}

extension RXUIViewController {
    //创建表格数据源
    static func dataSource() -> RxTableViewSectionedAnimatedDataSource
        <AnimatableSectionModel<String, String>> {
        return RxTableViewSectionedAnimatedDataSource(
            //设置插入、删除、移动单元格的动画效果
            animationConfiguration: AnimationConfiguration(insertAnimation: .top,
                                                           reloadAnimation: .fade,
                                                           deleteAnimation: .left),
            configureCell: {
                (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "条目\(indexPath.row)：\(element)"
                return cell
        },
            canEditRowAtIndexPath: { _, _ in
                return true //单元格可删除
        },
            canMoveRowAtIndexPath: { _, _ in
                return true //单元格可移动
        }
        )
    }
}


enum TableEditingCommand {
    
    case setItems(items: [String])  //设置表格数据
    case addItem(item: String)  //新增数据
    case moveItem(from: IndexPath, to: IndexPath) //移动数据
    case deleteItem(IndexPath) //删除数据
}

//表格对应的ViewModel

struct TableViewModel {
    fileprivate var items:[String]
    
    init(items:[String] = []) {
        self.items = items
    }
    
    func execute(command:TableEditingCommand) -> TableViewModel {
        switch command {
        case .setItems(items: let item):
            print("设置表格数据")
            return TableViewModel(items: item)
        case .addItem(item: let item):
            print("新增数据")
            var items = self.items
            items.append(item)
            return TableViewModel(items: items)
        case .moveItem(from: let findex, to: let tindex):
            print("移动数据")
            var items = self.items
            items.insert(items.remove(at: findex.row), at: tindex.row)
            return TableViewModel(items: items)
        case .deleteItem(let index):
            print("删除数据")
            var items = self.items
            items.remove(at: index.row)
            return TableViewModel(items: items)
        }
    }
}




struct MySection {
    var header:String
    var items:[Item]
    
}

extension MySection:AnimatableSectionModelType{
    typealias Item = String
    
    var identity: String{
        return header
    }
    
    init(original: Self, items: [Self.Item]) {
        self = original
        self.items = items
    }
    
}
