import XCTest

class BindingTests: UITest {
    func testBinding() throws {
        // Setup test state.
        selectTest("Binding")
        app.children(matching: .any).firstMatch.slowSwipeDown(offset: 0.5, distance: 0.1)

        // Ensure the searchbar exists.
        XCTAssertTrue(app.navigationBars.firstMatch.children(matching: .searchField).firstMatch.exists, "Searchbar exists")
        let searchBar = app.navigationBars.firstMatch.children(matching: .searchField).firstMatch

        // Test that tapping the button changes the search text.
        let value = searchBar.value as! String
        app.buttons["state button"].tap()
        XCTAssertNotEqual(value, searchBar.value as! String, "search text updated")
    }
}
