//
//  MainViewController.swift
//  WeatherAppTest
//
//  Created by Evgenii Lukin on 19.12.2022.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, WeatherDisplayLogic {

    private lazy var locationButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .none
        button.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let someBlackView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .proDisplayMedium25()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let myLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "Я здесь"
        label.font = .proDisplayMedium25()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "New York"
        label.font = .proDisplayRegular15()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Snow")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "7°"
        label.font = .proDisplayThin50()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.bounces = false
        tableView.separatorColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tableView.showsVerticalScrollIndicator = true
        tableView.delaysContentTouches = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var cityArray = ["Warsaw","Bucharest","Martuni","Budapest","Moscow","Kazan", "Astana", "Baikonur", "Ufa", "Minsk"]
    
    private var modelWeather = [CurrentWeather]()
    private var filtredArray = [CurrentWeather]()
    private var isFiltred = false
    private var locationStack = UIStackView()
    
    private let searchController = UISearchController()
    private let idTableViewCell = "idTableViewCell"
    
    private var isFiltered = false
    private var filteredArray = [IndexPath]()
    
    let detailViewController = DetailsViewController()
    var infractor: WeatherBisinessLogic?
    
    //MARK: - ViewWillAppear

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        infractor?.requestData(request: .getWeather)
        setupNavigationBar()
    }
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupViews()
        setDelegates()
        setConstraints()
        featchWeather()
        networkManager()
    }
    
    //MARK: - SetupViews
    
    private func setupViews() {
        
        let viewController = self
        
        let presenter = WeatherPresenter()
        let interactor = WeatherInteractor()
        
        viewController.infractor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        locationStack = UIStackView(arrangedSubviews: [cityLabel,
                                                       myLocationLabel],
                                    axis: .vertical,
                                    spacing: 3,
                                    distribution: .fillProportionally)
        
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        view.addSubview(someBlackView)
        someBlackView.addSubview(locationButton)
        someBlackView.addSubview(locationStack)
        someBlackView.addSubview(weatherImageView)
        someBlackView.addSubview(tempLabel)
        someBlackView.addSubview(tableView)
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: idTableViewCell)
    }
    
    //MARK: - SetDelegates
    
    private func setDelegates() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        searchController.searchBar.delegate = self
    }
    
    //MARK: - SetupNavigationBar
    
    private func setupNavigationBar() {
        
        let titleLabel = UILabel(text: "Weather",
                                 font: .proDisplayBold34(),
                                 color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                                 line: 0)
        
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationItem.searchController = searchController
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        navigationItem.backButtonTitle = ""
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        navigationItem.titleView = createCustomTitleView()
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.standardAppearance.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    private func networkManager() {
        NetworkManager.shared.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
           
            for wea in currentWeather {
                self.modelWeather.append(wea)
            }
            self.tableView.reloadData()
        }
    }
    
     func displayData(viewModel: WeatherEnum.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayWeather(currentWeatherViewModel: let currentWeatherViewModel):
            print(currentWeatherViewModel)
            self.setParameters(model: currentWeatherViewModel)
        }
    }
    
    private func setParameters(model: CurrentWeatherViewModel) {
       DispatchQueue.main.async {
           
            UIView.animate(withDuration: 0.8,
                           delay: 0.0,
                           options: [.allowUserInteraction],
                           animations: { () -> Void in
            })
            self.cityLabel.text = model.locality
            self.tempLabel.text = model.temp
            self.weatherImageView.image = UIImage(named: model.icon)
        }
    }
    
    private func createCustomTitleView() -> UIView {
        
        let view = UIView()
        let heightNavBar = navigationController?.navigationBar.frame.height ?? 0
        let widthNavBar = navigationController?.navigationBar.frame.width ?? 0
        view.frame = CGRect(x: 0, y: 0, width: widthNavBar, height: heightNavBar - 10)

        titleLabel.contentMode = .left
        titleLabel.frame = CGRect(x: 10, y: 0, width: widthNavBar , height: heightNavBar / 2)
        view.addSubview(titleLabel)
        return view
    }
    
    private func featchWeather() {
        NetworkManager.shared.fetchCurrentWeather(forRequestType: .cityName(city: self.cityArray))
        self.tableView.reloadData()
    }
    
    private func filtringRecipes(text: String) {
        for weather in modelWeather {
            if weather.cityName.lowercased().contains(text.lowercased()) {
                filtredArray.append(weather)
            }
        }
    }
    
    private func refreshData() {
        filtredArray.removeAll()
        isFiltred = false
        tableView.reloadData()
    }
    
    @objc private func locationButtonTapped() {
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

//MARK: - UISearchControllerDelegate

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        refreshData()
        isFiltred = (searchText.count > 0 ? true : false)
        filtringRecipes(text: searchText)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        refreshData()
    }
}

//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltred ? filtredArray.count : modelWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idTableViewCell, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        let model = isFiltred ? filtredArray[indexPath.row] : modelWeather[indexPath.row]
        cell.setParams(model: model)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = modelWeather[indexPath.row]
        let detailViewController = DetailsViewController()
        
        detailViewController.setsParameterWeather(model: model)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

//MARK: - SetConstraints

extension MainViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            someBlackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            someBlackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            someBlackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            someBlackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            locationButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            locationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            locationButton.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 1),
            
            locationStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            locationStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            weatherImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            weatherImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 192),
            
            tempLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tempLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: locationStack.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}
