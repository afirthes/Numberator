//
//  UserDefaultsManager.swift
//  TibetanLearning
//
//  Created by Icetusk on 05.11.2023.
//
import Foundation

class UserDefaultsManager {
    
    static func save<T: Codable>(_ value: T, forKey key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Failed to save data to UserDefaults: \(error)")
        }
    }
    
    static func retrieve <T: Codable> (_ type: T.Type, forKey key: String) -> T? {
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                let value = try JSONDecoder().decode(type, from: data)
                return value
            } catch {
                print("Failed to retrieve data from UserDefaults: \(error)")
            }
        }
        return nil
        
    }
    
    public static func produceQuestions() -> [Quiz] {
        var result:[Quiz] = [Quiz]()
        var xBase = 0
        var yBase = 0
        for s in 0..<10 {
            shifter: for i in 0..<10 {
                xBase = i * 10
                yBase = (i + s) * 10
                
                guard yBase < 100 else { break shifter }
                
                for x in 0..<10 {
                    for y in 0..<10 {
                        result.append(Quiz(firstNumber: (xBase + x), secondNumber: (yBase + y), answered: false))
                    }
                }
            }
        }
        return result
    }

}
