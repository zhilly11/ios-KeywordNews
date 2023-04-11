//  KeywordNews - NewsSearchManagerProtocol.swift
//  Created by zhilly on 2023/04/11

protocol NewsSearchManagerProtocol {
    
    func request(
        from keyword: String,
        start: Int,
        display: Int,
        completionHandler: @escaping ([News]) -> Void
    )
}
