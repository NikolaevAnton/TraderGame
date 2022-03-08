//
//  ViewController.swift
//  TraderGame
//
//  Created by Anton Nikolaev on 07.03.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var presenter: SettingsPresenterProtocol!
    
//MARK: - UI Elements
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "панель управления"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = UIColor(named: "Dark")
        return label
    }()
    private lazy var downloadValuesInCurrentDayButton: UIButton = {
        let button = UIButton()
        button.creatorButton(title: "Загрузить значения")
        button.addTarget(self, action: #selector(downloadValuesInCurrentDay), for: .touchUpInside)
        return button
    }()
//MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SettingsPresenter(view: self)
        view.backgroundColor = UIColor(named: "LightGray")
        addSubviewsAndSetConstraints()
    }
    
    private func addSubviewsAndSetConstraints() {
        view.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        view.addSubview(downloadValuesInCurrentDayButton)
        downloadValuesInCurrentDayButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            downloadValuesInCurrentDayButton.topAnchor.constraint(
                equalTo: mainLabel.topAnchor, constant: 50),
            downloadValuesInCurrentDayButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 30),
            downloadValuesInCurrentDayButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -150)
        ])
    }
//MARK: - Command methods
    @objc private func downloadValuesInCurrentDay() {
        presenter.loadValuesInCurrentDay()
    }
}


//MARK: - Extension UI Elements
extension UIButton {
    func creatorButton(title: String) {
        let button = self
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor(named: "Dark"), for: .normal)
        button.backgroundColor = UIColor(named: "LightBlue")
        button.layer.cornerRadius = 10
    }
}

//MARK: - MVP extension
extension SettingsViewController: SettingsViewProtocol {
    func presentValuesInCurrentDay(_ values: [Crypto]) {
        print("Succses!!!!! load: \(values.count)")
    }
    
    
}

