//  KeywordNews - NewsRequestModel.swift
//  Created by zhilly on 2023/04/11

struct NewsRequestModel: Codable {
    let start: Int
    let display: Int
    let query: String
}
