//
//  Calculator.swift
//  calc
//
//  Created by Jacktator on 31/3/20.
//  Copyright © 2020 UTS. All rights reserved.
//

import Foundation

class Calculator {
    let equationParser = EquationParser()
    func calculate(args: [String]) throws -> String {
        // No args is not a valid equation
        if args.count == 0 {
            throw CalculatorError.invalidInput
        }

        // Only 1 arg
        if args.count == 1 {
            // Is a valid number
            if let num = Int(args[0]) {
                return String(num)
            } else {  // Not valid
                throw CalculatorError.invalidInteger
            }
        }

        // Last arg is invalid
        if Int(args[args.count - 1]) == nil {
            throw CalculatorError.invalidInteger
        }

        let lowPriorityEquation = try equationParser.evaluateHighPriority(args: args)
        let result = try equationParser.evaluateLowPriority(lowPriorityEquation: lowPriorityEquation)

        return (String(result))
    }
}
