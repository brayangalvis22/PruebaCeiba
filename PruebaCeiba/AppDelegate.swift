//
//  AppDelegate.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 7/12/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
//    self.window = UIWindow(frame: UIScreen.main.bounds)
//    let storyboard = UIStoryboard.init(name: "usuarios", bundle: nil)
//    let viewController = storyboard.instantiateViewController(withIdentifier: "usuariosViewController") as! usuariosViewController
//    let navigationController = UINavigationController.init(rootViewController: viewController)
//    self.window?.rootViewController = navigationController
//    
//    self.window?.makeKeyAndVisible()
    
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
  }

  // MARK: - Core Data stack

  lazy var persistentContainer: NSPersistentContainer = {

      let container = NSPersistentContainer(name: "PruebaCeiba")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {

              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
  }()

  // MARK: - Core Data Saving support

  func saveContext () {
      let context = persistentContainer.viewContext
      if context.hasChanges {
          do {
              try context.save()
          } catch {

              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
  }

}

