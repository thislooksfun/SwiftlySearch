import XCTest

class SearchTests: UITest {
    func testSearch() throws {
        // Setup test state.
        selectTest("Search")
        app.children(matching: .any).firstMatch.slowSwipeDown(offset: 0.5, distance: 0.1)


        // Ensure the searchbar exists.
        XCTAssertTrue(app.navigationBars.firstMatch.children(matching: .searchField).firstMatch.exists, "Searchbar exists")
        let searchBar = app.navigationBars.firstMatch.children(matching: .searchField).firstMatch

        // Ensure that searching actually works.
        searchBar.tap()
        XCTAssertEqual(app.tables.firstMatch.children(matching: .any).count, 5, "Initial table state")

        searchBar.typeText("h")
        XCTAssertEqual(app.tables.firstMatch.children(matching: .any).count, 3, "Searched table -- normal")

        searchBar.buttons["Clear text"].tap()
        searchBar.typeText("😄")
        XCTAssertEqual(app.tables.firstMatch.children(matching: .any).count, 1, "Searched table -- special")
    }
}
