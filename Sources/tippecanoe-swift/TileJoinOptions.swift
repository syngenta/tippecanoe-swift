//
//  TileJoinOptions.swift
//  tippecanoe-swift
//
//  Created by Evegeny Kalashnikov on 24.09.2020.
//

import Foundation

public struct TileJoinOptions {
    public let input: [String]
    public let output: String
    public let force: Bool
    public let quiet: Bool
    public let filter: String?

    public init(input: [String],
                output: String,
                force: Bool = true,
                quiet: Bool = true,
                filter: String? = nil) {

        self.input = input
        self.output = output
        self.force = force
        self.quiet = quiet
        self.filter = filter
    }

    public init(input: String...,
                output: String,
                force: Bool = true,
                quiet: Bool = true,
                filter: String? = nil) {

        self.input = input
        self.output = output
        self.force = force
        self.quiet = quiet
        self.filter = filter
    }
}
