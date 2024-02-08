//
//  StockTableViewCell.swift
//  stocksApp0412
//
//  Created by Meiir on 04.01.2024.
//

import UIKit

protocol StocksCellDelegate: AnyObject{
    func updateFavStocks(tiker: String, isFavourite: Bool)
}

class StockTableViewCell: UITableViewCell, StocksMangerDelegate{
    
    var stocksManager = StocksManager()
    weak var delegate: StocksCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        stocksManager.delegate = self
        setupUI()
     }
    
     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    var ticker: String? {
        didSet {
            guard let stockItem = ticker else {return}
            stocksImage.image = UIImage(named: stockItem)
            stocksNameLabel.text = stockItem
            stocksManager.fetchStocks(stocksName: stockItem)
        }
    }
    
    func updateUIofcompanyNameLabel(data: StockModel1){
        DispatchQueue.main.async {
            self.companyNameLabel.text = data.name
        }
    }
    
    func updateUIofcurrentPriceLabel(data: StockModel2){
        DispatchQueue.main.async {
            self.currentPriceLabel.text = data.currentPriceToString()
            self.dayDeltaLabel.text = data.dayDeltaToString()
            if data.hasIncreased(){
                self.dayDeltaLabel.textColor = .systemGreen
            }
            else{
                self.dayDeltaLabel.textColor = .systemRed
            }
        }
    }

    private let starButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "Fav"), for: .normal)
        button.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var isFavourite = false{
        didSet {
            updateBackgrounfOfTheButton()
        }
    }

    func updateBackgrounfOfTheButton(){
        let imageName = isFavourite ? "Star" : "Fav"
        starButton.setBackgroundImage(UIImage(named: imageName), for: .normal)
    }
    
    @objc private func starButtonTapped() {
        isFavourite.toggle()
        delegate?.updateFavStocks(tiker: stocksNameLabel.text ?? "tiker", isFavourite: self.isFavourite)
    }
    
    let stocksImage:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false 
        img.layer.cornerRadius = 8
        img.clipsToBounds = true
        return img
    }()
    
    let stocksNameLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
        }()
    
    let companyNameLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    let currentPriceLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textAlignment = .right
        return label
    }()
    
    let dayDeltaLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.14, green: 0.7, blue: 0.364, alpha: 1)
        label.text = "+55 ₽ (1,15%)"
        label.textAlignment = .right
        return label
    }()
    
    func setupUI(){
        self.contentView.layer.cornerRadius = 16
        self.contentView.addSubview(stocksImage)
        self.contentView.addSubview(stocksNameLabel)
        self.contentView.addSubview(companyNameLabel)
        self.contentView.addSubview(currentPriceLabel)
        self.contentView.addSubview(dayDeltaLabel)
        self.contentView.addSubview(starButton)
        
        NSLayoutConstraint.activate([
            stocksImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            stocksImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            stocksImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            stocksImage.widthAnchor.constraint(equalToConstant: 52),
            stocksImage.heightAnchor.constraint(equalToConstant: 52),
            
            stocksNameLabel.leadingAnchor.constraint(equalTo: self.stocksImage.trailingAnchor, constant: 12),
            stocksNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 14),
            stocksNameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -30),
            
            starButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 17),
            starButton.leadingAnchor.constraint(equalTo: self.stocksNameLabel.trailingAnchor, constant: 6),
            starButton.widthAnchor.constraint(equalToConstant: 16),
            starButton.heightAnchor.constraint(equalToConstant: 18),
            
            companyNameLabel.leadingAnchor.constraint(equalTo: self.stocksImage.trailingAnchor, constant: 12),
            companyNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 38),
            companyNameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -14),
            
            currentPriceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -17),
            currentPriceLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 14),
            currentPriceLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -30),
            
            dayDeltaLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            dayDeltaLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 38),
            dayDeltaLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -14),
        ])
    }

}
