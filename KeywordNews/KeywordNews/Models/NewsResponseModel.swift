//  KeywordNews - NewsResponseModel.swift
//  Created by zhilly on 2023/04/11

struct NewsResponseModel: Decodable {
    var items: [News] = []
}

struct News: Decodable {
    let title: String
    let link: String
    let description: String
    let pubDate: String
}
