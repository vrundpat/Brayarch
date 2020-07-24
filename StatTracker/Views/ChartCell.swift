//
//  ChartCell.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/23/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit
import Charts

class ChartCell: UICollectionViewCell {
    
    var data = [ChartDataEntry]() {
        didSet {
            self.setUpChartView()
        }
    }
    
    var mode = ""
    var valueColors = [UIColor]()
    var labels = [String]()
    var chartTitle = String()
    
    lazy var chartStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var chartTitleTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .black
        textView.textColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "DINAlternate-Bold", size: 16)
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        textView.backgroundColor = .black
        textView.isEditable = false
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        textView.textAlignment = .center
        return textView
    }()
    
    lazy var chartView: LineChartView = {
        let chart = LineChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.rightAxis.drawLabelsEnabled = true
        chart.chartDescription?.text = "Testing!"
        chart.chartDescription?.textColor = .white
        
        chart.xAxis.labelPosition = XAxis.LabelPosition.bottom
        chart.xAxis.labelTextColor = .white
        chart.leftAxis.labelTextColor = .black
        chart.leftAxis.enabled = true
        chart.rightAxis.enabled = false
        return chart
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setChartContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setChartContraints() {
        
        contentView.addSubview(chartStackView)
        chartStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        chartStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        chartStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        chartStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
        chartStackView.addArrangedSubview(chartTitleTextView)
        chartStackView.addArrangedSubview(chartView)
        
        chartTitleTextView.heightAnchor.constraint(equalTo: chartStackView.heightAnchor, multiplier: 0.07).isActive = true
        chartView.heightAnchor.constraint(equalTo: chartStackView.heightAnchor, multiplier: 0.93).isActive = true
    }
    
    func setUpChartView() {
        let lineChartDataSet = LineChartDataSet(entries: data)
        lineChartDataSet.circleRadius = 4
        lineChartDataSet.valueColors = valueColors
        lineChartDataSet.valueFont = UIFont(name: "DINAlternate-Bold", size: 12)!
        lineChartDataSet.drawFilledEnabled = true
        
        let chart = LineChartData()
        chart.addDataSet(lineChartDataSet)
        chart.setDrawValues(true)
        chartView.data = chart
        
        chartTitleTextView.text = chartTitle + " in recent \(mode) matches"
    }
}
