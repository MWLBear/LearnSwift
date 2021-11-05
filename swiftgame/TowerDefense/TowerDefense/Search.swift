//
//  Search.swift
//  AStar_demo_swift
//
//  Created by songnaiyin on 2018/8/16.
//  Copyright © 2018年 longzhu. All rights reserved.
//

import UIKit

class SearchItem: NSObject {
	var isOpen: Bool = true
	var f: Int = 0
	var h: Int = 0
	var g: Int  = 0
	var x: Int = 0
	var y: Int = 0
	var parent: SearchItem?
	
	func copy() -> SearchItem {
		let item = SearchItem()
		item.isOpen = self.isOpen
		item.f = self.f
		item.h = self.h
		item.g = self.g
		item.x = self.x
		item.y = self.y
		return item
	}
}


class Search: NSObject {
	
	private var map: [[SearchItem]]
	private var end: SearchItem
	private var start: SearchItem
	
	private var open: Set<SearchItem> = Set<SearchItem>()
	private var close: Set<SearchItem> = Set<SearchItem>()
	
	public var searchCallback: ((SearchItem) -> Void)?
	
	init(start: SearchItem, end: SearchItem, map: [[SearchItem]]) {
		var tempArr = [[SearchItem]]()
		for arr in map {
			var arr1 = [SearchItem]()
			for item in arr {
				arr1.append(item.copy())
			}
			tempArr.append(arr1)
		}
		self.map = tempArr
		self.start = tempArr[start.x][start.y]
		self.end = tempArr[end.x][end.y]
		super.init()
	}
	
	/// 开始查找
	func startSearch() -> [SearchItem] {
		return search(from: start, to: end)
	}
	
	func search(from: SearchItem, to: SearchItem) -> [SearchItem] {
		let currentNode = from
		var nextNode: SearchItem?
		let nears = findNearOpen(currentNode)
		var minF = 10000
		// 1.将起始点加入OPEN表中
		open.insert(from)
		for tmpNode in nears {
			// 算出从当前节点到其邻接节点的gx
			let tmpGx = currentNode.g + 10
			if open.contains(tmpNode) {
				// 判断节点是否已经再open中 如果在open 中其gx 比现在的gx大的话 说明从当前节点出发到达该节点更划算
				if tmpNode.g > tmpGx {
					tmpNode.g = tmpGx
					tmpNode.parent = currentNode
				}
			} else {
				// 如果不在open中则加入open
				tmpNode.g = tmpGx
				tmpNode.parent = currentNode
				open.insert(tmpNode)
			}
			tmpNode.h = manh(tmpNode, to: to)
			tmpNode.f = tmpNode.g + tmpNode.h
			// 如果该节点的f 在当前节点的所有邻接节点中是最小的，并且该节点的父节点是当前节点 则把该节点当做下一个要访问的节点
			if tmpNode.f <= minF {
				minF = tmpNode.f
				nextNode = tmpNode
			}
		}
		open.remove(currentNode)
		close.insert(currentNode)
		for obj in open {
			if obj.f < minF {
				minF = obj.f
				nextNode = obj
			} else if obj.f == (nextNode?.f ?? 0) && obj.h < (nextNode?.h ?? 0) {
				minF = obj.f
				nextNode = obj
			}
		}
		
		if close.contains(to) {
			var routes = [SearchItem]()
			var node: SearchItem? = to
			while node?.parent != nil {
				if let n = node {
					routes.insert(n, at: 0)
					node = n.parent
				}
			}
			if let n = node {
				routes.insert(n, at: 0)
				
			}
			return routes
		} else if open.count == 0 {
			return [SearchItem]()
		} else {
			if let next = nextNode {
				searchCallback?(next)
				return search(from: next, to: to)
			} else {
				return [SearchItem]()
			}
		}
	}
	
	/// 曼哈顿估算函数
	private func manh(_ item: SearchItem, to: SearchItem) -> Int {
		let x = to.x - item.x
		let y = to.y - item.y
		return abs(x * 10) + abs(y * 10)
	}
	
	/// 判断两个节点是否相邻
	private func isNear(_ item: SearchItem, to: SearchItem) -> Bool {
		return abs(item.x - to.x) == 1 || abs(item.y - to.y) == 1
		
	}
	
	/// 求出该节点的邻接节点 去除不可达的 和已经加入到close 表的
	private func findNearOpen(_ item: SearchItem) -> [SearchItem] {
		let all = findNearAll(item)
		var temps = [SearchItem]()
		for node in all {
			if node.isOpen && !close.contains(node) {
				if !open.contains(node) {
					node.parent = item
				}
				temps.append(node)
			}
		}
		return temps
	}
	
	/// 返回某个节点周围存在的节点,不论是否已添加或者是不可达
	private func findNearAll(_ item: SearchItem) -> [SearchItem] {
		var arr = [SearchItem]()
		if item.x - 1 >= 0 {
			let node = map[item.x - 1][item.y]
			arr.append(node)
		}
		if item.y - 1 >= 0 {
			let node = map[item.x][item.y - 1]
			arr.append(node)
		}
		if item.y + 1 < (map.first?.count ?? 0) {
			let node = map[item.x][item.y + 1]
			arr.append(node)
		}
		if item.x + 1 < map.count {
			let node = map[item.x + 1][item.y]
			arr.append(node)
		}
		return arr
	}
}
