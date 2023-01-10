//
//  TableViewCell.swift
//  WeatherAppTest
//
//  Created by Evgenii Lukin on 24.12.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Snow")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .proDisplayRegular15()
        label.textColor = .white
        label.text = "19:54"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .proDisplayRegular25()
        label.textColor = .white
        label.text = "London"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .proDisplayThin50()
        label.textColor = .white
        label.text = "-10°"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter
    }()
    
    private var locationStack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        locationStack = UIStackView(arrangedSubviews: [timeLabel,
                                                       locationLabel],
                                    axis: .vertical,
                                    spacing: 3,
                                    distribution: .fillProportionally)
        
        addSubview(weatherImageView)
        addSubview(locationStack)
        addSubview(temperatureLabel)
    }
    
    func setParams(model: CurrentWeather) {
        locationLabel.text = model.cityName
        temperatureLabel.text = setSign(temp: Int(model.temperatureString)!)
        weatherImageView.image = UIImage(named: model.icon)
        
        timeLabel.text = formatterData(dateFormat: "HH:mm", date: Double(model.dt))
    }
    
    private func setSign(temp: Int) -> String {
        var curTemp: String = ""
        
        guard temp > 1 else {
            curTemp = "\(temp)º";
            return curTemp }
        curTemp = "\(temp)º"
        return curTemp
    }
    
    private func formatterData(dateFormat: String, date: Double) -> String {
        dateFormatter.dateFormat = dateFormat
        let currentDate = NSDate(timeIntervalSince1970: date)
        let dateTitle = dateFormatter.string(from: currentDate as Date).capitalizedFirst()
        return dateTitle
    }
    
    //MARK: - SetConstraints
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            weatherImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 192),
            
            locationStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            locationStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
