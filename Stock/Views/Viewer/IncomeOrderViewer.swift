//
//  OrderViewer.swift
//  MiniShop
//
//  Created by Alexander Karpenko on 3/22/18.
//  Copyright © 2018 Alexander Karpenko. All rights reserved.
//

import UIKit

public class IncomeOrderViewer: UITableViewController {

    var viewModel: IncomeOrderViewModel!

    override public func viewDidLoad() {
        super.viewDidLoad()
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionCount()
    }

    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsCount(forSection: section)
    }

    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let section = indexPath.section
        let row = indexPath.row
        if section == 0 {
            // What is it, income or sale?
            if row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleCell", for: indexPath)
                cell.textLabel?.text = "Type:"
                cell.detailTextLabel?.text = viewModel.typeText
                return cell
            }
            // When it happened?
            if row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleCell", for: indexPath)
                cell.textLabel?.text = "Date:"
                cell.detailTextLabel?.text = viewModel.date
                return cell
            }
            // How many items are in order?
            if row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleCell", for: indexPath)
                cell.textLabel?.text = "Quantity:"
                cell.detailTextLabel?.text = viewModel.totalQty
                return cell
            }
            // What the value of order?
            if row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleCell", for: indexPath)
                cell.textLabel?.text = "Total:"
                cell.detailTextLabel?.text = viewModel.totalSumString
                return cell
            }
        }

        if section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell",
                                                           for: indexPath) as? OrderViewerDetailCell else {
                fatalError("Cannot obtain DetailCell")
            }
            let name = viewModel.detailName(forIndex: row)
            let info = viewModel.detailInfo(forIndex: row)
            let totalString = viewModel.detailSumString(forIndex: row)
            let value = viewModel.detailValue(forIndex: row)
            cell.configure(title: name, details: info, value: value, total: totalString)
            return cell
        }

        fatalError("Cannot obtain any cell")
    }

    override public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "order:"
        }
        if section == 1 {
            return "details:"
        }
        return nil
    }

    override public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

}
