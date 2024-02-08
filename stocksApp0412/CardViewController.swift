//
//  cardViewController.swift
//  stocksApp0412
//
//  Created by Meiir on 27.01.2024.
//

import UIKit

class CardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    var ticker: String
    init(t: String){
        self.ticker = t
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tikker:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.text = self.ticker
        label.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    let companyName:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.text = "Apple Inc."
        label.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    let chartLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.text = "Chart"
        label.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    let line: UIView = {
        let iv = UIView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .gray
        return iv
    }()
    
    private let starButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "Fav"), for: .normal)
        return button
    }()
    
    private let buyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.frame = CGRect(x: 300, y: 100, width: 300, height: 50)
        button.setTitle("Buy for $123.76", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    @objc private func buyButtonTapped() {
        print("buyButtonTapped")
    }
    
    let currentPrice:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$131.93"
        label.textColor = UIColor.black
        label.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        return label
    }()
    
    let dayDelta: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+$0.12 (1,15%)"
        label.textColor = UIColor(red: 0.14, green: 0.7, blue: 0.364, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    let chartView: UIView = {
        let iv = UIView()
        iv.frame = CGRect(x: 0, y: 0, width: 360, height: 260)
        iv.backgroundColor = .systemRed
        return iv
    }()
    
    func setupUI(){
        view.backgroundColor = UIColor.white
        view.addSubview(tikker)
        view.addSubview(companyName)
        view.addSubview(chartLabel)
        view.addSubview(currentPrice)
        view.addSubview(dayDelta)
        view.addSubview(starButton)
        view.addSubview(buyButton)
        view.addSubview(line)
        
        NSLayoutConstraint.activate([
            tikker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tikker.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
            
            companyName.topAnchor.constraint(equalTo: tikker.bottomAnchor, constant: 2),
            companyName.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
            
            chartLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            chartLabel.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 20),
            
            currentPrice.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 106),
            currentPrice.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
            
            dayDelta.topAnchor.constraint(equalTo: currentPrice.bottomAnchor, constant: 2),
            dayDelta.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
            
            line.topAnchor.constraint(equalTo: chartLabel.bottomAnchor, constant: 10),
            line.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            line.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            line.heightAnchor.constraint(equalToConstant: 2),
            
            buyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
            buyButton.widthAnchor.constraint(equalToConstant: 300),
            buyButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
    
