//
//  ImagesViewModelProtocol.swift
//  rxTestings
//
//  Created by  Елена on 01.02.2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

//MARK:- ImagesViewModelProtocol:
protocol ImagesViewModelProtocol {
    
    var dataSource : BehaviorRelay<[Item]> { get }
    var imageLoader : ImageLoader { get }
    func addNewFirstFiveToItems()
    func addLastToItems(forRow row: Int)
    
}

//MARK:- ImagesViewModel:
class ImagesViewModel : ImagesViewModelProtocol {
    
    var dataSource = BehaviorRelay(value: [Item]())
    var imageLoader : ImageLoader
    
    private var array = [Int]()
    
    var startIndex = 0
    
    var endIndex = 20
    
    init() {
        
        self.imageLoader = ImageLoader()
        array = Array(0..<20)
        updateDataSource()
        
    }
    
}

//MARK:- Methods:
extension ImagesViewModel {
    
    func updateDataSource() {
        
        let items = array.map({Item(number: $0)})
        dataSource.accept(items)
        
    }
    
    func addNewFirstFiveToItems() {
        
        if array.count <= 95 {
            startIndex -= 5
            
            array = Array(startIndex ..< endIndex)
            updateDataSource()
            
        }
    }
    
    func addLastToItems(forRow row: Int) {
       
        let lastIndex = array.count - 1
        if row == lastIndex, row <= 99 {
            endIndex += 1
            array = Array(startIndex ..< endIndex)
            updateDataSource()
        }
        
    }
    
}
