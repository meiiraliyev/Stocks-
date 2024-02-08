//
//  StockModel2.swift
//  stocksApp0412
//
//  Created by Meiir on 04.01.2024.
//

import Foundation

struct StockModel2: Codable{
    let c: Double? // current price
    let dp: Double? // percent change
    let d: Double? // pricce change 
    
    func currentPriceToString() -> String{
        return "$\(c ?? 77.7)"
    }
    
    func dayDeltaToString() -> String{
        if hasIncreased(){
            return "+$\(d ?? 1.1)" + "(" + String(format: "%.2f", dp ?? 1.1) + "%)"
        } else {
            return "-$\(-1*(d ?? 1.1))" + "(" + String(format: "%.2f", dp ?? 1.1) + "%)"
        }
    }
    
    func hasIncreased() -> Bool{
        if d ?? 1.0 >= 0{
            return true
        } else {
            return false
        }
    }
}
