//
//  CandleStickChartViewController.swift
//  CandleStick
//
//  Created by Adel Aref on 09/10/2022.
//

import Foundation
import UIKit
import Charts
import RxCocoa
import RxSwift

class CandleStickChartViewController: DemoBaseViewController {

    @IBOutlet var chartView: CandleStickChartView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var backButtton: UIButton!
    var currency: String?
    let viewModel = ChartViewModel()
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        backButtton.setTitle("", for: .normal)
        setupBasicBinding()
        chartView.delegate = self

        chartView.chartDescription.enabled = false
        chartView.dragEnabled = false
        chartView.setScaleEnabled(true)
        chartView.maxVisibleCount = 200
        chartView.pinchZoomEnabled = true
        chartView.legend.horizontalAlignment = .right
        chartView.legend.verticalAlignment = .top
        chartView.legend.orientation = .vertical
        chartView.legend.drawInside = false
        chartView.legend.font = UIFont(name: "HelveticaNeue-Light", size: 10)!

        chartView.leftAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
        chartView.leftAxis.spaceTop = 0.3
        chartView.leftAxis.spaceBottom = 0.3
        chartView.leftAxis.axisMinimum = 0
        chartView.backgroundColor = R.color.cellBackground()
        chartView.layer.cornerRadius = 16
        chartView.layer.masksToBounds = true
        chartView.rightAxis.enabled = false

        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleLabel.text = currency ?? ""
        viewModel.getChartData(for: currency ?? "")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func backDidPressed() {
        self.navigationController?.popViewController(animated: true)
    }

    private func setupBasicBinding() {
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        viewModel
            .isError
            .observe(on: MainScheduler.instance)
            .bind(to: self.rx.isError)
            .disposed(by: disposeBag)
        viewModel
            .isSuccess
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (data)  in
                guard let self = self else { return }
                self.setDataCount(with: data)
            }).disposed(by: disposeBag)
    }

    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
    }

    func setDataCount(with data: [[BaseModel]]) {

        let range = UInt32(50) // assume that range = 50
        let finalModel = ChartDataModel(with: data)
        let yVals1 = (0..<finalModel.data.count).map { (i) -> CandleChartDataEntry in
            let model = finalModel.data[i]
            var high = 0.0
            var low = 0.0
            var open = 0.0
            var close = 0.0
            let val = Double(arc4random_uniform(40) + range)
            let even = i % 2 == 0
            for item in model {
                switch item {
                case .high(let highValue):
                    high = highValue
                case .low(let lowValue):
                    low = lowValue
                case .open(let openValue):
                    open = openValue
                case .close(let closeValue):
                    close = closeValue
                default:
                    break
                }
            }

            return CandleChartDataEntry(x: Double(i), shadowH: val + high, shadowL: val - low, open: even ? val + open : val - open, close: even ? val - close : val + close, icon: UIImage(named: "icon")!)
        }

        let set1 = CandleChartDataSet(entries: yVals1, label: "")
        set1.axisDependency = .left
        set1.setColor(UIColor(white: 80/255, alpha: 1))
        set1.drawIconsEnabled = false
        set1.shadowColor = .darkGray
        set1.shadowWidth = 0.7
        set1.decreasingColor = .red
        set1.decreasingFilled = true
        set1.increasingColor = UIColor(red: 122/255, green: 242/255, blue: 84/255, alpha: 1)
        set1.increasingFilled = false
        set1.neutralColor = .blue

        let data = CandleChartData(dataSet: set1)
        chartView.data = data
    }

    override func optionTapped(_ option: Option) {
        switch option {
        case .toggleShadowColorSameAsCandle:
            for case let set as CandleChartDataSet in chartView.data! {
                set.shadowColorSameAsCandle = !set.shadowColorSameAsCandle
            }
            chartView.notifyDataSetChanged()
        case .toggleShowCandleBar:
            for set in chartView.data!.dataSets as! [CandleChartDataSet] {
                set.showCandleBar = !set.showCandleBar
            }
            chartView.notifyDataSetChanged()
        default:
            super.handleOption(option, forChartView: chartView)
        }
    }
}
