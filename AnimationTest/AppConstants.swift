//
//  AppConstants.swift
//  AnimationTest
//
//  Created by macOS on 01/08/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import Foundation
import UIKit

struct AppData {
    static let baseUrl = "https://api.tvmaze.com"
    static let search = "/search/shows"
    static let show = "/show/"
    static let shows = "/shows/"
    static let episodes = "/episodes"
    static let season = "/seasons"
    static let cast = "/cast"
    static let crew = "/crew"
    static let placeholderUrl = "http://via.placeholder.com/350/ffffff/000000?text=Image+Not+found"
    static let dateFormat = "dd MMM yyyy"
    static let dateFormatApi = "yyyy-MM-dd"
    
}


enum AppError : Error {
    case invalidFormat
}
