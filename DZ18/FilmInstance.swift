//
//  FilmInstance.swift
//  DZ18
//
//  Created by Илья Иванов on 19.04.2024.
//

import Foundation

struct FilmInstance: Codable{
    
    let keyword: String?
    let pagesCount: Int?
    
    enum CodingKeys: String, CodingKey{
        
        case keyword = "keyword"
        case pagesCount = "pagesCount"
    }
    
    init(keyword: String, pagesCount: Int){
        self.keyword = keyword
        self.pagesCount = pagesCount
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.keyword = try container.decodeIfPresent(String.self, forKey: .keyword)
        self.pagesCount = try container.decodeIfPresent(Int.self, forKey: .pagesCount)
    }
}


