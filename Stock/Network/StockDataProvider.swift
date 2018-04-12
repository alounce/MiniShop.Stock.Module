//
//  StockDataProvider.swift
//  Stock
//
//  Created by Alexander Karpenko on 4/4/18.
//  Copyright © 2018 Alexander Karpenko. All rights reserved.
//

import Foundation

public protocol StockDataProvider {
    func downloadIncomes(completion: @escaping (Error?, [Order]?) -> Void)
}
