//
//  HourlyCollectionViewCell.swift
//  WeatherAppTest
//
//  Created by Evgenii Lukin on 26.12.2022.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    lazy var backgroundCell: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2449371815, green: 0.5191996098, blue: 0.8660232425, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let hourLabel: UILabel = {
       let label = UILabel()
        label.text = "Now"
        label.font = .proDisplaySemibold15()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var weatherImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Snow")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let degreeLabel: UILabel = {
       let label = UILabel()
        label.text = "07"
        label.font = .proDisplaySemibold20()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let reuseId = "HourlyCollectionViewCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        addSubview(backgroundCell)
        backgroundCell.addSubview(hourLabel)
        backgroundCell.addSubview(weatherImageView)
        backgroundCell.addSubview(degreeLabel)
    }
    
    func configureCell(model: CurrentWeatherViewModel.Hourly) {
        hourLabel.text = model.dt
        weatherImageView.image = UIImage(named: model.icon)
        degreeLabel.text = model.temp
    }

    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),
            
            hourLabel.bottomAnchor.constraint(equalTo: weatherImageView.topAnchor, constant: -9),
            hourLabel.centerXAnchor.constraint(equalTo: backgroundCell.centerXAnchor),
            
            weatherImageView.centerXAnchor.constraint(equalTo: backgroundCell.centerXAnchor),
            weatherImageView.centerYAnchor.constraint(equalTo: backgroundCell.centerYAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: 30),
            weatherImageView.heightAnchor.constraint(equalToConstant: 30),
            
            degreeLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 8),
            degreeLabel.centerXAnchor.constraint(equalTo: backgroundCell.centerXAnchor),
        ])
    }
}
