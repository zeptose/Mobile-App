//
//  SearchViewModelTests.swift
//  UserModelTests
//
//  Created by Joshua Yu  on 12/13/23.
//

import XCTest
@testable import BusyBee

class SearchViewModelTests: XCTestCase {

    func testSearch() {
        let viewModel = SearchViewModel()
        let users: [User] = [
            User(id: "1", username: "John", bio: "Some bio", goals: [], posts: [], follows: []),
            User(id: "2", username: "Jane", bio: "Another bio", goals: [], posts: [], follows: []),
            User(id: "3", username: "Doe", bio: "Yet another bio", goals: [], posts: [], follows: [])
        ]
        viewModel.users = users

        viewModel.search(searchText: "john")

        XCTAssertEqual(viewModel.filteredUsers.count, 1)
        XCTAssertEqual(viewModel.filteredUsers[0].username, "John")
    }

    func testSearchCaseInsensitive() {
        let viewModel = SearchViewModel()
        let users: [User] = [
            User(id: "1", username: "John", bio: "Some bio", goals: [], posts: [], follows: []),
            User(id: "2", username: "Jane", bio: "Another bio", goals: [], posts: [], follows: []),
            User(id: "3", username: "Doe", bio: "Yet another bio", goals: [], posts: [], follows: [])
        ]
        viewModel.users = users

        viewModel.search(searchText: "DOE")

        XCTAssertEqual(viewModel.filteredUsers.count, 1)
        XCTAssertEqual(viewModel.filteredUsers[0].username, "Doe")
    }
}
