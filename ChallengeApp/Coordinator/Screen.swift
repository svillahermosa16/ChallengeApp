//
//  Screen.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 31/05/2025.
//


enum Screen: Identifiable, Hashable {
    case home
    case productList(String)
    case productDetail(String)
    
    var id: Self { return self }
}