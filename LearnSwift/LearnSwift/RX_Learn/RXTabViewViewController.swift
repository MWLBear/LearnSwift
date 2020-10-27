//
//  RXTabViewViewController.swift
//  LearnSwift
//
//  Created by admin on 2020/8/27.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


struct Music {
    let name:String
    let singer:String
    
    init(name:String,singer:String) {
        self.name = name
        self.singer = singer
    }
}

extension Music:CustomStringConvertible{
    var description: String {
        return "name :\(name) singer :\(singer)"
    }
}

struct MusicViewModel {
    let data = [
        Music(name: "孟子", singer: "飞起来"),
        Music(name: "张飞", singer: "走起来"),
        Music(name: "李白", singer: "爬起来"),
        Music(name: "王五", singer: "站起来")

    ]
}



struct MusicViewModelRX {
    var data =
        Observable.just([
            Music(name: "孟子", singer: "飞起来"),
            Music(name: "张飞", singer: "走起来"),
            Music(name: "李白", singer: "爬起来"),
            Music(name: "王五", singer: "站起来")
        ])
}


extension UILabel{
    public var fontSize:Binder<CGFloat>{
        return Binder(self) { (label, fontSize) in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}

extension Reactive where Base: UILabel{
    
    public var fontSize:Binder<CGFloat>{
        return Binder(self.base) { (label, fonsize) in
            label.font = UIFont.systemFont(ofSize: fonsize)
        }
            
    }
}


class RXTabViewViewController: UIViewController {
    
    let label = UILabel(frame: CGRect(x: 20, y: 20, width: 100, height: 20))

    var tableView:UITableView!
    let musicListViewModel = MusicViewModelRX()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
//        self.labesize()
            
//        connect_publish_replay_multicast______.__replay()
        
        maybe_example()
    }
    
    
    func single_example() {
        Single_Completable_Maybe____1.getPlaylist1("0").subscribe { (event) in
            switch event{
            case .success(let json):
                print("json结果:\(json)")
            case .error(let error):
                print("error:\(error)")
            }
        
        }.disposed(by: disposeBag)
        
    }
    
    func cacheLocally_() {
        
        Single_Completable_Maybe____1.cacheLocally().subscribe { (event) in
            switch event{
            case .error(let error):
                print("保存失败: \(error)")
            case .completed:
                print("保存成功")
            }
            
        }
    }
    
    func maybe_example() {
        Single_Completable_Maybe____1.generateString().subscribe { (event) in
            switch event{
            case .success(let suc):
                print("成功:\(suc)")
            case .completed:
                print("完成")
            case .error(let error):
                print("失败:\(error.localizedDescription)")
            }
        }
    }
    
    
//    自定义可绑定属性
    
    
    func labesize() {
        
        self.addlabel()
        
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable
            .map{CGFloat($0)}
            .bind(to: label.rx.fontSize)
            .disposed(by: disposeBag)
    }
    
    
    
    func Bidnder() {
        
        /*
         1.Binder 不会处理错误事件
         绑定都是在给定的Schedler上面执行
         2.错误事件,调试环境fatalError 发布环境打印错误信息
         
         */
        

        let observer:Binder<String> = Binder(label) { (view,text ) in
            view.text = text
        }
        
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable
            .map{"当前索引: \($0)"}
            .bind(to: observer)
            .disposed(by: disposeBag)
        
    }
    
    
    func addlabel() {
        self.label.text = "appple.com"
        self.label.sizeToFit()
        self.view.addSubview(self.label)

    }
    
    
    func addTableView() {
        
        tableView = UITableView(frame: self.view.bounds)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "musicCell")
        self.view.addSubview(tableView)
        
    
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
//        observable.map {"当前索引: \($0)"}.bind { [weak self] (text) in
//            self?.label.text = text
//        }.disposed(by: disposeBag)
//
        observable
            .map {"当前索引: \($0)"}
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
               
        
        tableView.tableHeaderView = label
        
        musicListViewModel.data.bind(to: tableView.rx.items(cellIdentifier: "musicCell")){_,mucic,cell in
            cell.textLabel?.text = mucic.name
            cell.detailTextLabel?.text = mucic.singer
        }.disposed(by: disposeBag)
        
        
        tableView.rx.modelSelected(Music.self).subscribe(onNext:{music in
            print("你选中的音乐[\(music)]")
        }).disposed(by: disposeBag)
    }
    
    
    func anyObserer() {
        
        //AnyObserver 可以用来描叙任意一种观察者。

        let observer:AnyObserver<String> = AnyObserver { (event) in
            switch event{
            case .next(let data):
                print(data)
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
            }
        }
        
        let observalbe = Observable.of("a","b","c")
        observalbe.subscribe(observer)
        
    }
    
}

//extension RXTabViewViewController:UITableViewDataSource,UITableViewDelegate{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return musicListViewModel.data.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: "musiccell")
//        if cell == nil {
//            cell = UITableViewCell(style: .value1, reuseIdentifier: "musiccell")
//            let music = musicListViewModel.data[indexPath.row]
//            cell!.textLabel?.text = music.name
//            cell!.detailTextLabel?.text = music.singer
//        }
//       return cell!
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//          print("你选中的歌曲信息【\(musicListViewModel.data[indexPath.row])】")
//
//    }
//}
