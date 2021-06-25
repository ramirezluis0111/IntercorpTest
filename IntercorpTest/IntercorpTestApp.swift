//
//  IntercorpTestApp.swift
//  IntercorpTest
//
//  Created by Ramirez Luis on 20/06/2021.
//

import SwiftUI
import Firebase
import FBSDKCoreKit

@main
struct IntercorpTestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL(perform: { url in
                    ApplicationDelegate.shared.application(UIApplication.shared,
                                                           open: url, sourceApplication: nil,
                                                           annotation: UIApplication.OpenURLOptionsKey.annotation)
                })
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()

        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )

        return true
    }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )

    }

}
