// I was unable to get this test to work, but I'm leaving it in as a reminder for the future.

//import XCTest
//
//class ObservablePublishedTests: UITest {
//    func testObservablePublishedMetric() throws {
//        selectTest("Observable Published")
//
//        measure(metrics: [XCTCPUMetric(application: app)]) {
//            app.children(matching: .any).firstMatch.slowSwipeDown(offset: 0.5, distance: 0.1)
//
//            // Ensure the searchbar exists.
//            let navBar = app.navigationBars.firstMatch
//            XCTAssertTrue(navBar.children(matching: .searchField).firstMatch.exists, "Searchbar exists")
//        }
//    }
//}
