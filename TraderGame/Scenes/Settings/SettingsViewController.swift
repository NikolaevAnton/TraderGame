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
        label.creatorLabel(title: "панель управления", size: 25)
        return label
    }()
    private lazy var downloadValuesInCurrentDayButton: UIButton = {
        let button = UIButton()
        button.creatorButton(title: "Загрузить значения")
        button.addTarget(self, action: #selector(downloadValuesInCurrentDay), for: .touchUpInside)
        return button
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = UIColor(named: "Dark")
        indicator.style = .large
        return indicator
    }()
    private lazy var downloadAllValuesInOneYearHistoryButton: UIButton = {
        let button = UIButton()
        button.creatorButton(title: "История за год")
        button.isHidden = true
        button.addTarget(self, action: #selector(downloadAllValuesInOneYearHistory), for: .touchUpInside)
        return button
    }()
    private lazy var infoAboutLoadValuesLabel: UILabel = {
        let label = UILabel()
        label.creatorLabel(title: "", size: 25)
        label.isHidden = true
        return label
    }()
    private lazy var sortValuesButton: UIButton = {
        let button = UIButton()
        button.creatorButton(title: "Отстортировать")
        button.isHidden = true
        button.addTarget(self, action: #selector(sortValues), for: .touchUpInside)
        return button
    }()
    private lazy var goToMainVCButton: UIButton = {
        let button = UIButton()
        button.creatorButton(title: "Показать значения")
        button.isHidden = true
        button.addTarget(self, action: #selector(goToMainVC), for: .touchUpInside)
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
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: mainLabel.topAnchor, constant: 50),
            activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        view.addSubview(downloadAllValuesInOneYearHistoryButton)
        downloadAllValuesInOneYearHistoryButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            downloadAllValuesInOneYearHistoryButton.topAnchor.constraint(equalTo: downloadValuesInCurrentDayButton.topAnchor, constant: 40),
            downloadAllValuesInOneYearHistoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            downloadAllValuesInOneYearHistoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150)
        ])
        view.addSubview(infoAboutLoadValuesLabel)
        infoAboutLoadValuesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoAboutLoadValuesLabel.topAnchor.constraint(equalTo: downloadAllValuesInOneYearHistoryButton.topAnchor, constant: 40),
            infoAboutLoadValuesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            infoAboutLoadValuesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        view.addSubview(sortValuesButton)
        sortValuesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sortValuesButton.topAnchor.constraint(equalTo: infoAboutLoadValuesLabel.bottomAnchor, constant: 30),
            sortValuesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            sortValuesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150)
        ])
        view.addSubview(goToMainVCButton)
        goToMainVCButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            goToMainVCButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            goToMainVCButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            goToMainVCButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100)
        ])
    }
//MARK: - Command methods
    @objc private func downloadValuesInCurrentDay() {
        activityIndicator.startAnimating()
        presenter.loadValuesInCurrentDay()
    }
    
    @objc private func downloadAllValuesInOneYearHistory() {
        activityIndicator.startAnimating()
        presenter.loadValuesInOneYearHistory()
    }
    
    @objc private func sortValues() {
        activityIndicator.startAnimating()
        presenter.sortValuesInOneYearHistory()
    }
    
    @objc private func goToMainVC() {
        /*
        let mainViewController = MainViewController()
        mainViewController.modalPresentationStyle = .fullScreen
        self.present(mainViewController, animated: true)
        */
        let navigationView = NavigationViewController()
        navigationView.modalPresentationStyle = .fullScreen
        self.present(navigationView, animated: true)
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
extension UILabel {
    func creatorLabel(title: String, size: Int) {
        let label = self
        label.text = title
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: CGFloat(size))
        label.textColor = UIColor(named: "Dark")
    }
}

//MARK: - MVP extension
extension SettingsViewController: SettingsViewProtocol {

    func presentCountValuesInCurrentDay(_ countValues: Int) {
        print("Succses!!!!! load: \(countValues)")
        activityIndicator.stopAnimating()
        downloadValuesInCurrentDayButton.layer.opacity = 0.5
        downloadValuesInCurrentDayButton.isEnabled = true
        downloadAllValuesInOneYearHistoryButton.isHidden = false
    }
    
    func presentCountValuesInOneYearHistory(_ countValues: Int) {
        print("count values in one year history: \(countValues)")
        activityIndicator.stopAnimating()
        downloadAllValuesInOneYearHistoryButton.layer.opacity = 0.5
        downloadAllValuesInOneYearHistoryButton.isEnabled = true
        infoAboutLoadValuesLabel.isHidden = false
        infoAboutLoadValuesLabel.text = "count values in one year history: \(countValues)"
        sortValuesButton.isHidden = false
    }
    
    func presentResultForSortValues(_ countValues: Int) {
        print("Sort values!")
        activityIndicator.stopAnimating()
        sortValuesButton.layer.opacity = 0.5
        sortValuesButton.isEnabled = true
        infoAboutLoadValuesLabel.text?.append("\nsorted array. number of values in every day: \(countValues)")
        goToMainVCButton.isHidden = false
    }
}

