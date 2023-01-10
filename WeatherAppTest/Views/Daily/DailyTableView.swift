//
//  DailyTableView.swift
//  WeatherAppTest
//
//  Created by Evgenii Lukin on 26.12.2022.
//

import UIKit

class DailyTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    private let reuseIdTableView = "DailyTableViewCell"
    
    var cells: [CurrentWeatherViewModel.Daily]?
    
    init() {
        super.init(frame: .zero, style: .plain)
        
        configure()
    }

    private func configure() {
        
        separatorColor = #colorLiteral(red: 0.2470588235, green: 0.5176470588, blue: 0.8666666667, alpha: 1)
        backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.5176470588, blue: 0.8666666667, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
        bounces = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        delaysContentTouches = false

        delegate = self
        dataSource = self
        
        register(DailyTableViewCell.self, forCellReuseIdentifier: reuseIdTableView)
    }
    
    func setWeather(cells: [CurrentWeatherViewModel.Daily]) {
        self.cells = cells
        reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cells = cells else { return 7 }
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdTableView, for: indexPath) as? DailyTableViewCell else { return UITableViewCell() }
        
        guard let cells = cells else { return cell }
       
        cell.configereCell(model: cells[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       32
    }
}
