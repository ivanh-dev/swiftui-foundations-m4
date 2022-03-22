//
//  DataService.swift
//  Recipe List App
//
//  Created by Ivan Hirsinger on 18.03.2022..
//

import Foundation

class DataService {
    
    static func getLocalData() -> [Recipe] {
        // Parse local json file
        
        // Get a url path to the json file
        let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")
        
        // Check if pathString is not nil, otherwise...
        guard pathString != nil else {
            return [Recipe]()
        }
        
        // Create a url object
        
        let url = URL(fileURLWithPath: pathString!)
        
        // Create a data object

        do {
            let data = try Data(contentsOf: url)
            
            // Decode the data with a JSON decoder
            let decoder = JSONDecoder()
            
            do {
                let recipeData = try decoder.decode([Recipe].self, from: data)
                
                // Add the unique IDs
                for r in recipeData {
                    r.id = UUID()
                    
                    // Add unique IDs to recipe ingredients
                    for i in r.ingredients {
                        i.id = UUID()
                    }
                }
                
                // Return the recipes
                return recipeData
            }
            catch {
                // Error with parsing json
                print(error)
            }
        }
        catch {
            // Error with getting data
            print("Error")
        }
        return [Recipe]()
    }
}
