//
//  GetRoversModel.swift
//  NASAClient
//
//  Created by Dmitry Tkachenko on 2022-01-20.
//

import Foundation

struct RoverDataResponse: Decodable {
    var rover: RoverData
}

struct RoverData: Decodable {
    var id: Int
    var name: String
    var cameras: [RoverCamera]
    var landing_date: Date
    var max_date: Date
}

struct RoverCamera: Decodable {
    var name: String
    var full_name: String
}
