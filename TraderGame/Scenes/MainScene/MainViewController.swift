//
//  MainViewController.swift
//  TraderGame
//
//  Created by Anton Nikolaev on 16.03.2022.
//

import UIKit

class MainViewController: UIViewController {

//MARK: - UI Elements
    private lazy var tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
    private lazy var navigationBar: UINavigationBar = {
        let bar = UINavigationBar()
        let item = UINavigationItem(title: "Сортировка валют")
        let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(sort))
        item.setRightBarButton(button, animated: true)
        bar.items = [item]
        return bar
    }()

 
//MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "LightGray")
        
        addSubviewsAndSetConstraints()
    }
    
    private func addSubviewsAndSetConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let size = CGSize(width: view.frame.size.width, height: view.frame.size.height - 120)
        tableView.frame = CGRect.init(origin: .zero, size: size)
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }


    
//MARK: - Command methods

    @objc private func sort() {
        
    }
}
