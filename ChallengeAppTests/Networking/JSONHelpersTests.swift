//
//  JSONHelpersTests.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 02/06/2025.
//

import XCTest
@testable import ChallengeApp

class JSONHelpersTests: XCTestCase {
    
    var decoder: JSONDecoder!
    var encoder: JSONEncoder!
    
    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
        encoder = JSONEncoder()
    }
    
    override func tearDown() {
        decoder = nil
        encoder = nil
        super.tearDown()
    }
    
    
    func testJSONNullEquality() {
        let null1 = JSONNull()
        let null2 = JSONNull()
        
        XCTAssertEqual(null1, null2)
    }
    
    func testJSONNullHashing() {
        let null1 = JSONNull()
        let null2 = JSONNull()
        
        XCTAssertEqual(null1.hashValue, null2.hashValue)
        
        var hasher1 = Hasher()
        var hasher2 = Hasher()
        null1.hash(into: &hasher1)
        null2.hash(into: &hasher2)
        
        XCTAssertEqual(hasher1.finalize(), hasher2.finalize())
    }
    
    func testJSONNullDecoding() throws {
        let jsonData = "null".data(using: .utf8)!
        
        let decodedNull = try decoder.decode(JSONNull.self, from: jsonData)
        
        XCTAssertNotNil(decodedNull)
    }
    
    func testJSONNullDecodingThrowsOnNonNull() {
        let jsonData = "\"not null\"".data(using: .utf8)!
        
        XCTAssertThrowsError(try decoder.decode(JSONNull.self, from: jsonData)) { error in
            XCTAssert(error is DecodingError)
            if case DecodingError.typeMismatch(let type, _) = error {
                XCTAssertTrue(type == JSONNull.self)
            } else {
                XCTFail("Wrong error type")
            }
        }
    }
    
    func testJSONNullEncoding() throws {
        let jsonNull = JSONNull()
        
        let encodedData = try encoder.encode(jsonNull)
        let jsonString = String(data: encodedData, encoding: .utf8)
        
        XCTAssertEqual(jsonString, "null")
    }
    
    
    func testJSONCodingKeyStringValue() {
        let key = JSONCodingKey(stringValue: "testKey")
        
        XCTAssertNotNil(key)
        XCTAssertEqual(key?.stringValue, "testKey")
        XCTAssertEqual(key?.key, "testKey")
    }
    
    func testJSONCodingKeyIntValue() {
        let key = JSONCodingKey(intValue: 42)
        
        XCTAssertNil(key)
    }
    
    func testJSONCodingKeyIntValueProperty() {
        let key = JSONCodingKey(stringValue: "test")
        
        XCTAssertNil(key?.intValue)
    }
    
    
    func testJSONAnyDecodeBool() throws {
        let jsonData = "true".data(using: .utf8)!
        
        let jsonAny = try decoder.decode(JSONAny.self, from: jsonData)
        
        XCTAssertTrue(jsonAny.value is Bool)
        XCTAssertEqual(jsonAny.value as? Bool, true)
    }
    
    func testJSONAnyDecodeInt() throws {
        let jsonData = "42".data(using: .utf8)!
        
        let jsonAny = try decoder.decode(JSONAny.self, from: jsonData)
        
        XCTAssertTrue(jsonAny.value is Int64)
        XCTAssertEqual(jsonAny.value as? Int64, 42)
    }
    
    func testJSONAnyDecodeDouble() throws {
        let jsonData = "3.14".data(using: .utf8)!
        
        let jsonAny = try decoder.decode(JSONAny.self, from: jsonData)
        
        XCTAssertTrue(jsonAny.value is Double)
        
        guard let doubleValue = jsonAny.value as? Double else {
            XCTFail("Value should be Double")
            return
        }
        
        XCTAssertEqual(doubleValue, 3.14, accuracy: 0.001)
    }
    
    func testJSONAnyDecodeString() throws {
        let jsonData = "\"hello world\"".data(using: .utf8)!
        
        let jsonAny = try decoder.decode(JSONAny.self, from: jsonData)
        
        XCTAssertTrue(jsonAny.value is String)
        XCTAssertEqual(jsonAny.value as? String, "hello world")
    }
    
    func testJSONAnyDecodeNull() throws {
        let jsonData = "null".data(using: .utf8)!
        
        let jsonAny = try decoder.decode(JSONAny.self, from: jsonData)
        
        XCTAssertTrue(jsonAny.value is JSONNull)
    }
    
    // MARK: - JSONAny Tests - Complex Types
    
    func testJSONAnyDecodeArray() throws {
        let jsonData = "[1, \"test\", true, null]".data(using: .utf8)!
        
        let jsonAny = try decoder.decode(JSONAny.self, from: jsonData)
        
        XCTAssertTrue(jsonAny.value is [Any])
        let array = jsonAny.value as? [Any]
        XCTAssertEqual(array?.count, 4)
        
        XCTAssertEqual(array?[0] as? Int64, 1)
        XCTAssertEqual(array?[1] as? String, "test")
        XCTAssertEqual(array?[2] as? Bool, true)
        XCTAssertTrue(array?[3] is JSONNull)
    }
    
    func testJSONAnyDecodeNestedArray() throws {
        let jsonData = "[[1, 2], [\"a\", \"b\"]]".data(using: .utf8)!
        
        let jsonAny = try decoder.decode(JSONAny.self, from: jsonData)
        
        XCTAssertTrue(jsonAny.value is [Any])
        let outerArray = jsonAny.value as? [Any]
        XCTAssertEqual(outerArray?.count, 2)
        
        let firstInnerArray = outerArray?[0] as? [Any]
        XCTAssertEqual(firstInnerArray?.count, 2)
        XCTAssertEqual(firstInnerArray?[0] as? Int64, 1)
        XCTAssertEqual(firstInnerArray?[1] as? Int64, 2)
    }
    
    func testJSONAnyDecodeDictionary() throws {
        let jsonData = """
        {
            "name": "John",
            "age": 30,
            "isActive": true,
            "data": null
        }
        """.data(using: .utf8)!
        
        let jsonAny = try decoder.decode(JSONAny.self, from: jsonData)
        
        XCTAssertTrue(jsonAny.value is [String: Any])
        let dict = jsonAny.value as? [String: Any]
        
        XCTAssertEqual(dict?["name"] as? String, "John")
        XCTAssertEqual(dict?["age"] as? Int64, 30)
        XCTAssertEqual(dict?["isActive"] as? Bool, true)
        XCTAssertTrue(dict?["data"] is JSONNull)
    }
    
    func testJSONAnyDecodeNestedDictionary() throws {
        let jsonData = """
        {
            "user": {
                "profile": {
                    "name": "Alice"
                }
            }
        }
        """.data(using: .utf8)!
        
        let jsonAny = try decoder.decode(JSONAny.self, from: jsonData)
        
        let dict = jsonAny.value as? [String: Any]
        let userDict = dict?["user"] as? [String: Any]
        let profileDict = userDict?["profile"] as? [String: Any]
        
        XCTAssertEqual(profileDict?["name"] as? String, "Alice")
    }
    
    // MARK: - JSONAny Encoding Tests
    
    func testJSONAnyEncodeBool() throws {
        let jsonAny = JSONAny(value: true)
        
        let encodedData = try encoder.encode(jsonAny)
        let jsonString = String(data: encodedData, encoding: .utf8)
        
        XCTAssertEqual(jsonString, "true")
    }
    
    func testJSONAnyEncodeInt() throws {
        let jsonAny = JSONAny(value: Int64(42))
        
        let encodedData = try encoder.encode(jsonAny)
        let jsonString = String(data: encodedData, encoding: .utf8)
        
        XCTAssertEqual(jsonString, "42")
    }
    
    func testJSONAnyEncodeString() throws {
        let jsonAny = JSONAny(value: "hello")
        
        let encodedData = try encoder.encode(jsonAny)
        let jsonString = String(data: encodedData, encoding: .utf8)
        
        XCTAssertEqual(jsonString, "\"hello\"")
    }
    
    func testJSONAnyEncodeNull() throws {
        let jsonAny = JSONAny(value: JSONNull())
        
        let encodedData = try encoder.encode(jsonAny)
        let jsonString = String(data: encodedData, encoding: .utf8)
        
        XCTAssertEqual(jsonString, "null")
    }
    
    func testJSONAnyEncodeArray() throws {
        let jsonAny = JSONAny(value: [Int64(1), "test", true, JSONNull()] as [Any])
        
        let encodedData = try encoder.encode(jsonAny)
        
        // Decode back to verify
        let decodedAny = try decoder.decode(JSONAny.self, from: encodedData)
        let array = decodedAny.value as? [Any]
        
        XCTAssertEqual(array?.count, 4)
        XCTAssertEqual(array?[0] as? Int64, 1)
        XCTAssertEqual(array?[1] as? String, "test")
        XCTAssertEqual(array?[2] as? Bool, true)
        XCTAssertTrue(array?[3] is JSONNull)
    }
    
    func testJSONAnyEncodeDictionary() throws {
        let dict: [String: Any] = [
            "name": "John",
            "age": Int64(30),
            "isActive": true,
            "data": JSONNull()
        ]
        let jsonAny = JSONAny(value: dict)
        
        let encodedData = try encoder.encode(jsonAny)
        
        let decodedAny = try decoder.decode(JSONAny.self, from: encodedData)
        let decodedDict = decodedAny.value as? [String: Any]
        
        XCTAssertEqual(decodedDict?["name"] as? String, "John")
        XCTAssertEqual(decodedDict?["age"] as? Int64, 30)
        XCTAssertEqual(decodedDict?["isActive"] as? Bool, true)
        XCTAssertTrue(decodedDict?["data"] is JSONNull)
    }
    
    
    func testJSONAnyEncodingUnsupportedType() {
        let unsupportedValue = NSDate()
        let jsonAny = JSONAny(value: unsupportedValue)
        
        XCTAssertThrowsError(try encoder.encode(jsonAny)) { error in
            XCTAssert(error is EncodingError)
            if case EncodingError.invalidValue(_, _) = error {
                XCTAssert(true)
            } else {
                XCTFail("Wrong error type")
            }
        }
    }
    
    func testJSONAnyDecodingInvalidJSON() {
        
        let invalidData = "undefined".data(using: .utf8)!
        
        XCTAssertThrowsError(try decoder.decode(JSONAny.self, from: invalidData)) { error in
            XCTAssert(error is DecodingError)
        }
    }
    
    
    func testComplexJSON() throws {
        let originalJSON = """
        {
            "users": [
                {
                    "id": 1,
                    "name": "Alice",
                    "active": true,
                    "metadata": null,
                    "scores": [95.5, 87.2, 92.0]
                },
                {
                    "id": 2,
                    "name": "Bob",
                    "active": false,
                    "metadata": {
                        "lastLogin": "2024-01-01",
                        "attempts": 3
                    },
                    "scores": []
                }
            ],
            "total": 2
        }
        """.data(using: .utf8)!
        
        let jsonAny = try decoder.decode(JSONAny.self, from: originalJSON)
        
        let encodedData = try encoder.encode(jsonAny)
        
        let finalJsonAny = try decoder.decode(JSONAny.self, from: encodedData)
        let dict = finalJsonAny.value as? [String: Any]
        
        XCTAssertNotNil(dict)
        XCTAssertEqual(dict?["total"] as? Int64, 2)
        
        let users = dict?["users"] as? [Any]
        XCTAssertEqual(users?.count, 2)
        
        let firstUser = users?[0] as? [String: Any]
        XCTAssertEqual(firstUser?["name"] as? String, "Alice")
        XCTAssertEqual(firstUser?["active"] as? Bool, true)
        XCTAssertTrue(firstUser?["metadata"] is JSONNull)
    }
    
}


