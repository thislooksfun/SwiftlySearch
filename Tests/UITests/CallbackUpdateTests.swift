import XCTest

class CallbackUpdateTests: UITest {
    func testCallbackUpdate() throws {
        // Setup test state.
        selectTest("Callback Update")
        app.children(matching: .any).firstMatch.slowSwipeDown(offset: 0.5, distance: 0.1)

        // Ensure the searchbar exists.
        let navBar = app.navigationBars.firstMatch
        XCTAssertTrue(navBar.children(matching: .searchField).firstMatch.exists, "Searchbar exists")
        let searchBar = navBar.children(matching: .searchField).firstMatch

        // Test that changing the callbacks actually works.
        let searchVal = app.staticTexts["do search text"].label
        let cancelVal = app.staticTexts["do cancel text"].label

        app.buttons["callbacks button"].tap()

        searchBar.tap()
        searchBar.typeText("hello\n")
        XCTAssertNotEqual(searchVal, app.staticTexts["do search text"].label, "search callback updated")

        navBar.buttons["Cancel"].tap()
        XCTAssertNotEqual(cancelVal, app.staticTexts["do cancel text"].label, "cancel callback updated")

    }
}
