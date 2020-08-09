import XCTest

class SearchTests: UITest {
    func testSearch() throws {
        XCTAssertTrue(app.navigationBars.firstMatch.children(matching: .searchField).firstMatch.exists, "Searchbar exists")
        let searchBar = app.navigationBars.firstMatch.children(matching: .searchField).firstMatch
        searchBar.tap()

        XCTAssertEqual(app.tables.firstMatch.children(matching: .any).count, 5, "Initial table state")

        searchBar.typeText("h")
        XCTAssertEqual(app.tables.firstMatch.children(matching: .any).count, 3, "Searched table -- normal")

        searchBar.buttons["Clear text"].tap()
        searchBar.typeText("😄")
        XCTAssertEqual(app.tables.firstMatch.children(matching: .any).count, 1, "Searched table -- special")
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
