//
//  DelegatedTests.swift
//  Delegated
//
//  Created by Oleg Dreyman on 3/11/18.
//  Copyright © 2018 Delegated. All rights reserved.
//

import XCTest
import Delegated

class DelegatedTests: XCTestCase {
    
    func testExample() {
        class Example {
            var stringForIndexPath = Delegated<IndexPath, String>()
            func printString(for indexPath: IndexPath) {
                if let string = stringForIndexPath.call(indexPath) {
                    print(string)
                }
            }
        }
        
        class Controller {
            let printer = Example()
            init() {
                self.printer.stringForIndexPath.delegate(to: self) { (self, indexPath) -> String in
                    return self.string(for: indexPath)
                }
            }
            var onDeinit: () -> () = { }
            deinit {
                onDeinit()
            }
            func string(for indexPath: IndexPath) -> String {
                return String.init(describing: indexPath)
            }
        }
        
        var controller: Controller? = Controller()
        var wasDeallocated = false
        controller!.onDeinit = { wasDeallocated = true }
        XCTAssertTrue(controller!.printer.stringForIndexPath.isDelegateSet)
        controller!.printer.printString(for: IndexPath.init(item: 1, section: 1))
        controller = nil
        XCTAssertTrue(wasDeallocated)
    }
    
    func testVoidOutput() {
        
        class Example {
            var printNumber = Delegated<Int, Void>()
            func perform(on number: Int) {
                let multiplied = number * 2
                printNumber.call(multiplied)
            }
        }
        
        class Controller {
            let example = Example()
            init() {
                example.printNumber.delegate(to: self) { (self, number) in
                    self.printNumber(number)
                }
            }
            func printNumber(_ number: Int) {
                print(number)
            }
            var onDeinit: () -> () = { }
            deinit {
                onDeinit()
            }
        }
        
        class StrongController {
            let example = Example()
            init() {
                example.printNumber.stronglyDelegate(to: self) { (self, number) in
                    self.printNumber(number)
                }
            }
            func printNumber(_ number: Int) {
                print(number)
            }
            var onDeinit: () -> () = { }
            deinit {
                onDeinit()
            }
        }
        
        var controller: Controller? = Controller()
        var wasDeallocated = false
        controller!.onDeinit = { wasDeallocated = true }
        controller!.example.perform(on: 10)
        controller = nil
        XCTAssertTrue(wasDeallocated)
        
        var strong: StrongController? = StrongController()
        wasDeallocated = false
        strong!.onDeinit = { wasDeallocated = true }
        strong!.example.perform(on: 15)
        strong = nil
        XCTAssertFalse(wasDeallocated)
        
    }
    
    static var allTests = [
        ("testExample", testExample),
    ]
    
}

#if os(iOS)
    func download(url: URL, completion: @escaping (UIImage) -> Void) {
        
    }
enum README {
    
class ImageDownloader {
    
    var didDownload = Delegated<UIImage, Void>()
    
    func downloadImage(for url: URL) {
        download(url: url) { image in
            self.didDownload.call(image)
        }
    }
    
}

class Controller {
    
    let downloader = ImageDownloader()
    var currentImage: UIImage?
    
    init() {
        downloader.didDownload.delegate(to: self) { (self, image) in
            self.currentImage = image
        }
    }
    
    func updateImage(with url: URL) {
        downloader.downloadImage(for: url)
    }
    
}
    
class NumberPrinter {
    
    var numberToString = Delegated<Int, String>()
    
    func printNumber(_ number: Int) {
        // .call returns nil if no delegate was set
        guard let string = numberToString.call(number) else {
            return
        }
        print(string)
    }
    
}
    
    class SomeViewController: UIViewController {
        
        let printer = NumberPrinter()
        
        override func viewDidLoad() {
            super.viewDidLoad()
printer.numberToString.stronglyDelegate(to: self) { (self, number) -> String in
    return self.convert(number: number)
}
        }
        
        func convert(number: Int) -> String {
            return String(number)
        }
        
    }
    
    func t() {
let printer = NumberPrinter()
printer.numberToString.manuallyDelegate(with: { number in
    return String(number)
})
    }
    
}
#endif

