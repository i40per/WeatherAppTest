//
//  DetailsViewController.swift
//  WeatherAppTest
//
//  Created by Evgenii Lukin on 25.12.2022.
//

import UIKit

protocol WeatherDisplayLogic: AnyObject {
    func displayData(viewModel: WeatherEnum.Model.ViewModel.ViewModelData)
}

class DetailsViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let sityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "New York"
        label.textColor = .white
        label.font = .proDisplayRegular34()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let temperatureNameLabel: UILabel = {
        let label = UILabel()
        label.text = "7°"
        label.textColor = .white
        label.font = .proDisplayThin96()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let feelingFirstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Mostly"
        label.textColor = .white
        label.font = .proDisplayMedium20()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let feelingSecondNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Cloudy"
        label.textColor = .white
       label.font = .proDisplayMedium20()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let highNameLabel: UILabel = {
        let label = UILabel()
        label.text = "H:8°"
        label.textColor = .white
        label.font = .proDisplayRegular20()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lowNameLabel: UILabel = {
        let label = UILabel()
        label.text = "L:0°"
        label.textColor = .white
        label.font = .proDisplayRegular20()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var generalWeatherStackView = UIStackView()
    private var generalWeatherStackViewVerticalOne = UIStackView()
    private var generalWeatherStackViewVerticalTwo = UIStackView()
    
    private var hourlyCollectionView = HourlyCollectionView()
    private var dailyTableView = DailyTableView()
    private var todayDescriptView = TodayDescriptView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupNavigationBar()
        setupViews()
        setConstraints()
    }
    
    //MARK: - setupStackView
    
    private func setupStackView() {
        
        generalWeatherStackView = UIStackView (arrangedSubviews: [sityNameLabel,
                                                                  temperatureNameLabel],
                                               axis: .vertical,
                                               spacing: 0,
                                               distribution: .fillProportionally)
        
        generalWeatherStackViewVerticalOne = UIStackView (arrangedSubviews: [feelingFirstNameLabel],
                                                          axis: .horizontal,
                                                          spacing: 5,
                                                          distribution: .fillProportionally)
        
        generalWeatherStackViewVerticalTwo = UIStackView (arrangedSubviews: [highNameLabel],
                                                          axis: .horizontal,
                                                          spacing: 11,
                                                          distribution: .fillProportionally)
    }
    
    //MARK: - SetupViews
    
    private func setupViews() {
        
        setupStackView()
       
        view.backgroundColor = #colorLiteral(red: 0.2473781407, green: 0.5174627304, blue: 0.8661645055, alpha: 1)
        
        view.addSubview(scrollView)
        scrollView.addSubview(generalWeatherStackView)
        scrollView.addSubview(generalWeatherStackViewVerticalOne)
        scrollView.addSubview(generalWeatherStackViewVerticalTwo)
        scrollView.addSubview(hourlyCollectionView)
        scrollView.addSubview(dailyTableView)
        scrollView.addSubview(todayDescriptView)
        
        todayDescriptView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - SetupNavigationBar
    
    private func setupNavigationBar() {
        
        navigationItem.backButtonTitle = ""
        navigationItem.titleView = createCustomTitleView()
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = true

        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.standardAppearance.backgroundColor = #colorLiteral(red: 0.2473781407, green: 0.5174627304, blue: 0.8661645055, alpha: 1)
            navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = #colorLiteral(red: 0.2449371815, green: 0.5191996098, blue: 0.8660232425, alpha: 1)
        }
    }
    
    private func createCustomTitleView() -> UIView {
        let view = UIView()
        let heightNavBar = navigationController?.navigationBar.frame.height ?? 0
        let widthNavBar = navigationController?.navigationBar.frame.width ?? 0
        view.frame = CGRect(x: 0, y: 0, width: widthNavBar, height: heightNavBar - 10)
        return view
    }
    
    func setsParameterss(model: CurrentWeatherViewModel) {
            self.sityNameLabel.text = model.locality
            self.temperatureNameLabel.text = model.temp
            self.highNameLabel.text = model.maxMinLabel
            self.feelingFirstNameLabel.text = model.weatherDescription
            
        self.hourlyCollectionView.setWeather(cells: model.hourlyWeather)
        self.dailyTableView.setWeather(cells: model.dailyWeather)
        }
    
    func setsParameterWeather(model: CurrentWeather) {
        self.sityNameLabel.text = model.cityName
        self.temperatureNameLabel.text = model.temperatureString
        self.highNameLabel.text = "H: \(model.tempMax)" + " " + "L: \(model.tempMin)"
        self.feelingFirstNameLabel.text = model.weatherDescription
        }
    }


//MARK: - SetConstraints

extension DetailsViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            generalWeatherStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            generalWeatherStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            generalWeatherStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            generalWeatherStackView.heightAnchor.constraint(equalToConstant: 155),
            
            generalWeatherStackViewVerticalOne.topAnchor.constraint(equalTo: generalWeatherStackView.bottomAnchor, constant: 0),
            generalWeatherStackViewVerticalOne.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generalWeatherStackViewVerticalOne.heightAnchor.constraint(equalToConstant: 24),
            
            generalWeatherStackViewVerticalTwo.topAnchor.constraint(equalTo: generalWeatherStackViewVerticalOne.bottomAnchor, constant: 1),
            generalWeatherStackViewVerticalTwo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generalWeatherStackViewVerticalTwo.heightAnchor.constraint(equalToConstant: 26),
            
            hourlyCollectionView.topAnchor.constraint(equalTo: generalWeatherStackViewVerticalTwo.bottomAnchor, constant: 100),
            hourlyCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width),
            hourlyCollectionView.heightAnchor.constraint(equalToConstant: 117),
            
            dailyTableView.topAnchor.constraint(equalTo: hourlyCollectionView.bottomAnchor, constant: 1),
            dailyTableView.widthAnchor.constraint(equalToConstant: view.frame.width),
            dailyTableView.heightAnchor.constraint(equalToConstant: 230),
            
            todayDescriptView.topAnchor.constraint(equalTo: dailyTableView.bottomAnchor, constant: 1),
            todayDescriptView.widthAnchor.constraint(equalToConstant: view.frame.width),
            todayDescriptView.heightAnchor.constraint(equalToConstant: 380),
            todayDescriptView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0)
        ])
    }
}
