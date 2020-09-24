//
//  TippecanoeManager.swift
//  tippecanoe-swift
//
//  Created by Evegeny Kalashnikov on 24.09.2020.
//

import Foundation

public class TippecanoeManager {

    private enum Errors: Error {
        case failure
    }

    public static let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    let queue: OperationQueue
    public init(queue: OperationQueue = queue) {
        self.queue = queue
    }

    public func render(with options: TippecanoeOptions,
                       progress: ((Double) -> Void)? = nil,
                       completion: @escaping (Result<Void, Error>) -> Void) {

        var _progress: Double = 0

        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            progress?(_progress)
        }

        self.queue.addOperation {
            let output = options.output.unsafeMutablePointer
            let input = options.input.unsafeMutablePointer
            let tmp = NSTemporaryDirectory().unsafeMutablePointer
            defer {
                free(output)
                free(input)
                free(tmp)
            }

            let _options = RenderOptions(
                rewrite: options.rewrite,
                output: output,
                input: input,
                tmpdir: tmp,
                minzoom: Int32(options.minzoom),
                maxzoom: Int32(options.maxzoom),
                layer: options.layer.unsafeMutablePointer,
                drop_rate: options.dropRate.option,
                base_zoom: options.baseZoom.oprion,
                no_stat: options.noStat,
                no_tile_compression: options.noTileCompression,
                parallel: options.parallel,
                quiet: options.quiet
            )

            let result = render_tiles(_options, &_progress)
            timer.invalidate()
            progress?(100)
            completion(result == 0 ? .success(Void()) : .failure(Errors.failure))
        }
    }

    public func join(with options: TileJoinOptions, completion: @escaping (Result<Void, Error>) -> Void) {

        self.queue.addOperation {
            let output = options.output.unsafeMutablePointer
            let input1 = options.input1.unsafeMutablePointer
            let input2 = options.input2.unsafeMutablePointer
            let tmp = NSTemporaryDirectory().unsafeMutablePointer
            defer {
                free(tmp)
                free(input1)
                free(input2)
                free(output)
            }

            let _options = JoinOptions(
                output: output,
                input1: input1,
                input2: input2,
                tmpdir: tmp,
                quiet: true
            )

            let result = join_tiles(_options)
            completion(result == 0 ? .success(Void()) : .failure(Errors.failure))
        }
    }
}
