//
//  DemoTests.swift
//  DemoTests
//
//  Created by Evegeny Kalashnikov on 7/12/19.
//  Copyright © 2019 Evegeny Kalashnikov. All rights reserved.
//

import XCTest
@testable import tippecanoe_swift

class DemoTests: XCTestCase {

    let manager = TippecanoeManager()

    func testRender() {

        guard let input = Bundle.main.path(forResource: "poligons", ofType: "json") else {
            return
        }

        let output = NSTemporaryDirectory().appending("test.mbtiles")

        do {
            try self.delete(path: output)
        } catch {
            XCTFail("error - \(error)")
        }

        let expectation = self.expectation(description: #function)

        let options = TippecanoeOptions(input: input, output: output, layer: "poligons")
        self.manager.render(with: options, progress: { progress in
            print(progress)
        }, completion: { result in
            switch result {
            case .success:
                print("done")
                let url = URL(fileURLWithPath: output)
                let data = try? Data(contentsOf: url)
                XCTAssertEqual(data?.count, 24576)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("error - \(error)")
                expectation.fulfill()
            }
        })

        wait(for: [expectation], timeout: 20)
    }


    func testJoin() {

        guard let input = Bundle.main.path(forResource: "poligons", ofType: "json") else {
            return
        }

        let input1 = NSTemporaryDirectory().appending("test1.mbtiles")
        let input2 = NSTemporaryDirectory().appending("test2.mbtiles")
        let output = NSTemporaryDirectory().appending("joined.mbtiles")

        do {
            try self.delete(path: input1)
            try self.delete(path: input1)
            try self.delete(path: output)
        } catch {
            XCTFail("error - \(error)")
        }

        let expectation1 = self.expectation(description: #function)
        let expectation2 = self.expectation(description: #function)
        let expectation3 = self.expectation(description: #function)

        let options1 = TippecanoeOptions(input: input, output: input1, layer: "poligons1")
        self.manager.render(with: options1, progress: { progress in
            print(progress)
        }, completion: { result in
            switch result {
            case .success:
                expectation1.fulfill()
            case .failure(let error):
                XCTFail("error - \(error)")
                expectation1.fulfill()
            }
        })

        let options2 = TippecanoeOptions(input: input, output: input2, layer: "poligons2")
        self.manager.render(with: options2, progress: { progress in
            print(progress)
        }, completion: { result in
            switch result {
            case .success:
                expectation2.fulfill()
            case .failure(let error):
                XCTFail("error - \(error)")
                expectation2.fulfill()
            }
        })

        wait(for: [expectation1, expectation2], timeout: 40)

        guard FileManager.default.fileExists(atPath: input1) else {
            XCTFail("file not exist")
            return
        }
        guard FileManager.default.fileExists(atPath: input2) else {
            XCTFail("file not exist")
            return
        }

        let joinOptions = TileJoinOptions(input1: input1, input2: input2, output: output)
        self.manager.join(with: joinOptions) { result in
            switch result {
            case .success:
                print("done")
                let url = URL(fileURLWithPath: output)
                let data = try? Data(contentsOf: url)
                XCTAssertEqual(data?.count, 24576)
                expectation3.fulfill()
            case .failure(let error):
                XCTFail("error - \(error)")
                expectation3.fulfill()
            }
        }

        wait(for: [expectation3], timeout: 20)
    }

    func delete(path: String) throws {
        guard FileManager.default.fileExists(atPath: path) else { return }
        try FileManager.default.removeItem(atPath: path)
    }
}
