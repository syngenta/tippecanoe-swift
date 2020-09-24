//
//  TileJoinOptions.swift
//  tippecanoe-swift
//
//  Created by Evegeny Kalashnikov on 24.09.2020.
//

import Foundation

public struct TileJoinOptions {
    let input1: String
    let input2: String
    let output: String
    let quiet: Bool

    public init(input1: String,
                input2: String,
                output: String,
                quiet: Bool = true) {

        self.input1 = input1
        self.input2 = input2
        self.output = output
        self.quiet = quiet
    }
}
