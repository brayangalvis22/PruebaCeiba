//
//  postUser.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 9/12/21.
//

import Foundation

struct postUser: Decodable {
  var tittle: String
  var body: String
  
  
  private enum CodingKeys: CodingKey {
    case title
    case body
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.tittle = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
    self.body = try container.decodeIfPresent(String.self, forKey: .body) ?? ""
  }
}
