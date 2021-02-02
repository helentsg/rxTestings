//
//  ImageCellViewModelProtocol.swift
//  rxTestings
//
//  Created by  Елена on 01.02.2021.
//

import UIKit
import RxSwift
import RxCocoa

protocol ImageCellViewModelProtocol {
    
    var item : Item { get }
    var image : Observable<UIImage> { get }
    
}

class ImageCellViewModel: ImageCellViewModelProtocol {
    
    var item : Item
    var image: Observable<UIImage>
    let imageLoader : ImageLoader
    
    required init(imageLoader: ImageLoader, item: Item) {
        
        self.imageLoader = imageLoader
        self.item = item
        self.image = imageLoader.downloadImage(for: item)
        
    }

}



