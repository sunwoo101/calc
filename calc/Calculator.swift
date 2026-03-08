//
//  Calculator.swift
//  calc
//
//  Created by Jacktator on 31/3/20.
//  Copyright © 2020 UTS. All rights reserved.
//

import Foundation

class Calculator {

    /// For multi-step calculation, it's helpful to persist existing result
    var currentResult = 0

    /// Perform Addition
    ///
    /// - Author: Jacktator
    /// - Parameters:
    ///   - no1: First number
    ///   - no2: Second number
    /// - Returns: The addition result
    ///
    /// - Warning: The result may yield Int overflow.
    /// - SeeAlso: https://developer.apple.com/documentation/swift/int/2884663-addingreportingoverflow
    func add(no1: Int, no2: Int) -> Int {
        return no1 + no2
    }

    func subtract(no1: Int, no2: Int) -> Int {
        return no1 - no2
    }

    func multiply(no1: Int, no2: Int) -> Int {
        return no1 * no2
    }

    func divide(no1: Int, no2: Int) -> Int {
        return no1 / no2
    }

    func modulus(no1: Int, no2: Int) -> Int {
        return no1 % no2
    }

    func calculate(args: [String]) -> String {
        // No args is not a valid equation
        if args.count == 0 {
            exit(1)
        }

        // Only 1 arg
        if args.count == 1 {
            // Is a valid number
            if let num = Int(args[0]) {
                return String(num)
            } else {  // Not valid
                exit(1)
            }
        }

        // Last arg is invalid
        if Int(args[args.count - 1]) == nil {
            exit(1)
        }

        // Create a mutable copy of arg so that calculated values can be used in the next iteration
        var mutableArgs = args

        // To do BODMAS the calculater needs to first handle multiply, divide and modulus on the initial input.
        // After that you are left with an equation with just addition and subtraction.
        var addSubEquation: [String] = []

        // Division, Multiplication and Modulus
        var i = 0
        while i < mutableArgs.count {
            if Int(mutableArgs[i]) != nil {  // The current index is a number
                if mutableArgs.count - i > 2 {
                    if Int(mutableArgs[i + 1]) != nil {  // Can't have 2 numbers in a row in an equation
                        exit(1)
                    }
                }

                if mutableArgs.count - i > 3 {
                    if Int(mutableArgs[i + 2]) == nil {  // Can't have 2 operators in a row in an equation
                        exit(1)
                    }
                }
            }

            // Add addition and subtraction operations to addSubEquation
            if Int(mutableArgs[i]) == nil {  // If the current index is an operator
                if mutableArgs.count - i > 3 {
                    if Int(mutableArgs[i + 2]) != nil {  // Can't have 2 number in a row in an equation
                        exit(1)
                    }
                }

                let _operator = mutableArgs[i]
                let operators = ["-", "+"]  // Any strings other than these are invalid

                if operators.contains(_operator) {
                    addSubEquation.append(_operator)  // Adds the addition and subtraction operators to addSubEquation.
                } else {
                    exit(1)
                }

                if mutableArgs.count - i <= 2 {
                    if Int(mutableArgs[i + 1]) != nil {
                        addSubEquation.append(String(mutableArgs[i + 1]))  // Include the last number from args into the new equation
                    } else {
                        exit(1)
                    }
                    break
                }
                i += 1
                continue
            }

            var result = 0;
            let _operator = mutableArgs[i + 1]
            switch _operator {
            case "x":
                if let first = Int(mutableArgs[i]), let second = Int(mutableArgs[i + 2]) {
                    result = multiply(no1: first, no2: second)
                }
            case "/":
                if let first = Int(mutableArgs[i]), let second = Int(mutableArgs[i + 2]) {
                    if second == 0 {  // Exit when dividing by 0
                        exit(1)
                    }
                    result = divide(no1: first, no2: second)
                }
            case "%":
                if let first = Int(mutableArgs[i]), let second = Int(mutableArgs[i + 2]) {
                    if second == 0 {  // Exit when dividing by 0
                        exit(1)
                    }
                    result = modulus(no1: first, no2: second)
                }
            case "+", "-":
                addSubEquation.append(mutableArgs[i])  // Add the current number to addSubEquation
                i += 1 // Iterate to the next operator so the next iteration can add it t addSubEquation
                continue
            default:
                exit(1)
            }

            // Check if the next operator is one of x, / or %
            if (mutableArgs.indices.contains(i + 3))
                && (mutableArgs[i + 3] == "x" || mutableArgs[i + 3] == "/"
                    || mutableArgs[i + 3] == "%")
            {
                mutableArgs[i + 2] = String(result)
                i += 2  // Iterate to the next number
            } else {
                addSubEquation.append(String(result))
                i += 3  // Iterate to the next operator
            }
        }

        // Addition/Subtraction
        var result = addSubEquation[0]
        i = 1
        while i < addSubEquation.count {
            let _operator = addSubEquation[i]
            if _operator == "+" {
                if let first = Int(result), let second = Int(addSubEquation[i + 1]) {
                    result = String(add(no1: first, no2: second))
                }
            } else if _operator == "-" {
                if let first = Int(result), let second = Int(addSubEquation[i + 1]) {
                    result = String(subtract(no1: first, no2: second))
                }
            }
            i += 2
        }

        return (String(result))
    }
}
