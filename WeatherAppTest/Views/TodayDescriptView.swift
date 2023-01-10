//
//  TodayDescriptView.swift
//  WeatherAppTest
//
//  Created by Evgenii Lukin on 27.12.2022.
//

import UIKit

class TodayDescriptView: UIView {
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2449371815, green: 0.5191996098, blue: 0.8660232425, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let firstLabel = UILabel(text: "Cloudy conditions will continue all day. Wind gusts are up ti 9 mph",
                                     font: UIFont.proDisplayRegular17(),
                                     color: .white,
                                     line: 3)
    
    private let sunriseLabel = UILabel(text: "SUNRISE",
                                       font: UIFont.proDisplayRegular13(),
                                       color: .white.withAlphaComponent(0.5),
                                       line: 1)
    
    private let sunriseTimeLabel = UILabel(text: "07:05",
                                           font: UIFont.proDisplayRegular28(),
                                           color: .white,
                                           line: 1)
    
    private let sunsetLabel = UILabel(text: "SUNSET",
                                      font: UIFont.proDisplayRegular13(),
                                      color: .white.withAlphaComponent(0.5),
                                      line: 1)
    
    private let sunsetTimeLabel = UILabel(text: "19:05",
                                          font: UIFont.proDisplayRegular28(),
                                          color: .white,
                                          line: 1)
    
    private let chanceLabel = UILabel(text: "CHANCE OF RAIN",
                                      font: UIFont.proDisplayRegular13(),
                                      color: .white.withAlphaComponent(0.5),
                                      line: 1)
    
    private let chanceProcentLabel = UILabel(text: "10%",
                                             font: UIFont.proDisplayRegular28(),
                                             color: .white,
                                             line: 1)
    
    private let humbityLabel = UILabel(text: "HUMDITY",
                                       font: UIFont.proDisplayRegular13(),
                                       color: .white.withAlphaComponent(0.5),
                                       line: 1)
    
    private let humbityProcentLabel = UILabel(text: "58%",
                                              font: UIFont.proDisplayRegular28(),
                                              color: .white,
                                              line: 1)
    
    private let windLabel = UILabel(text: "WIND",
                                    font: UIFont.proDisplayRegular13(),
                                    color: .white.withAlphaComponent(0.5),
                                    line: 1)
    
    private let windSpeedLabel = UILabel(text: "s 3 km/hr",
                                         font: UIFont.proDisplayRegular28(),
                                         color: .white,
                                         line: 1)
    
    private let feelLikeLabel = UILabel(text: "FEELS LIKE",
                                        font: UIFont.proDisplayRegular13(),
                                        color: .white.withAlphaComponent(0.5),
                                        line: 1)
    
    private let feelLikeProcentLabel = UILabel(text: "3°",
                                               font: UIFont.proDisplayRegular28(),
                                               color: .white,
                                               line: 1)
    
    private let precipitationLabel = UILabel(text: "PRECIPITATION",
                                             font: UIFont.proDisplayRegular13(),
                                             color: .white.withAlphaComponent(0.5),
                                             line: 1)
    
    private let preNumberLabel = UILabel(text: "0 cm",
                                         font: UIFont.proDisplayRegular28(),
                                         color: .white,
                                         line: 1)
    
    private let pressureLabel = UILabel(text: "PRESSURE",
                                        font: UIFont.proDisplayRegular13(),
                                        color: .white.withAlphaComponent(0.5),
                                        line: 1)
    
    private let pressureNumberLabel = UILabel(text: "1025 hPa",
                                              font: UIFont.proDisplayRegular28(),
                                              color: .white,
                                              line: 1)
    
    private let visibilityLabel = UILabel(text: "VISIBILITY",
                                          font: UIFont.proDisplayRegular13(),
                                          color: .white.withAlphaComponent(0.5),
                                          line: 1)
    
    private let visibilityNumberLabel = UILabel(text: "16.1 km",
                                                font: UIFont.proDisplayRegular28(),
                                                color: .white,
                                                line: 1)
    
    private let uvLabel = UILabel(text: "UV INDEX",
                                  font: UIFont.proDisplayRegular13(),
                                  color: .white.withAlphaComponent(0.5),
                                  line: 1)
    
    private let uvNumberLabel = UILabel(text: "0",
                                        font: UIFont.proDisplayRegular28(),
                                        color: .white,
                                        line: 1)
    
    private let oneLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let twoLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let threeLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let fourLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let fiveLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var sunriseStack = UIStackView()
    private var sunsetStack = UIStackView()
    private var chanceStack = UIStackView()
    private var humbityStack = UIStackView()
    private var windLabelStack = UIStackView()
    private var feelLikeStack = UIStackView()
    private var precipitationStack = UIStackView()
    private var pressureStack = UIStackView()
    private var visibilityStack = UIStackView()
    private var uvStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStackView()
        setupViews()
        setConstraints()
    }
    
    private func setupStackView() {
        sunriseStack = UIStackView(arrangedSubviews: [sunriseLabel,
                                                      sunriseTimeLabel],
                                   axis: .vertical,
                                   spacing: 1,
                                   distribution: .fillProportionally)
        
        sunsetStack = UIStackView(arrangedSubviews: [sunsetLabel,
                                                     sunsetTimeLabel],
                                  axis: .vertical,
                                  spacing: 1,
                                  distribution: .fillProportionally)
        
        chanceStack = UIStackView(arrangedSubviews: [chanceLabel,
                                                     chanceProcentLabel],
                                  axis: .vertical,
                                  spacing: 1,
                                  distribution: .fillProportionally)
        
        humbityStack = UIStackView(arrangedSubviews: [humbityLabel,
                                                      humbityProcentLabel],
                                   axis: .vertical,
                                   spacing: 1,
                                   distribution: .fillProportionally)
        
        windLabelStack = UIStackView(arrangedSubviews: [windLabel,
                                                        windSpeedLabel],
                                     axis: .vertical,
                                     spacing: 1,
                                     distribution: .fillProportionally)
        
        feelLikeStack = UIStackView(arrangedSubviews: [feelLikeLabel,
                                                       feelLikeProcentLabel],
                                    axis: .vertical,
                                    spacing: 1,
                                    distribution: .fillProportionally)
        
        precipitationStack = UIStackView(arrangedSubviews: [precipitationLabel,
                                                            preNumberLabel],
                                         axis: .vertical,
                                         spacing: 1,
                                         distribution: .fillProportionally)
        
        pressureStack = UIStackView(arrangedSubviews: [pressureLabel,
                                                       pressureNumberLabel],
                                    axis: .vertical,
                                    spacing: 1,
                                    distribution: .fillProportionally)
        
        visibilityStack = UIStackView(arrangedSubviews: [visibilityLabel,
                                                         visibilityNumberLabel],
                                      axis: .vertical,
                                      spacing: 1,
                                      distribution: .fillProportionally)
        
        uvStack = UIStackView(arrangedSubviews: [uvLabel,
                                                 uvNumberLabel],
                              axis: .vertical,
                              spacing: 1,
                              distribution: .fillProportionally)
    }
    
    private func setupViews() {
        
        backgroundColor = .white.withAlphaComponent(0.4)
        
        addSubview(backgroundView)
        
        backgroundView.addSubview(firstLabel)
        backgroundView.addSubview(oneLineView)
        
        backgroundView.addSubview(sunriseStack)
        backgroundView.addSubview(sunsetStack)
        backgroundView.addSubview(twoLineView)

        backgroundView.addSubview(chanceStack)
        backgroundView.addSubview(humbityStack)
        backgroundView.addSubview(threeLineView)

        backgroundView.addSubview(windLabelStack)
        backgroundView.addSubview(feelLikeStack)
        backgroundView.addSubview(fourLineView)

        backgroundView.addSubview(precipitationStack)
        backgroundView.addSubview(pressureStack)
        backgroundView.addSubview(fiveLineView)

        backgroundView.addSubview(visibilityStack)
        backgroundView.addSubview(uvStack)
    }
    
    func setParameters(model: CurrentWeatherViewModel) {
        firstLabel.text = model.weatherDescription
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            firstLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10),
            firstLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            firstLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            oneLineView.heightAnchor.constraint(equalToConstant: 1),
            oneLineView.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 10),
            oneLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            oneLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            sunriseStack.topAnchor.constraint(equalTo: oneLineView.bottomAnchor, constant: 5),
            sunriseStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            sunsetStack.topAnchor.constraint(equalTo: oneLineView.bottomAnchor, constant: 5),
            sunsetStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 193),

            twoLineView.heightAnchor.constraint(equalToConstant: 1),
            twoLineView.topAnchor.constraint(equalTo: sunriseStack.bottomAnchor, constant: 5),
            twoLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            twoLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            chanceStack.topAnchor.constraint(equalTo: twoLineView.bottomAnchor, constant: 5),
            chanceStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            humbityStack.topAnchor.constraint(equalTo: twoLineView.bottomAnchor, constant: 5),
            humbityStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 193),

            threeLineView.heightAnchor.constraint(equalToConstant: 1),
            threeLineView.topAnchor.constraint(equalTo: chanceStack.bottomAnchor, constant: 5),
            threeLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            threeLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            windLabelStack.topAnchor.constraint(equalTo: threeLineView.bottomAnchor, constant: 5),
            windLabelStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            feelLikeStack.topAnchor.constraint(equalTo: threeLineView.bottomAnchor, constant: 5),
            feelLikeStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 193),

            fourLineView.heightAnchor.constraint(equalToConstant: 1),
            fourLineView.topAnchor.constraint(equalTo: windLabelStack.bottomAnchor, constant: 5),
            fourLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            fourLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            precipitationStack.topAnchor.constraint(equalTo: fourLineView.bottomAnchor, constant: 5),
            precipitationStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            pressureStack.topAnchor.constraint(equalTo: fourLineView.bottomAnchor, constant: 5),
            pressureStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 193),

            fiveLineView.heightAnchor.constraint(equalToConstant: 1),
            fiveLineView.topAnchor.constraint(equalTo: precipitationStack.bottomAnchor, constant: 5),
            fiveLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            fiveLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            visibilityStack.topAnchor.constraint(equalTo: fiveLineView.bottomAnchor, constant: 5),
            visibilityStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            uvStack.topAnchor.constraint(equalTo: fiveLineView.bottomAnchor, constant: 5),
            uvStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 193),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
