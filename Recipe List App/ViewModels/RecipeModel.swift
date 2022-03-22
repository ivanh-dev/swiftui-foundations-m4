//
//  RecipeModel.swift
//  Recipe List App
//
//  Created by Ivan Hirsinger on 18.03.2022..
//

import Foundation

class RecipeModel: ObservableObject {
    
    @Published var recipes = [Recipe]()
    
    init() {
        
        // Create an instance of data service and get the data
        self.recipes = DataService.getLocalData()
    }
}
