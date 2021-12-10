//
//  UsuariosPersistentProperties.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 8/12/21.
//

import Foundation
import CoreData

extension UsuarioPersistent{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UsuarioPersistent> {
        return NSFetchRequest<UsuarioPersistent>(entityName: "UsuarioPersistent")
    }
  
  @NSManaged public var email: String
  @NSManaged public var idUsuario: Int
  @NSManaged public var name: String
  @NSManaged public var phone: String

}
