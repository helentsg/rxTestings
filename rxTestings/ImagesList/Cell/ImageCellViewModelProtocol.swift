//
//  ImageCellViewModelProtocol.swift
//  rxTestings
//
//  Created by  Елена on 01.02.2021.
//

import UIKit

protocol ImageCellViewModelProtocol {
    
    var item : Item {get}
    
}

class ImageCellViewModel: ImageCellViewModelProtocol {
    
    var item : Item
   
    required init(item: Item) {
        
        self.item = item
        
    }

}



