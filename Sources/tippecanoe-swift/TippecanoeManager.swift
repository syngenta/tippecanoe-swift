//
//  TippecanoeManager.swift
//  tippecanoe-swift
//
//  Created by Evegeny Kalashnikov on 24.09.2020.
//

import Foundation
#if SWIFT_PACKAGE
import tippecanoe
#endif

private extension TileJoinOptions {

    typealias InputType = (UnsafeMutablePointer<Int8>?, UnsafeMutablePointer<Int8>?, UnsafeMutablePointer<Int8>?, UnsafeMutablePointer<Int8>?, UnsafeMutablePointer<Int8>?, UnsafeMutablePointer<Int8>?, UnsafeMutablePointer<Int8>?, UnsafeMutablePointer<Int8>?, UnsafeMutablePointer<Int8>?, UnsafeMutablePointer<Int8>?)

    var inputTuple: InputType? {
        var result = [UnsafeMutablePointer<Int8>?]()
        for index in 0..<10 {
            if index < self.input.count {
                result.append(self.input[index].unsafeMutablePointer)
            } else {
                result.append(nil)
            }
        }
        return result.withUnsafeBytes { $0.bindMemory(to: InputType.self).first }
    }
}

public class TippecanoeManager {

    private enum Errors: Error {
        case failure
        case join(message: String)
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
                full_detail: Int32(options.fullDetail),
                low_detail: Int32(options.lowDetail),
                minimum_detail: Int32(options.minimumDetail),
                layer: options.layer.unsafeMutablePointer,
                drop_rate: options.dropRate.option,
                base_zoom: options.baseZoom.oprion,
                no_stat: options.noStat,
                no_tile_compression: options.noTileCompression,
                drop_densest_as_needed: options.dropDensestAsNeeded,
                drop_fraction_as_needed: options.dropFractionAsNeeded,
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
        guard options.input.count <= 10 else {
            completion(.failure(Errors.join(message: "Input path must be <= 10 (max 10)")))
            return
        }
        self.queue.addOperation {
            let output = options.output.unsafeMutablePointer
            let tmp = NSTemporaryDirectory().unsafeMutablePointer
            let filter = options.filter?.unsafeMutablePointer
            guard let input = options.inputTuple else {
                completion(.failure(Errors.join(message: "Can't create input typle")))
                return
            }

            defer {
                free(tmp)
                free(output)
                if let filter = filter {
                    free(filter)
                }

                // free input tuple
                Mirror(reflecting: input).children.forEach {
                    if let value = $0.value as? UnsafeMutablePointer<Int8> {
                        free(value)
                    }
                }
            }

            let _options = JoinOptions(
                output: output,
                input: input,
                tmpdir: tmp,
                filter: filter,
                force: options.force,
                quiet: options.quiet
            )

            let result = join_tiles(_options)
            completion(result == 0 ? .success(Void()) : .failure(Errors.failure))
        }
    }
}
