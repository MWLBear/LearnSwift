//
//  RXUICollectionViewController.swift
//  LearnSwift
//
//  Created by admin on 2020/9/9.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift
import Alamofire


class MySectionHeader: UICollectionReusableView {
    var label:UILabel!
     
    override init(frame: CGRect) {
        super.init(frame: frame)
         
        //背景设为黑色
        self.backgroundColor = UIColor.black
         
        //创建文本标签
        label = UILabel(frame: frame)
        label.textColor = UIColor.white
        label.textAlignment = .center
        self.addSubview(label)
    }
     
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
     
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class MyCollectionCell: UICollectionViewCell {
   
    var label : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .orange
        
        label = UILabel(frame: frame)
        label.textColor = .white
        label.textAlignment = .center
        self.contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    
}





class RXUICollectionViewController: UIViewController {

    var collectionView : UICollectionView!
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionview()
        
        
//        AlTool().re_resquest_json()
//        self.requset()
    }
    
     func requset(){
         
        
        let startButton = UIButton(frame: CGRect(x: 10, y: 40, width: 100, height: 20))
        startButton.setTitle("开始", for: .normal)
        startButton.backgroundColor = .black
        let cancleButton = UIButton(frame: CGRect(x: 10, y: 80, width: 100, height: 20))
        cancleButton.setTitle("取消", for: .normal)
        cancleButton.backgroundColor = .black
        
        view.addSubview(startButton)
        view.addSubview(cancleButton)

    
         let urlString = "https://www.douban.com/j/app/radio/channels"
         let url = URL(string:urlString)!
         
        //第一种写法:
        //创建请求对象
//         let request = URLRequest(url: url!)
//
//        startButton.rx.tap.asObservable().flatMap{
//            URLSession.shared.rx.response(request: request)
//                .takeUntil(cancleButton.rx.tap)
//        }.subscribe(onNext: { (response, data) in
//             let str = String(data: data, encoding: String.Encoding.utf8)
//             print("返回的数据是：", str ?? "")
//         }).disposed(by: disposeBag)
         
        
        //第二种写法 - RXAlamofire
        startButton.rx.tap.asObservable().flatMap {
            request(.get, url).responseString()
                .takeUntil(cancleButton.rx.tap)
        }.subscribe(onNext: { (response, data) in
            print("请求成功!返回的数据是:\(data)")
        }, onError: { (error) in
            print("请求失败:\(error.localizedDescription)")
            }).disposed(by: disposeBag)
        
     }
    
    
    func collection1()  {
        
        //定义布局方式以及单元格大小
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 70)
        flowLayout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 40)
        
        //创建集合视图
        self.collectionView = UICollectionView(frame: self.view.frame,
                                               collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.white
        
        //创建一个重用的单元格
        self.collectionView.register(MyCollectionCell.self,
                                     forCellWithReuseIdentifier: "Cell")
        //创建一个重用的分区头
        self.collectionView.register(MySectionHeader.self,
                                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                     withReuseIdentifier: "Section")
        self.view.addSubview(self.collectionView!)
        
        
        //初始化数据
        let items = Observable.just([
            SectionModel(model: "脚本语言", items: [
                "Python",
                "javascript",
                "PHP",
            ]),
            SectionModel(model: "高级语言", items: [
                "Swift",
                "C++",
                "Java",
                "C#"
            ])
        ])
        
        //创建数据源
        let dataSource = RxCollectionViewSectionedReloadDataSource
            <SectionModel<String, String>>(
                configureCell: { (dataSource, collectionView, indexPath, element) in
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                                  for: indexPath) as! MyCollectionCell
                    cell.label.text = "\(element)"
                    return cell},
                configureSupplementaryView: {
                    (ds ,cv, kind, ip) in
                    let section = cv.dequeueReusableSupplementaryView(ofKind: kind,
                                                                      withReuseIdentifier: "Section", for: ip) as! MySectionHeader
                    section.label.text = "\(ds[ip.section].model)"
                    return section
            })
        
        //绑定单元格数据
        items
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    
    
    
    
    func collectionview() {
        
        //view.backgroundColor = .white
        let flowlayout = UICollectionViewFlowLayout()
        //flowlayout.itemSize = CGSize(width: 100, height: 100)
        
        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowlayout)
        self.collectionView.register(MyCollectionCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.backgroundColor = UIColor.white

        self.view.addSubview(self.collectionView)
        
        
        
        let items = Observable.just([
            "Swift",
            "PHP",
            "Ruby",
            "Java",
            "C++",
            "Oc",
            "Js"
        ])
        
        
        items
            .bind(to: collectionView.rx.items) { (collectionView, row, element) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                              for: indexPath) as! MyCollectionCell
                cell.label.text = "\(row)：\(element)"
                return cell
        }
        .disposed(by: disposeBag)
        
        //获取选中项的索引
        collectionView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("选中项的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
        
        
        //获取选中项的内容
        collectionView.rx.modelSelected(String.self).subscribe(onNext: { item in
            print("选中项的标题为：\(item)")
        }).disposed(by: disposeBag)
        
        //获取被取消选中项的索引
        collectionView.rx.itemDeselected.subscribe(onNext: { [weak self] indexPath in
            self?.showMessage("被取消选中项的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
        
        //获取被取消选中项的内容
        collectionView.rx.modelDeselected(String.self).subscribe(onNext: {[weak self] item in
            self?.showMessage("被取消选中项的的标题为：\(item)")
        }).disposed(by: disposeBag)
        
        //获取选中并高亮完成后的索引
        collectionView.rx.itemHighlighted.subscribe(onNext: { indexPath in
            print("高亮单元格的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
        
        
        //获取高亮转成非高亮完成后的索引
        collectionView.rx.itemUnhighlighted.subscribe(onNext: { indexPath in
            print("失去高亮的单元格的indexPath为：\(indexPath)")
        })
        //单元格将要显示出来的事件响应
        collectionView.rx.willDisplayCell.subscribe(onNext: { cell, indexPath in
            print("将要显示单元格indexPath为：\(indexPath)")
            print("将要显示单元格cell为：\(cell)\n")
        }).disposed(by: disposeBag)
        
        
        //分区头部、尾部将要显示出来的事件响应
        collectionView.rx.willDisplaySupplementaryView.subscribe(onNext: { view, kind, indexPath in
            print("将要显示分区indexPath为：\(indexPath)")
            print("将要显示的是头部还是尾部：\(kind)")
            print("将要显示头部或尾部视图：\(view)\n")
        }).disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self)
        .disposed(by: disposeBag)
    }
    
    
    
    func showMessage(_ text:String) {
         let alertController = UIAlertController(title: text, message: nil, preferredStyle: .alert)
         let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
         alertController.addAction(cancelAction)
         self.present(alertController, animated: true, completion: nil)
     }
     
}

extension RXUICollectionViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {
           let width = collectionView.bounds.width
           let cellWidth = (width - 30) / 4 //每行显示4个单元格
           return CGSize(width: cellWidth, height: cellWidth * 1.5) //单元格宽度为高度1.5倍
       }
}
