//
//  FCache.swift
//  MediaNews
//
//  Created by Xell on 25/11/2564 BE.
//

import Foundation
import Cache


let diskConfig = DiskConfig(name: "randevoo")
let memoryConfig = MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10)

let storage = try? Storage<String, Data>(
    diskConfig: diskConfig,
    memoryConfig: memoryConfig,
    transformer: TransformerFactory.forData() 
)

public class FCache {
    public static func set<T: Codable>(_ value: T, key: String, expiry: Expiry? = nil) {
        let typeStorage = storage?.transformCodable(ofType: T.self)
        try? typeStorage?.setObject(value, forKey: key, expiry: expiry)
    }
    
    public static func get<T: Codable>(_ key: String) -> T? {
        let typeStorage = storage?.transformCodable(ofType: T.self)
        return try? typeStorage?.object(forKey: key)
    }
    
    public static func remove(_ key: String) {
        do {
            try storage!.removeObject(forKey: key)
        } catch {
            print("Error")
        }
    }
    
    public static func setImage(image: UIImage, key: String, expiry: Expiry? = nil) {
        let imageStorage = storage?.transformImage()
        try? imageStorage?.setObject(image, forKey: key, expiry: expiry)
    }
    
    public static func getImage(key: String) -> UIImage? {
        let imageStorage = storage?.transformImage()
        return try? imageStorage?.object(forKey: key)
    }
    
    public static func isExpired(_ key: String) -> Bool {
        if let b = try? storage?.isExpiredObject(forKey: key) {
            return b
        }
        return true
    }
}
