//
//  APIError.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 31/05/2025.
//

public struct ServerErrorResponse: Decodable, Equatable {
    public let code: String
    public let message: String
}

enum APIError: Error, Equatable {
    case badURL
    case badServerResponse(code: String, message: String)
    case cannotDecodeRawData
    case noInternetConnection
    case unauthorized
    case unknown
    
    var description: String {
        switch self {
        case .badURL:
            return "El URL es inválido"
        case .badServerResponse(code: let code, message: let message):
            return "Bad server response: \(code), \(message)"
        case .cannotDecodeRawData:
            return "No se pueden decodificar los datos correctamente"
        case .noInternetConnection:
            return "Sin conexión a internet. Intenta más tarde."
        case .unauthorized:
            return "Acceso no autorizado. Verifica tus credenciales (Token de autenticación)."
        case .unknown:
            return "Ha ocurrido un error desconocido. Intenta más tarde."
        }
        
    }
}
