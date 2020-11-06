import XCTest

class PlaceholderTests: UITest {
    func testPlaceholder() throws {
        // Setup test state.
        selectTest("Placeholder")
        app.children(matching: .any).firstMatch.slowSwipeDown(offset: 0.5, distance: 0.1)

        // Ensure the searchbar exists.
        XCTAssertTrue(app.navigationBars.firstMatch.children(matching: .searchField).firstMatch.exists, "Searchbar exists")
        let searchBar = app.navigationBars.firstMatch.children(matching: .searchField).firstMatch

        // Test that tapping the button changes the placeholder text.
        let value = searchBar.placeholderValue
        app.buttons["placeholder button"].tap()
        XCTAssertNotEqual(value, searchBar.placeholderValue, "placeholder text updated")
    }
}
