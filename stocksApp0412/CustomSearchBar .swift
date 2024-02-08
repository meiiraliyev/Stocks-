//
//  CustomSearchBar .swift
//  stocksApp0412
//
//  Created by Meiir on 16.01.2024.
//

import Foundation
import UIKit

final class CustomSearchBar: UIView{
    weak var viewControllerDelegate: UITextFieldDelegate?{
        didSet{
            textField.delegate = viewControllerDelegate!
        }
    }
    
    init(){
        super.init(frame: .zero)
        self.layer.cornerRadius = 25
        self.layer.borderWidth = 1
        super.layer.borderColor = CGColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let searchImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "Search"))
        return iv
    }()
    
    let  textField: UITextField = {
        
        let tf =  UITextField()
//        tf.delegate = viewControllerDelegate!
        tf.text = "Find ticker"
        return tf 
    }()
    
    
    

    
    func setupUI(){
        self.addSubview(searchImage)
        self.addSubview(textField)
        searchImage.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            searchImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            searchImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textField.leftAnchor.constraint(equalTo: searchImage.rightAnchor, constant: 8),

        ])
        
    }
}

