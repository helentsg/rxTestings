//
//  AppDelegate.swift
//  rxTestings
//
//  Created by  Елена on 01.02.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }
    
}

extension AppDelegate {
    
    func setupWindow() {
        
        window = UIWindow()
        let viewModel = ImagesViewModel()
        let imagesViewController = ImagesViewController()
        imagesViewController.viewModel = viewModel
        window?.rootViewController = imagesViewController
        window?.makeKeyAndVisible()
        
    }
}
