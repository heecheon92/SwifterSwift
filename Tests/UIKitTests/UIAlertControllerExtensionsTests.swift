// UIAlertControllerExtensionsTests.swift - Copyright 2023 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(UIKit) && !os(watchOS)
import UIKit

final class UIAlertControllerExtensionsTests: XCTestCase {
    func testAddAction() {
        let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        let discardedResult = alertController.addAction(
            title: "ActionTitle",
            style: .destructive,
            isEnabled: false,
            handler: nil)

        XCTAssertNotNil(discardedResult)

        XCTAssertEqual(alertController.actions.count, 1)

        let action = alertController.actions.first

        XCTAssertEqual(action?.title, "ActionTitle")
        XCTAssertEqual(action?.style, .destructive)
        XCTAssertEqual(action?.isEnabled, false)
    }

    func testSelector() {}

    func testAddTextField() {
        let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)

        let selector = #selector(testSelector)

        alertController.addTextField(
            text: "TextField",
            placeholder: "PlaceHolder",
            editingChangedTarget: self,
            editingChangedSelector: selector)

        XCTAssertEqual(alertController.textFields?.count, 1)

        let textField = alertController.textFields?.first

        XCTAssertEqual(textField?.text, "TextField")
        XCTAssertEqual(textField?.placeholder, "PlaceHolder")
        XCTAssertNotNil(textField?.allTargets)
        XCTAssertNotNil(textField?.actions(forTarget: self, forControlEvent: .editingChanged))
    }

    func testMessageInit() {
        let alertController = UIAlertController(
            title: "Title",
            message: "Message",
            defaultActionButtonTitle: "Ok",
            tintColor: .blue)

        XCTAssertNotNil(alertController)

        XCTAssertEqual(alertController.title, "Title")
        XCTAssertEqual(alertController.message, "Message")
        XCTAssertEqual(alertController.view.tintColor, .blue)

        XCTAssertEqual(alertController.actions.count, 1)

        let defaultAction = alertController.actions.first

        XCTAssertEqual(defaultAction?.title, "Ok")
        XCTAssertEqual(defaultAction?.style, .default)
    }

    enum TestError: Error { case error }

    func testErrorInit() {
        let error = TestError.error

        let alertController = UIAlertController(
            title: "Title",
            error: error,
            defaultActionButtonTitle: "Ok",
            tintColor: .red)

        XCTAssertNotNil(alertController)

        XCTAssertEqual(alertController.title, "Title")
        XCTAssertEqual(alertController.message, error.localizedDescription)
        XCTAssertEqual(alertController.view.tintColor, .red)

        XCTAssertEqual(alertController.actions.count, 1)

        let defaultAction = alertController.actions.first

        XCTAssertEqual(defaultAction?.title, "Ok")
        XCTAssertEqual(defaultAction?.style, .default)
    }
}

#endif
