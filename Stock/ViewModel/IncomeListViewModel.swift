//
//  OrderListViewModel.swift
//  MiniShop
//
//  Created by Alexander Karpenko on 3/23/18.
//  Copyright © 2018 Alexander Karpenko. All rights reserved.
//

import Foundation
import MiniShop_Shared

public class IncomeListViewModel {
    
    // working with the data
    private var provider: StockDataProvider
    public var orders = [Order]()
    
    public init(provider: StockDataProvider) {
        self.provider = provider
    }

    public func downloadIncomes(completion: @escaping (Error?) -> Void) {
        provider.downloadIncomes { [weak self] err, orders in
            if let orders = orders {
                self?.orders = orders
            }
            completion(err)
        }
    }

    // custom properties
    public var totalSum: Int {
        return orders
            .map { $0.totalSum }
            .reduce(0, +)
    }

    public var totalSumString: String {
        return Formatter.stringFromMoney(totalSum)
    }

    public var summary: String {
        return "\(itemsCount) orders for \(totalSumString) in total"
    }

    // datasource
    public let groupsCount: Int = 1
    public var itemsCount: Int { return orders.count }
    
    public func getItem(byIndex index: Int) -> IncomeOrderViewModel {
        let order = orders[index]
        return IncomeOrderViewModel(order: order)
    }
}
