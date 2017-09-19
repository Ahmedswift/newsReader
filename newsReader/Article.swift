//
//  Article.swift
//  newsReader
//
//  Created by Ahmad Ahrbi on 12/27/1438 AH.
//  Copyright © 1438 Ahmad Ahrbi. All rights reserved.
//

import UIKit


class News {
    var title: String?
    var articles: [Article]?
}
class Article {
    
    var title: String?
    var content: String?
    var author: String?
    var date: String?
    var website: String?
    var imageUrl: String?
    var tags: [Tag]?

}

class Tag {
    var id: Int?
    var label: String?
}

