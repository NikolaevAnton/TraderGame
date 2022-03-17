//
//  NavigationViewController.swift
//  TraderGame
//
//  Created by Anton Nikolaev on 17.03.2022.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([MainViewController()], animated: true)
    }
}
