//
//  Item.swift
//  rxTestings
//
//  Created by  Елена on 01.02.2021.
//

import Foundation

struct Item {
    
    let number: Int!
    let url: URL!
    var isFifth : Bool
    
    init(number: Int) {
        self.number = number
        self.isFifth = number % 5 == 0
        // каждая пятая картинка должна быть высокой
        // и все остальные квадратные
        
        let size = isFifth ? "150x500" : "150"
        let color = isFifth ? "0000FF/FFFFFF" : "000000/FFFFFF"
        
        self.url = URL(string: "https://via.placeholder.com/\(size)/\(color)/?text=\(number)")!
    }

}

