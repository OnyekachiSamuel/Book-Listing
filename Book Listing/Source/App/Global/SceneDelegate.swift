//
//  SceneDelegate.swift
//  Book Listing
//
//  Created by Onyekachi Ezeoke on 01/04/2020.
//  Copyright © 2020 Onyekachi Ezeoke. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let bookListingController = BookListingController(style: .grouped)
        window?.rootViewController = bookListingController
        window?.makeKeyAndVisible()
    }
}

