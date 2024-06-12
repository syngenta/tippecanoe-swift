//
//  String+.swift
//  tippecanoe-swift
//
//  Created by Evegeny Kalashnikov on 24.09.2020.
//

import Foundation

extension String {
    var unsafeMutablePointer: UnsafeMutablePointer<Int8> {
        return strdup(self)
    }
}
