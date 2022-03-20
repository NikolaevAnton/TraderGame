//
//  MainViewController.swift
//  TraderGame
//
//  Created by Anton Nikolaev on 16.03.2022.
//

import UIKit

class MainViewController: UIViewController, UINavigationBarDelegate {

    var presenter: MainPresenterProtocol!
    private let cellID = "cell"
    private var numbersRowsInFirstSection = 0
    private var numbersRowsInSecondSection = 0
    private var arrayValuesYoyMoney = [String]()
    private var arrayValuesCrypto = [String]()
    private var dateString = ""
    private var sortString = ""
    
//MARK: - UI Elements
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
        tableView.backgroundColor = UIColor(named: "LightGray")
        return tableView
    }()
    private var infoLabel: UILabel = {
        let label = UILabel()
        label.creatorLabel(title: "", size: 25)
        return label
    }()

 
//MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createToolBar()
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
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.loadValuesInCurrentDay()
        presenter.loadStringValuesCrypto()
        tableView.reloadData()
    }
    
    private func addSubviewsAndSetConstraints() {


        view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: infoLabel.topAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)
        ])
        

    }


    private func createToolBar() {
        self.navigationController?.isToolbarHidden = false
        var items = [UIBarButtonItem]()
        let sortButton = UIBarButtonItem(title: "Sort values", style: .plain, target: self, action:  #selector(sort))
        let nextDayButton = UIBarButtonItem(title: "Next day", style: .plain, target: self, action: #selector(nextDay))
        items.append(sortButton)
        items.append(nextDayButton)
        self.toolbarItems = items
    }
    
//MARK: - Command methods

    @objc private func sort() {
        presenter.sortValues()
    }
    
    @objc private func nextDay() {
        presenter.changeDay()
        tableView.reloadData()
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
        detail.indexPath = indexPath
        detail.day = dateString
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
        dateString = value
        infoLabel.text = "\(dateString) Sort: \(sortString)"
    }
    
    func presentSort(sort: String) {
        var sortValue = ""
        switch sort {
        case "inAscendingOrder":
            sortValue = "acending"
        case "descendingValues":
            sortValue = "descending"
        default:
            sortValue = "shufle"
        }
        sortString = sortValue
        infoLabel.text = "\(dateString) Sort: \(sortString)"
        tableView.reloadData()
    }
}
