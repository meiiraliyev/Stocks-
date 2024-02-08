//
//  ViewController.swift
//  stocksApp0412
//
//  Created by Meiir on 04.01.2024.
//

//1. Properties
//2. Lifecycle(init, override vievdidload...)
//3. UI
//4. Methods

import UIKit

final class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, StocksCellDelegate {
    private let allStocks: [String] = [
        "YNDX",
        "AAPL",
        "GOOGL",
        "AMZN",
        "BAC",
        "MSFT",
        "TSLA",
   ]
    
    private var stocks: [String] = []{
        didSet {
            stocsTableView.reloadData()
        }
    }

    private var favStocks: [String] = []{
        didSet {
            saveFavStocks()
        }
    }
    
    let favStocksKey: String = "FavStocks"
    
    var filteredStocks: [String] = []
    
    lazy var searchBar: UIView = {
        let v = CustomSearchBar()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.viewControllerDelegate = self
        return v
    }()
    
    func filterStocks(with searchText: String) {
        print(searchText)
        
        if toShowFavourites {
            stocks = searchText.isEmpty ? favStocks : allStocks.filter { $0.lowercased().contains(searchText.lowercased()) }
        } else {
            stocks = searchText.isEmpty ? allStocks : allStocks.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func updateFavStocks(tiker: String, isFavourite: Bool){
        if isFavourite{
            self.favStocks.append(tiker)
            print(favStocks)
        }
        else{
            self.favStocks.removeAll { $0 == tiker }
            print(favStocks)
        }
    }
    
    func saveFavStocks(){
        if let encodedData = try? JSONEncoder().encode(favStocks){
            UserDefaults.standard.set(encodedData, forKey: favStocksKey)
        }
    }
    
    func getFavStocks(){
        guard
            let data = UserDefaults.standard.data(forKey: favStocksKey),
            let savedStocks = try? JSONDecoder().decode([String].self, from: data)
        else {return}
        self.favStocks = savedStocks
    }
    
    private let stocksButton: UIButton = {
        let button = UIButton()
        button.setTitle("Stocks", for: .normal)
        button.setTitleColor(UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(stocksButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Favourite", for: .normal)
        button.setTitleColor(UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return button
    }()
    private var toShowFavourites = false
    
    func updateBackgrounfOfTheButton() {
        if toShowFavourites == false{
            stocksButton.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .bold)
            stocksButton.setTitleColor(UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0), for: .normal)
            favoriteButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            favoriteButton.setTitleColor(UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1.0), for: .normal)
        } else {
            stocksButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            stocksButton.setTitleColor(UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1.0), for: .normal)
            favoriteButton.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .bold)
            favoriteButton.setTitleColor(UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0), for: .normal)
        }
    }
    
    @objc
    private func stocksButtonTapped() {
        toShowFavourites = false
        updateBackgrounfOfTheButton()
        stocks = allStocks
    }
    
    @objc
    private func favoriteButtonTapped() {
        toShowFavourites = true
        updateBackgrounfOfTheButton()
        stocks = favStocks
    }
    
    let stocsTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupUI()
        self.stocks = allStocks
        DispatchQueue.global().async {
            self.getFavStocks()
        }
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "White") ?? UIColor.white
        view.addSubview(searchBar)
        view.addSubview(stocksButton)
        view.addSubview(favoriteButton)
        view.addSubview(stocsTableView)
        stocsTableView.separatorStyle = .none
        stocsTableView.translatesAutoresizingMaskIntoConstraints = false
        stocsTableView.register(StockTableViewCell.self, forCellReuseIdentifier: "stockCell")
        stocsTableView.dataSource = self
        stocsTableView.delegate = self
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            stocksButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            stocksButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            favoriteButton.leadingAnchor.constraint(equalTo: stocksButton.trailingAnchor, constant: 20),
            favoriteButton.bottomAnchor.constraint(equalTo: stocsTableView.topAnchor, constant: -10),
            
            stocsTableView.topAnchor.constraint(equalTo: stocksButton.bottomAnchor, constant: 20),
            stocsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stocsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stocsTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as! StockTableViewCell
        
        cell.ticker = stocks[indexPath.row]
        
        if favStocks.contains(cell.ticker ?? "ticker"){
            cell.isFavourite = true
        } else {
            cell.isFavourite = false
        }
        cell.backgroundColor = indexPath.row % 2 == 1 ? .white : UIColor(red: 0.941, green: 0.955, blue: 0.97, alpha: 1);
        cell.layer.cornerRadius = 16
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hello")
        let cardViewController = CardViewController(t: stocks[indexPath.row])
        navigationController?.pushViewController(cardViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let searchText =  string
        filterStocks(with: searchText)
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        textField.text=""
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.text="Find Ticker"
        filterStocks(with: "")
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        filterStocks(with: "")
        return true
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


//leaved comments
