//
//  kakaoLoginResponse.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/06/30.
//


struct kakaoLoginResponse : Decodable{
    
    var isSuccess: Bool
    var code: Int
    var message: String
    var token : String
    
}
