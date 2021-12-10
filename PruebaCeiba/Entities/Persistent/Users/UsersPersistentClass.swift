//
//  UsersPersistentClass.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 8/12/21.
//

import Foundation

import CoreData

@objc(UsersPersistent)
public class UsersPersistent: NSManagedObject {
   override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
          super.init(entity: entity, insertInto: context)
      }
}
