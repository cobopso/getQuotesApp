//
//  QuotesVC.swift
//  getQuotesApp
//
//  Created by Nguyễn Hữu Khánh on 17/03/2021.
//

import UIKit

class QuotesVC: UIViewController {
    
    var padding = 20.0
    let screenWidth = UIScreen.main.bounds.width
    
    let networker = Networker()
    
    let background = UIImageView()
    let upOrnament = UIImageView()
    let downOrnament = UIImageView()
    let quote = UILabel()
    let containerButton = UIStackView()
    let button = UIButton()
    let randomButton = UIButton()
    
    var dataReceive = ""
    var dataRandom = "Default"
    
    override func loadView() {
        super.loadView()
        
        // setup UI
        addSubview()
        setupUI()
        
        // Even
        button.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)
        randomButton.addTarget(self, action: #selector(goNext(_:)), for: .touchUpInside)
        
        // configure quote
        configureQuote()
        
        // load data
        loadData()
        
    }
    
    
    //MARK:- Load data

    func loadData() {
        networker.getQuotes { [self] (kanye, error) -> () in
            if error != nil {
                self.dataRandom = "Error"
                return
            }
            self.dataRandom = kanye?.quote ?? "default"
        }
    }
    
    
    //MARK: - EVEN
    @objc func goBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @objc func goNext(_ sender: UIButton) {
        loadData()
        quote.text = dataRandom
    }
    
    func configureQuote() {
        quote.text = dataReceive
    }
    
    
    //MARK:- Setup User Interface
    
    func addSubview() {
        
        // Add subview
        ([background, upOrnament, quote, downOrnament, containerButton,]).forEach { view.addSubview($0)}
        [button, randomButton].forEach { containerButton.addArrangedSubview($0)}
        
        // Turn off auto Sizing
        ([background, upOrnament, quote, downOrnament,containerButton, button, randomButton]).forEach{ $0.translatesAutoresizingMaskIntoConstraints = false}
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
        
        // QUOTE
        quote.text = "Harry, Ron and Hermione is three troublest in Horwast but they have a nice friendship "
        quote.textAlignment = .center
        quote.font = UIFont(name: "UTM Ambrose", size: 24)
        quote.numberOfLines = 0
        
        
        NSLayoutConstraint.activate([
            quote.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            quote.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: CGFloat(padding)),
            quote.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -CGFloat(padding)),
        ])
        
        // Ornament
        upOrnament.image = UIImage(named: "upOrnament")
        upOrnament.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            upOrnament.widthAnchor.constraint(equalToConstant: 260),
            upOrnament.heightAnchor.constraint(equalTo: upOrnament.widthAnchor, multiplier: 1/6.7),
            upOrnament.bottomAnchor.constraint(equalTo: quote.topAnchor, constant: -20),
            upOrnament.centerXAnchor.constraint(equalTo: quote.centerXAnchor),
        ])
        
        downOrnament.image = UIImage(named: "downOrnament")
        downOrnament.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            downOrnament.widthAnchor.constraint(equalToConstant: 260),
            downOrnament.heightAnchor.constraint(equalTo: downOrnament.widthAnchor, multiplier: 1/6.7),
            downOrnament.topAnchor.constraint(equalTo: quote.bottomAnchor, constant: 20),
            downOrnament.centerXAnchor.constraint(equalTo: quote.centerXAnchor),
        ])
        
        // BUTTON
        
        NSLayoutConstraint.activate([
            containerButton.topAnchor.constraint(equalTo: downOrnament.bottomAnchor, constant: 20),
            containerButton.centerXAnchor.constraint(equalTo: downOrnament.centerXAnchor),
        ])
        containerButton.axis = .horizontal
        containerButton.alignment = .fill
        containerButton.distribution = .fillEqually
        containerButton.spacing = 20
        
        button.setTitle("BACK", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.titleLabel?.font = UIFont(name: "UTM Ambrose", size: 36)
        
        randomButton.setTitle("NEXT", for: .normal)
        randomButton.setTitleColor(.black, for: .normal)
        randomButton.setTitleColor(.lightGray, for: .highlighted)
        randomButton.titleLabel?.font = UIFont(name: "UTM Ambrose", size: 36)

    }
}
