//  KeywordNews - NewsSearchAPIConst.swift
//  Created by zhilly on 2023/04/11

import Foundation

struct NewsSearchAPIConst {
    static var baseURL: URL? {
        return URL(string: "https://openapi.naver.com/v1/search/news.json")
    }
    static let clientID = "Paz9_qojs7Zfv5rc4VGa"
    static let clientSecret = "_NniQaC1Gh"
}

enum HTTPHeaderField: String {
    case clientID = "X-Naver-Client-Id"
    case clientSecret = "X-Naver-Client-Secret"
}
