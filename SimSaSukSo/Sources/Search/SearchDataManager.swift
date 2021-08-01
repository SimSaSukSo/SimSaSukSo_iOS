//
//  SearchDataManager.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/30.
//

import Alamofire

class SearchDataManager {
    // 이미지 검색
    func searchImage(_ parameters: SearchImageRequest, delegate: SearchResultViewController) {
        AF.request("https://dev.enudgu.shop/api/feeds/search/origin", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: SearchImageResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.searchImage(response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    // 전체 검색
    func searchAll(delegate: SearchViewController, url: String) {
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let urlResult = URL(string: encodedString)!
        AF.request(urlResult, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: SearchAllResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.searchAll(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    // 숙소 검색
    func searchHotel(_ parameters: SearchLodgingsRequest, delegate: SearchViewController) {
        AF.request("https://dev.enudgu.shop/api/feeds/search/lodging", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: SearchLodgingsResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.searchHotel(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    // 태그 검색
    func searchTags(_ parameters: SearchTagRequest, delegate: SearchViewController) {
        AF.request("https://dev.enudgu.shop/api/feeds/search/tag", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: SearchTagResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.searchTags(result : response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
}
