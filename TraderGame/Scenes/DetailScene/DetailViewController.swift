//
//  DetailViewController.swift
//  TraderGame
//
//  Created by Anton Nikolaev on 17.03.2022.
//

import UIKit

class DetailViewController: UIViewController {

    var presenter: DetailPresenterProtocol!
    var indexPath: IndexPath!
    var day: String!
   
//MARK: - UI Elements
    private var infoLabel: UILabel = {
        let label = UILabel()
        label.creatorLabel(title: "", size: 20)
        label.textAlignment = .left
        return label
    }()
    private var changeLabel: UILabel = {
        let label = UILabel()
        label.creatorLabel(title: "", size: 15)
        label.textAlignment = .left
        return label
    }()
    private var buyButton: UIButton = {
        let button = UIButton()
        button.creatorButton(title: "Buy")
        button.addTarget(self, action: #selector(buy), for: .touchUpInside)
        return button
    }()
    private var sellButton: UIButton = {
        let button = UIButton()
        button.creatorButton(title: "Sell")
        button.addTarget(self, action: #selector(sell), for: .touchUpInside)
        return button
    }()
//MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "LightGray")
        presenter = DetailPresenter(view: self)
        presenter.setIndexPath(index: indexPath)
        presenter.setDate(day: day)
        presenter.getCryptoValue()
        presenter.getChangeHistory()
        addSubviewsAndSetConstraints()
    }
    
    private func addSubviewsAndSetConstraints() {
        view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        

        view.addSubview(buyButton)
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buyButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
            buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        
        view.addSubview(sellButton)
        sellButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sellButton.topAnchor.constraint(equalTo: buyButton.bottomAnchor, constant: 10),
            sellButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            sellButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        
        view.addSubview(changeLabel)
        changeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeLabel.topAnchor.constraint(equalTo: sellButton.bottomAnchor, constant: 20),
            changeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            changeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        

    }
    
//MARK: - command method

    @objc private func buy() {
        
    }
    
    @objc private func sell() {
        
    }

}



extension DetailViewController: DetailViewProtocol {
    
    
    func presentCrypto(name: String, price: String, count: String?) {
        infoLabel.text?.append("DATE: \(day ?? "")\n")
        infoLabel.text?.append("NAME: \(name)\n")
        infoLabel.text?.append("PRICE: \(price)\n")
        guard let count = count else {
            return
        }
        infoLabel.text?.append("COUNT: \(count)")
        
    }
    
    func presentWallet(name: String, price: String, count: String) {
        infoLabel.text?.append("YOU WALLET:\n")
        infoLabel.text?.append("NAME: \(name)\n")
        infoLabel.text?.append("COUNT: \(count)")
    }
    
    func presentChangeCourse(change: Double) {
        print("presentChangeCourse \(change)")
        if change >= 0.0 {
            print("rose")
            changeLabel.text?.append("currency rose by a percentage: \(change)")
            changeLabel.textColor = UIColor(named: "Green")
        } else {
            changeLabel.text?.append("currency fell by a percentage: \(change)")
            changeLabel.textColor = UIColor(named: "Red")
        }
    }
    
}
