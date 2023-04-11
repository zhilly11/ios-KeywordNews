//  KeywordNews - NewsSearchManager.swift
//  Created by zhilly on 2023/04/11

import Foundation
import Alamofire

struct NewsSearchManager: NewsSearchManagerProtocol {
    
    func request(
        from keyword: String,
        start: Int,
        display: Int,
        completionHandler: @escaping ([News]) -> Void
    ) {
        guard let url = NewsSearchAPIConst.baseURL else { return }
        
        let parameters = NewsRequestModel(start: start, display: display, query: keyword)
        let headers: HTTPHeaders = [
            HTTPHeaderField.clientID.rawValue: NewsSearchAPIConst.clientID,
            HTTPHeaderField.clientSecret.rawValue: NewsSearchAPIConst.clientSecret
        ]
        
        AF
            .request(url,
                     method: .get,
                     parameters: parameters,
                     headers: headers)
            .responseDecodable(of: NewsResponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result.items)
                case .failure(let error):
                    print(error)
                }
            }
            .resume()
    }
}
