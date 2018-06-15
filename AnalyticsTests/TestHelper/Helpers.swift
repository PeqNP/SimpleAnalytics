import AutoEquatable
import Foundation
import Nimble
import KIF
import UIKit
import XCTest

// MARK: - Types

extension UInt: AutoEquatable { }

// MARK: - View helpers

func createViewController<T: AnyObject>(_ type: T.Type, storyboardName: String, storyboardIdentifier: String) -> T {
    let bundle = Bundle(for: T.self)
    let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
    return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! T
}

public func testViewController(_ viewController: UIViewController) {
    UIApplication.shared.keyWindow?.layer.speed = 100
    for view in (UIApplication.shared.keyWindow?.subviews)! {
        view.removeFromSuperview()
    }
    UIApplication.shared.keyWindow?.rootViewController = viewController
    expect(true).toEventually(beTrue())
}

// MARK: - tester

extension XCTestCase {
    internal func tester(file: String = #file, _ line: Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    internal func system(file: String = #file, _ line: Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

extension KIFTestActor {
    internal func tester(file: String = #file, _ line: Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    internal func system(file: String = #file, _ line: Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

