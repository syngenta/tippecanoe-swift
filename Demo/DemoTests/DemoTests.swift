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

        let tpc = Tippecanoe(input: input, output: output)
        tpc.render(progress: { progress in
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

    func delete(path: String) throws {
        guard FileManager.default.fileExists(atPath: path) else { return }
        try FileManager.default.removeItem(atPath: path)
    }
}
