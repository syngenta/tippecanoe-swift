//
//  Tippecanoe.swift
//  tippecanoe-swift
//
//  Created by Evegeny Kalashnikov on 7/12/19.
//  Copyright © 2019 N.S.T. New Science Technologies Ltd. All rights reserved.
//

import Foundation
import tippecanoe

extension String {
    var unsafeMutablePointer: UnsafeMutablePointer<Int8> {
        return strdup(self)
    }
}

public struct Tippecanoe {
    public enum E: Error {
        case failure
    }

    let queue = DispatchQueue(label: "com.tippecanoe.render.queue")
    let input: String
    let output: String
    let maxzoom: UInt8
    let quiet: Bool

    public init(input: String, output: String, maxzoom: UInt8 = 13, quiet: Bool = true) {
        self.input = input
        self.output = output
        self.maxzoom = maxzoom
        self.quiet = quiet
    }

    var options: RenderOptions {
        let tmp = NSTemporaryDirectory()

        return RenderOptions(rewrite: true,
                             rg: true,
                             output: self.output.unsafeMutablePointer,
                             input: self.input.unsafeMutablePointer,
                             tmpdir: tmp.unsafeMutablePointer,
                             maxzoom: Int32(self.maxzoom),
                             quiet: self.quiet)
    }

    public func render(progress: ((Double) -> Void)? = nil, completion: @escaping (Result<Void, E>) -> Void) {
        var _progress: Double = 0

        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            progress?(_progress)
        }

        self.queue.async {
            let result = render_tiles(self.options, UnsafeMutablePointer(mutating: &_progress))
            timer.invalidate()
            progress?(100)
            completion(result == 0 ? .success(Void()) : .failure(E.failure))
        }
    }
}
