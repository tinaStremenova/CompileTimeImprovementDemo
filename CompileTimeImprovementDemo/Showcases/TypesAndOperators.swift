//
//  TypesAndOperators.swift
//  CompileTimeImprovementDemo
//
//  Created by Martina Stremenova on 19/10/2017.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation
import Alamofire
import Swinject
import RxSwift
import ReactiveSwift

struct TypeInferenceTest {
    
    init() {
        self.comlexTypeInference()
    }

    func comlexTypeInference() {
        
        // [TIME]: 12990 ms
        let _ = [1, 2, 3].map { String($0) }.flatMap { Int($0) }.reduce(0, +)
        
        // [TIME]: 583 ms
        let _ = [1, 2, 3].map { String(describing: $0) }.flatMap { Int($0) }.reduce(0, +)
        
        // [TIME]: 116 ms
        let _ = [1, 2, 3].map { (num: Int) -> String in String(num) }.flatMap { (str: String) -> Int? in Int(str) }.reduce(0, +)
    }
    
}


