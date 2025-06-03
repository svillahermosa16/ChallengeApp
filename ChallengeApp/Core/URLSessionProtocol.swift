//
//  URLSessionProtocol.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 02/06/2025.
//


import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
