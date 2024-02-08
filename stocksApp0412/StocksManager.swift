//
//  StocksManager.swift
//  stocksApp0412
//
//  Created by Meiir on 04.01.2024.
//

import Foundation

protocol StocksMangerDelegate{
    func updateUIofcompanyNameLabel(data: StockModel1)
    func updateUIofcurrentPriceLabel(data: StockModel2)
}

struct StocksManager{
    var delegate: StocksMangerDelegate?
    let stocksURL = "https://finnhub.io/api/v1/stock/profile2?&token=cm9tq09r01qg39vor0hgcm9tq09r01qg39vor0i0"
    let stocksURL2 = "https://finnhub.io/api/v1/quote?&token=cm9tq09r01qg39vor0hgcm9tq09r01qg39vor0i0"
    
    func fetchStocks(stocksName: String) {
        let urlString = "\(stocksURL)&symbol=\(stocksName)"
        let urlString2 = "\(stocksURL2)&symbol=\(stocksName)"
        self.performRequest(link: urlString)
        self.performRequest2(link: urlString2)
    }
    
    private func performRequest(link: String) {
        guard let url = URL(string: link) else {
            print("Invalid URL")
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {
            data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            if let data = data, let companyData = self.parseJSON(unparsedData: data) {
                delegate?.updateUIofcompanyNameLabel(data: companyData)
            }
        }
        task.resume()
    }
    
    func parseJSON(unparsedData: Data) -> StockModel1?{
        let decoder = JSONDecoder()
        do{
            let parsedData = try decoder.decode(StockModel1.self, from: unparsedData)
            return parsedData
        } catch {
            print(error)
            return nil
        }
    }
    
    private func performRequest2(link: String) {
        guard let url = URL(string: link) else {
            print("Invalid URL")
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {
            data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            if let data = data, let companyData = self.parseJSON2(unparsedData: data) {
                self.delegate?.updateUIofcurrentPriceLabel(data: companyData)
            }
        }
        task.resume()
    }
    
    func parseJSON2(unparsedData: Data) -> StockModel2?{
        let decoder = JSONDecoder()
        do{
            let parsedData = try decoder.decode(StockModel2.self, from: unparsedData)
            return parsedData
        } catch {
            print(error)
            return nil
        }
    }
}
