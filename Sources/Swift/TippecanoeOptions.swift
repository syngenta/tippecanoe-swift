//
//  TippecanoeOptions.swift
//  tippecanoe-swift
//
//  Created by Evegeny Kalashnikov on 7/12/19.
//  Copyright © 2019 N.S.T. New Science Technologies Ltd. All rights reserved.
//

import Foundation
//import tippecanoe

public struct TippecanoeOptions {

    public enum DropRate {
        case `deinit`
        case rg
        case rf
        case r1

        var option: drop_rate {
            switch self {
            case .deinit: return drop_rate_default
            case .rg: return drop_rate_g
            case .rf: return drop_rate_f
            case .r1: return drop_rate_1
            }
        }
    }

    public enum BaseZoom {
        case `deinit`
        case Bg
        case Bf
        case B1, B2, B3, B4, B5, B6

        var oprion: base_zoom {
            switch self {
            case .deinit: return base_zoom_default
            case .Bg: return base_zoom_g
            case .Bf: return base_zoom_f
            case .B1: return base_zoom_1
            case .B2: return base_zoom_2
            case .B3: return base_zoom_3
            case .B4: return base_zoom_4
            case .B5: return base_zoom_5
            case .B6: return base_zoom_6
            }
        }
    }

    public let input: String
    public let output: String
    public let maxzoom: UInt8
    public let minzoom: UInt8
    public let fullDetail: UInt8
    public let lowDetail: UInt8
    public let minimumDetail: UInt8
    public let layer: String
    public let rewrite: Bool
    public let dropRate: DropRate
    public let baseZoom: BaseZoom
    public let noStat: Bool
    public let noTileCompression: Bool
    public let dropDensestAsNeeded: Bool
    public let dropFractionAsNeeded: Bool
    public let parallel: Bool
    public let quiet: Bool

    public init(input: String,
                output: String,
                maxzoom: UInt8 = 13,
                minzoom: UInt8 = 0,
                fullDetail: UInt8 = 12,
                lowDetail: UInt8 = 12,
                minimumDetail: UInt8 = 7,
                layer: String,
                rewrite: Bool = true,
                dropRate: DropRate = .deinit,
                baseZoom: BaseZoom = .deinit,
                noStat: Bool = true,
                noTileCompression: Bool = false,
                dropDensestAsNeeded: Bool = false,
                dropFractionAsNeeded: Bool = false,
                parallel: Bool = false,
                quiet: Bool = true) {

        self.input = input
        self.output = output
        self.maxzoom = maxzoom
        self.minzoom = minzoom
        self.fullDetail = fullDetail
        self.lowDetail = lowDetail
        self.minimumDetail = minimumDetail
        self.layer = layer
        self.rewrite = rewrite
        self.dropRate = dropRate
        self.baseZoom = baseZoom
        self.noStat = noStat
        self.noTileCompression = noTileCompression
        self.dropDensestAsNeeded = dropDensestAsNeeded
        self.dropFractionAsNeeded = dropFractionAsNeeded
        self.parallel = parallel
        self.quiet = quiet
    }
}
