//
//  ContentView.swift
//  Recipe List App
//
//  Created by Ivan Hirsinger on 18.03.2022..
//

import SwiftUI

struct RecipeListView: View {
    
    @EnvironmentObject var model:RecipeModel
    
    private var title: String {
        if model.selectedCategory == nil || model.selectedCategory == Constants.defaultListFiler {
            return "All Recipes"
        }
        else {
            return model.selectedCategory!
        }
    }
    
    @State private var showsResetFilter = false
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .bold()
                        .padding(.top, 40)
                        .font(.largeTitle)
                    
                    Spacer()
                    
                    if model.selectedCategory != nil {
                        Button  {
                            model.selectedCategory = nil
                        } label: {
                            HStack {
                                Text("Reset Filter")
                                    .foregroundColor(.black)
                                Image(systemName: "arrow.clockwise.circle")
                                
                            }
                            .padding(.top, 40)
                            .padding(.trailing)
                        }
                    }
                    
                }
                
                ScrollView {
                    
                    LazyVStack(alignment: .leading) {
                        ForEach(model.recipes) { r in
                            
                            if model.selectedCategory == nil ||
                                model.selectedCategory == Constants.defaultListFiler ||
                                model.selectedCategory != nil && r.category == model.selectedCategory {
                                
                                NavigationLink(
                                    destination: RecipeDetailView(recipe: r)) {
                                        HStack(spacing: 20.0) {
                                            Image(r.image)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 50, height: 50, alignment: .center)
                                                .clipped()
                                                .cornerRadius(5)
                                            Text(r.name)
                                                .foregroundColor(.black)
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .padding(.leading)
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
            .environmentObject(RecipeModel())
    }
}
