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
        label.creatorLabel(title: "")
        label.textAlignment = .left
        return label
    }()
//MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        view.backgroundColor = UIColor(named: "LightGray")
        presenter = DetailPresenter(view: self)
        print("viewDidLoad. day: \(day ?? "") number: \(indexPath.row)")
        presenter.setIndexPath(index: indexPath)
        presenter.setDate(day: day)
        presenter.getCryptoValue()
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
    
    
}
