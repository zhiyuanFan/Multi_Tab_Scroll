//
//  GameModel.swift
//  TestGameDetail
//
//  Created by Jason Fan on 2017/6/8.
//  Copyright © 2017年 jason. All rights reserved.
//

import Foundation


struct GameModel {
    var gameInfo: GameInfoModel?
    var gameDetail: GameDetailModel?
    var gameNews: GameNewsModel?
}

struct GameInfoModel {
    var iconURL: String?
    var displayName: String?
    var appName: String?
    var companyName: String?
    var guideURL: String?
}


struct GameDetailModel {
    var gameImages: Array<String>?
    var brief: String?
    var gameType: String?
    var user_count : Float?
    var score_1 : Float?
    var score_2 : Float?
    var score_3 : Float?
    var score_4 : Float?
    var score_5 : Float?
}

struct GameNewsModel {
    var title: String?
    var tag: String?
    var url: String?
    var image_url: String?
    var date: String?
}
