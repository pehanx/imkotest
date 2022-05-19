//
//  BaseTabBarController.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import Foundation
import UIKit

class BaseTabBarController:UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    private func setupControllers(){
        UITabBar.appearance().backgroundColor = R.color.border()
        tabBar.isTranslucent = false
        
        viewControllers = [
            createController(viewController: HistoryViewContoller(), title: "Historial", image: R.image.tabBar.history()),
            createController(viewController: NewLoanViewController(), title: "Nuevo préstamo", image: R.image.tabBar.loan()),
            createController(viewController: ProfileViewController(), title: "Perfil", image: R.image.tabBar.profile()),
            createController(viewController: HelpViewController(), title: "Asistencia", image: R.image.tabBar.help()),
        ]
    }
    
    private func createController(viewController: UIViewController, title:String, image:UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.isNavigationBarHidden = true
        navController.tabBarItem.image = image
        navController.tabBarItem.title = title
        tabBar.tintColor = R.color.lightBlue()
        tabBar.unselectedItemTintColor = R.color.gray()
        return navController
    }
}
