//
//  PruebaCeibaTests.swift
//  PruebaCeibaTests
//
//  Created by Brayan Galvis on 7/12/21.
//

import XCTest
@testable import PruebaCeiba

class PruebaCeibaTests: XCTestCase {

  var userDataBuilder: UsersDataBuilder!
  var userApiService: UserApiServices!
  var userViewModel: UsersViewModel!
  
  
  override func setUp() {
    super.setUp()
    userDataBuilder = UsersDataBuilder()
    userApiService = UserApiServices()
    userViewModel = UsersViewModel(userModel: userApiService!)
  }
  
  
  override func tearDown() {
    userDataBuilder = nil
    userApiService = nil
    userViewModel = nil
    super.tearDown()
  }
  
  
  func test_getUsersWithSuccessfulResponseWithZeroLocal() {
    let users: [Users] = []
    userViewModel.getUsers()
    userApiService.fetchSuccess(users)
    XCTAssertTrue(userViewModel.users.count == 0)
  }
  
  
  func test_getUsersWithSuccessfulResponseWithSomeLocal() {
    let users = loadUsers()
    userViewModel.getUsers()
    userApiService.fetchSuccess(users)
    XCTAssertTrue(userViewModel.users.count > 0)
  }
  
  func test_getUsersWithFailedResponseWithInternalError() {
    userViewModel.getUsers()
    userApiService.fetchFail(error: ErrorApp.init(code: "000", message: "A error ocurred, try later"))
    XCTAssertEqual(userViewModel.messageError, "A error ocurred, try later 000")
  }
  
  
  private func loadUsers() -> [Users] {
    var users: [Users] = []
    for _ in 0...10 {
      users.append(userDataBuilder.build())
    }
    return users
  }
  
}
