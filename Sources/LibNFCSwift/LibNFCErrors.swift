//
//  File.swift
//  
//
//  Created by Christopher Hotchkiss on 6/15/24.
//

import Foundation

public enum LibNFCError: Error {
    case initFailed
    case listConnectStringFailure
    case deviceConnectFailed
    case unableToGetName
    case unableToGetDeviceInfo
    case unableToGetTargets
    case tagPrintError
    case pollTimeout
    case cancelled
}
