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

    let input: String
    let output: String
    let maxzoom: UInt8
    let minzoom: UInt8
    let layer: String
    let rewrite: Bool
    let dropRate: DropRate
    let baseZoom: BaseZoom
    let noStat: Bool
    let noTileCompression: Bool
    let parallel: Bool
    let quiet: Bool

    public init(input: String,
                output: String,
                maxzoom: UInt8 = 13,
                minzoom: UInt8 = 0,
                layer: String,
                rewrite: Bool = true,
                dropRate: DropRate = .deinit,
                baseZoom: BaseZoom = .deinit,
                noStat: Bool = true,
                noTileCompression: Bool = false,
                parallel: Bool = false,
                quiet: Bool = true) {

        self.input = input
        self.output = output
        self.maxzoom = maxzoom
        self.minzoom = minzoom
        self.layer = layer
        self.rewrite = rewrite
        self.dropRate = dropRate
        self.baseZoom = baseZoom
        self.noStat = noStat
        self.noTileCompression = noTileCompression
        self.parallel = parallel
        self.quiet = quiet
    }
}
