//
//  FavoriteEditRequest.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/20.
//

struct FavoriteEditRequest: Encodable {
    var savedListIndex: Int
    var title: String
}
