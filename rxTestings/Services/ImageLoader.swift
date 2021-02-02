//
//  ImageLoader.swift
//  rxTestings
//
//  Created by  Елена on 01.02.2021.
//

import UIKit
import RxSwift

class ImageLoader {
    
    var cachedImages = NSCache<NSURL, UIImage>()
    
    final func image(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    
    init() {
        
    }
    
    // Returns the cached image if available, otherwise asynchronously loads and caches it.
    func downloadImage(for item: Item) -> Observable<UIImage> {
        
        let url = item.url as NSURL
        
        // Check for a cached image.
        if let cachedImage = image(url: url) {
            return Observable.just(cachedImage)
        }
        
        return URLSession.shared
            .rx.data(request: URLRequest(url: url as URL))
            .retry(3)
            .map ({ UIImage(data: $0) ?? UIImage(named: "noImage")! })
        
    }
    
}


