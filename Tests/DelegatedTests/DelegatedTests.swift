import XCTest
import Foundation
@testable import Delegated

class A {
    @Delegated0 var didFinish: () -> ()
    
    func call() {
        print(#function)
        didFinish()
    }
}

final class DelegatedTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let a = A()
        a.$didFinish.delegate(to: self) { (self) in
            self.hereYaGo()
        }
        
        a.call()
    }
    
    func hereYaGo() {
        print(#function)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

struct Delegatedd<Input> {
    
    private(set) var callback: ((Input) -> Void)?
    
    mutating func delegate<Object : AnyObject>(
        to object: Object,
        with callback: @escaping (Object, Input) -> Void
    ){
        self.callback = { [weak object] input in
            guard let object = object else {
                return
            }
            callback(object, input)
        }
    }
    
}

final class Label {
    var text = ""
}


final class Button {
    @Delegated0 var didPress: () -> Void
}

final class ScrollView {
    @Delegated2 var didScrollTo: (_ x: CGFloat, _ y: CGFloat) -> Void
}


final class TextField {
    @Delegated0 var didStartEditing: () -> Void
    @Delegated1 var didUpdate: (String) -> Void
    @Delegated2 var didReplace: (String, String) -> Void
}

final class ViewController {
    
    let textField = TextField()
    let label = Label()
    
    func viewDidLoad() {
        textField.$didUpdate.delegate(to: self) { (self, text) in
            self.label.text = text
        }
        
        textField.$didUpdate.manuallyDelegate { (text) in
            <#code#>
        }
    }
}
