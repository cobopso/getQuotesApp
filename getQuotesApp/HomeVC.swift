//
//  ViewController.swift
//  getQuotesApp
//
//  Created by Nguyễn Hữu Khánh on 17/03/2021.
//

import UIKit

class HomeVC: UIViewController {
    
    let background = UIImageView()
    let button = UIButton()
    

    
    var dataToSend = "Data sent"
    
    let networker = Networker()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        // Hide nav
        self.navigationController?.isNavigationBarHidden = true
        
        addSubview()
        setupUI()
        
        // Even
        button.addTarget(self, action: #selector(goQuote(_:)), for: .touchUpInside)
        
        // load data
        loadData()
    }
    //MARK:- Load data

    func loadData() {
        networker.getQuotes { [self] (kanye, error) -> () in
            if error != nil {
                self.dataToSend = "Error"
                return
            }
            self.dataToSend = kanye?.quote ?? "default"
        }
    }

    
    
    //MARK:- Even
    
    @objc func goQuote(_ sender: UIButton) {
        loadData()
        let goQuoteVC = QuotesVC()
        goQuoteVC.dataReceive = dataToSend
        navigationController?.pushViewController(goQuoteVC, animated: true)
    }
    
    
    
    
    //MARK:- Setup User Interface
    
    func addSubview() {
        
        // Add subview
        ([background, button]).forEach { view.addSubview($0)}
        
        // Turn off auto Sizing
        ([background, button]).forEach{ $0.translatesAutoresizingMaskIntoConstraints = false}
    }
    func setupUI(){
        
        // Background
        background.image = UIImage(named: "background")
        background.contentMode = .scaleToFill
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        // Button
        button.setImage(UIImage(named: "button"), for: .normal)
        button.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 260),
            button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.5)
        ])
        
    }
}

