//
//  Model.swift
//  NASAClient
//
//  Created by Dmitry Tkachenko on 28.12.2021.
//

import Foundation

struct PhotosResponse: Decodable {
    var photos: [Photo]
}

struct Photo: Decodable {
    var id: Int
    var camera: Camera
    var img_src: String
    var earth_date: Date
    var rover: Rover
}

struct Camera: Decodable {
    var id: Int
    var name: String
    var full_name: String
}

struct Rover: Decodable {
    var id: Int
    var name: String

}
