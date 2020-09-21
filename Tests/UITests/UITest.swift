import XCTest

class UITest: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test.
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func selectTest(_ name: String) {
        let btn = app.buttons[name]
        btn.tap()
        XCTAssertTrue(btn.waitForDisappearance())
    }
}
