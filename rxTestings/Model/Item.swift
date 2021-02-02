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
    
    init(number: Int) {
        self.number = number
        // каждая пятая картинка должна быть высокой
        // и все остальные квадратные
        let size = (number % 5 == 0) ? "150x500" : "150"
        self.url = URL(string: "https://via.placeholder.com/\(size)/000000/FFFFFF/?text=\(number)")!
    }

}

