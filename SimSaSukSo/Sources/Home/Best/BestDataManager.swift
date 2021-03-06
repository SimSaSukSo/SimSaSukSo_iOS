//
//  BestDataManager.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/08.
//

import Alamofire

class BestDataManager {
    
    // 인기 - 해시태그
    func bestHashTags(delegate: BestTabViewController) {
        let url = "\(Constant.BASE_URL)api/feeds/hot?page=1"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: BestResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.bestHashTags(result: response.result!)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
        
    // 인기 - ONE Feed
    func bestOneFeed(page: Int, delegate: BestOneFeedViewController) {
        let url = "\(Constant.BASE_URL)api/feeds/hot"
        let parameters : Parameters = [
            "page": page
        ]
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: BestResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if page == 1{
                        delegate.bestOneFeed(result: response.result!)
                    }else{
                        delegate.addBestOneFeed(result: response.result!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    // 인기 - Feeds
    func bestFeeds(page: Int, delegate: BestFeedsViewController) {
        let url = "\(Constant.BASE_URL)api/feeds/hot"
        let parameters : Parameters = [
            "page": page
        ]
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: BestResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if page == 1{
                        delegate.bestFeeds(result: response.result!)
                    }else{
                        delegate.addBestFeeds(result: response.result!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    

}
