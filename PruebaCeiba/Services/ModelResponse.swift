//
//  ModelResponse.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 7/12/21.
//

import Foundation


enum ModelResponse<T> {
    case success(result: T)
    case error(result: ErrorApp)
}
