//
//  CategoryManager.swift
//  DH Exam Master
//
//  Created by 矢部勇貴 on 2024/12/02.
//

import Foundation

struct CategoryManager {

    let categories: [String: [String]] = [
            "歯科医療補助論": ["歯科材料","口腔外科","治療の補助"],
            "歯科予防処置論": ["歯周病","う蝕予防","フッ素"],
            "歯科保健指導論": ["小学生","成人","高齢者"]
        ]
    
    
    func getSubCategories(for category: String) ->[String]{
        return categories[category] ?? []
    }
}
