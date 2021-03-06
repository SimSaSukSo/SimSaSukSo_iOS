//
//  KobisKey.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

// MARK: Secret 폴더 안에서 사용하는 파일들은 .gitignore에 추가해주세요!!

import Alamofire

struct KeyCenter {
    static var LOGIN_TOKEN = ""

    static let header: HTTPHeaders = ["X-ACCESS-TOKEN": "\(KeyCenter.LOGIN_TOKEN)"]
    
    
    static let KakaoAuthorization = "KakaoAK b56fd7040b95ad4fa79c575d39fd320b"
    static let kakaoHeader : HTTPHeaders = ["Authorization": "\(KeyCenter.KakaoAuthorization)"]
}
