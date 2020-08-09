import XCTest

class BindingTests: UITest {
    func testBinding() throws {
        XCTAssertTrue(app.navigationBars.firstMatch.children(matching: .searchField).firstMatch.exists, "Searchbar exists")
        let searchBar = app.navigationBars.firstMatch.children(matching: .searchField).firstMatch

        XCTAssertNotEqual(searchBar.value as! String, "yay", "Initial state")
        app.buttons["state button"].tap()
        XCTAssertEqual(searchBar.value as! String, "yay", "Set text")
    }
}
