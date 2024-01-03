//
//  MenuModel.swift
//  TibetanLearning
//
//  Created by Icetusk on 05.11.2023.
//
import Foundation

class Quiz: Codable, CustomStringConvertible {
    var description: String {
        "\(firstNumber) x \(secondNumber)"
    }
    
    let firstNumber: Int
    let secondNumber: Int
    var answered: Bool {
        didSet {
            print(answered)
        }
    }
    
    init(firstNumber: Int, secondNumber: Int, answered: Bool) {
        self.firstNumber = firstNumber
        self.secondNumber = secondNumber
        self.answered = answered
    }
}

class LessonsModel {
    static let shared = LessonsModel()
    public var quizes: [Quiz]
    
    private init() {
        _ = UserDefaultsManager.retrieve([Quiz].self, forKey: "Lessons")
        if let data = UserDefaultsManager.retrieve([Quiz].self, forKey: "Lessons") {
            quizes = data
        } else {
            quizes = UserDefaultsManager.produceQuestions()
            UserDefaultsManager.save(quizes, forKey: "Lessons")
        }
    }
    
    public func save() {
        UserDefaultsManager.save(quizes, forKey: "Lessons")
    }
}
