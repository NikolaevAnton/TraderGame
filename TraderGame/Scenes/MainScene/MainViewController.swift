//
//  MainViewController.swift
//  TraderGame
//
//  Created by Anton Nikolaev on 16.03.2022.
//

import UIKit

class MainViewController: UIViewController {

    var presenter: MainPresenterProtocol!
    private let cellID = "cell"
    private var numbersRowsInFirstSection = 0
    private var numbersRowsInSecondSection = 0
    private var arrayValuesYoyMoney = [String]()
    private var arrayValuesCrypto = [String]()
    
//MARK: - UI Elements
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
        tableView.backgroundColor = UIColor(named: "LightGray")
        return tableView
    }()
    
    private lazy var navigationBar: UINavigationBar = {
        let bar = UINavigationBar()
        let item = UINavigationItem(title: "Сортировка валют")
        let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(sort))
        item.setRightBarButton(button, animated: true)
        bar.items = [item]
        return bar
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.creatorLabel(title: "")
        return label
    }()

 
//MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MainPresenter(view: self)
        view.backgroundColor = UIColor(named: "LightGray")
        presenter.loadValuesInCurrentDay()
        presenter.loadStringValuesCrypto()
        presenter.loadStringValueDate()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        addSubviewsAndSetConstraints()
    }
    
    private func addSubviewsAndSetConstraints() {
        view.addSubview(tableView)
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
        
        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }


    
//MARK: - Command methods

    @objc private func sort() {
        
    }
}

//MARK: - Table View
extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return numbersRowsInFirstSection
        default:
            return numbersRowsInSecondSection
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        var content = cell.defaultContentConfiguration()
        switch indexPath.section {
        case 0:
            print(arrayValuesYoyMoney[indexPath.row])
            content.text = arrayValuesYoyMoney[indexPath.row]
        default:
            content.text = arrayValuesCrypto[indexPath.row]
        }
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Ваш кошелек"
        default:
            return "Список криптовалют"
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detail = DetailViewController()
        navigationController?.pushViewController(detail, animated: true)
    }
}
//MARK: - MVP extension
extension MainViewController : MainViewProtocol {

    func presentCountValuesInCurrentDay(countValuesYourCrypto: Int, countValuesInternetCrypto: Int) {
        numbersRowsInFirstSection = countValuesYourCrypto
        numbersRowsInSecondSection = countValuesInternetCrypto
    }

    func presentStringsValuesCrypto(valuesYouMoney: [String], valuesCrypto: [String]) {
        arrayValuesYoyMoney = valuesYouMoney
        arrayValuesCrypto = valuesCrypto
    }
    
    func presenterLoadStringValueForDate(value: String) {
        dateLabel.text = value
    }
}
