//
//  IncomeOrderViewModel.swift
//  MiniShop
//
//  Created by Alexander Karpenko on 3/24/18.
//  Copyright © 2018 Alexander Karpenko. All rights reserved.
//

import Foundation
import MiniShop_Shared

// MARK: - yes I'm aware that this code is almost the same as in SaleOrderViewModel
// main idea here is to show 3 different tasks in this app and try to split it up
public typealias OrderType = Int

public class IncomeOrderViewModel {

    // MARK: - data
    var order: Order
    
    init(order: Order) {
        self.order = order
    }
}

extension IncomeOrderViewModel: OrderViewModel {
    
     public static let incomeOrderType: Int = 2

    // MARK: - properties
    public var type: OrderType { return IncomeOrderViewModel.incomeOrderType }
    public var typeText: String { return "Income" }
    // MARK: summary
    public var number: String {
        return "# \(order.id)"
    }
    
    public var summary: String {
        return String(format: "\(order.details.count) positions with \(order.totalQty) pcs. in total")
    }

    public var totalQty: String {
        return Formatter.stringFromQty(order.totalQty) + " in total"
    }

    public var date: String {
        return Formatter.stringFromDateString(order.date)
    }

    public var totalSumString: String {
        return Formatter.stringFromMoney(order.totalSum)
    }

    // MARK: details
    public func detailName(forIndex index: Int) -> String {
        return order.details[index].productName
    }

    public func detailInfo(forIndex index: Int) -> String {
        return order.details[index].productInfo
    }

    public func detailValue(forIndex index: Int) -> String {
        let qty = detailQtyString(forIndex: index)
        let price = detailPriceString(forIndex: index)
        return "\(qty) * \(price)"
    }

    public func detailPriceString(forIndex index: Int) -> String {
        let money = order.details[index].price
        return Formatter.stringFromMoney(money)
    }

    public func detailSumString(forIndex index: Int) -> String {
        let money = order.details[index].sum
        return Formatter.stringFromMoney(money)
    }

    public func detailQtyString(forIndex index: Int) -> String {
        let qty = order.details[index].qty
        return Formatter.stringFromQty(qty)
    }
}

extension IncomeOrderViewModel: OrderListDataSource {
    
    public func sectionCount() -> Int {
        return 2
    }
    
    public func itemsCount(forSection section: Int) -> Int {
        switch section {
        case 0: return 4
        case 1: return order.details.count
        default: return 0
        }
    }
}
