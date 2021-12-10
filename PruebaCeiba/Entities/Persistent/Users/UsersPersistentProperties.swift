//
//  UsersPersistentProperties.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 8/12/21.
//

import Foundation
import CoreData

extension UsersPersistent{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UsersPersistent> {
        return NSFetchRequest<UsersPersistent>(entityName: "UsersPersistent")
    }
  
  @NSManaged public var email: String
  @NSManaged public var idUser: Int
  @NSManaged public var name: String
  @NSManaged public var phone: String

}
