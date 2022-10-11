//
//  ChartViewController.swift
//  CandleStick
//
//  Created by Adel Aref on 08/10/2022.
//

import UIKit
import Charts

class CurrencyViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let viewModel = CurrencyViewModel()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        tableView.tableFooterView = UIView()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(identifier: R.nib.currencyTableViewCell.name)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }
}

extension CurrencyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell") as? CurrencyTableViewCell {
            cell.currencyTitleLabel.text = viewModel.getCurrencyText(for: indexPath.row)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewController = CandleStickChartViewController.instantiate(fromAppStoryboard: .main)
        viewController.currency = viewModel.getCurrencyText(for: indexPath.row)
        self.navigationController!.pushViewController(viewController, animated: true)
    }
}
