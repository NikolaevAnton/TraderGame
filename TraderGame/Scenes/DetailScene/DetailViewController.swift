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
    private var valueForTrade = ""
    private var maxCountValue = 0.0
   
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
    private var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.keyboardType = .numberPad
        return textField
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
        checkBuyOrSell()
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
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: changeLabel.topAnchor, constant: 50),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        

    }
    
//MARK: - command method

    @objc private func buy() {
        valueForTrade = textField.text ?? ""
        textField.text = ""
        guard let value = chechValueForBuy(value: valueForTrade) else { return }
        presenter.setCountValueForBuy(value: value)
    }
    
    @objc private func sell() {
        
    }
    
//MARK: - private support methods
    
    private func checkBuyOrSell() {
        if indexPath.section == 1 {
            presenter.setMaxCountForBuy()
            sellButton.isEnabled = true
            sellButton.layer.opacity = 0.5
        } else {
            buyButton.isEnabled = true
            buyButton.layer.opacity = 0.5
        }
    }
    
    private func chechValueForBuy(value: String) -> Double? {
        guard let valueDouble = Double(value) else { return nil }
        if valueDouble > maxCountValue {
            return nil
        }
        if valueDouble <= 0 {
            return nil
        }
        return valueDouble
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
    
    func presentMaxCountForBuy(maxCount: String) {
        maxCountValue = Double(maxCount) ?? 0.0
        textField.placeholder = "max count: \(maxCount)"
    }
    
}
