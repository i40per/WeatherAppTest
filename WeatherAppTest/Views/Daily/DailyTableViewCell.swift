//
//  DailyTableViewCell.swift
//  WeatherAppTest
//
//  Created by Evgenii Lukin on 26.12.2022.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    
    private let backgroundCell: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dayLabel: UILabel = {
       let label = UILabel()
        label.text = "Wednesday"
        label.font = UIFont.proDisplayRegular20()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Snow")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let humidityLabel: UILabel = {
       let label = UILabel()
        label.text = "80%"
        label.font = UIFont.proDisplayMedium13()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let degreeDayLabel: UILabel = {
       let label = UILabel()
        label.text = "14"
        label.font = UIFont.proDisplayMedium20()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let degreeNightLabel: UILabel = {
       let label = UILabel()
        label.text = "4"
        label.font = UIFont.proDisplayMedium20()
        label.textColor = .white.withAlphaComponent(0.4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(dayLabel)
        addSubview(weatherImageView)
        addSubview(humidityLabel)
        addSubview(degreeDayLabel)
        addSubview(degreeNightLabel)
    }
    
    func configereCell(model: CurrentWeatherViewModel.Daily) {
        dayLabel.text = String(model.dt)
        weatherImageView.image = UIImage(named: model.icon)
        degreeDayLabel.text = model.maxTemp
        degreeNightLabel.text = model.minTemp
        humidityLabel.text = String(model.humidity)
    }
}

extension DailyTableViewCell {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            weatherImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: 30),
            weatherImageView.heightAnchor.constraint(equalToConstant: 30),
            
            humidityLabel.trailingAnchor.constraint(equalTo: degreeDayLabel.leadingAnchor, constant: -45),
            humidityLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            degreeNightLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            degreeNightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            degreeDayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            degreeDayLabel.trailingAnchor.constraint(equalTo: degreeNightLabel.leadingAnchor, constant: -27),
        ])
    }
}
