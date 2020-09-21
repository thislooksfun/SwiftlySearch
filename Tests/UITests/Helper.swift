import XCTest

extension XCUIElement {
    func slowSwipeDown(offset: CGFloat = 0, distance: CGFloat = 5) {
        let start = coordinate(withNormalizedOffset:  CGVector(dx: 0.0, dy: offset))
        let finish = coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: offset + distance))
        start.press(forDuration: 0.5, thenDragTo: finish)
    }

    // Taken from https://github.com/devexperts/screenobject/blob/4a0514ffba5599577679d026a856ad91dc494e40/Sources/ScreenObject/XCTestExtensions/XCUIElement%2BExtensions.swift#L39-L54
    /// Waits the specified amount of time for the element’s exists property to become false.
    ///
    /// - Returns: `false` if the timeout expires and the element still exists.
    func waitForDisappearance(timeout: TimeInterval = 3) -> Bool {
        return XCTContext.runActivity(named: "Waiting \(timeout)s for \(self) to disappear") { _ in
            let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == false"),
                                                        object: self)
            let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
            switch result {
            case .completed:
                return true
            default:
                return false
            }
        }
    }
}
