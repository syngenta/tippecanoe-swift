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

        guard let input = Bundle.main.path(forResource: "polygons", ofType: "json") else {
            return
        }

        let output = NSTemporaryDirectory().appending("test.mbtiles")

        do {
            try self.delete(path: output)
        } catch {
            XCTFail("error - \(error)")
        }

        let expectation = self.expectation(description: #function)

        let options = TippecanoeOptions(input: input, output: output, layer: "polygons")
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

        guard let input = Bundle.main.path(forResource: "polygons", ofType: "json") else {
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

        let options1 = TippecanoeOptions(input: input, output: input1, layer: "polygons1")
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

        let options2 = TippecanoeOptions(input: input, output: input2, layer: "polygons2")
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

        let joinOptions = TileJoinOptions(input: input1, input2, output: output)
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

    func testTileJoinFilter() {
        guard let input = Bundle.main.path(forResource: "polygons", ofType: "json") else {
            return
        }

        let output = NSTemporaryDirectory().appending("test.mbtiles")

        do {
            try self.delete(path: output)
        } catch {
            XCTFail("error - \(error)")
        }

        let expectation = self.expectation(description: #function)
        let expectation2 = self.expectation(description: #function)

        let options = TippecanoeOptions(input: input, output: output, layer: "polygons")
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

        let filtered = NSTemporaryDirectory().appending("filteredTest.mbtiles")

        let filter1 = #"{"layer_1":["none", ["in","id", 1, 3]], "layer_2": ["none", ["in","id", 4]], "layer_3": ["none", ["in","id", 1,2,3,4]]}"#
        let joinOptions = TileJoinOptions(input: output, output: filtered, filter: filter1)
        self.manager.join(with: joinOptions) { result in
            switch result {
            case .success:
                print("done")
                let url = URL(fileURLWithPath: filtered)
                let data = try? Data(contentsOf: url)
                XCTAssertEqual(data?.count, 24576)
                expectation2.fulfill()
            case .failure(let error):
                XCTFail("error - \(error)")
                expectation2.fulfill()
            }
        }

        wait(for: [expectation2], timeout: 20)
    }
}
