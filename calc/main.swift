//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

var args = ProcessInfo.processInfo.arguments
args.removeFirst()  // remove the name of the program

// Initialize a Calculator object
let calculator = Calculator()

do {
    let result = try calculator.calculate(args: args)
    print(result)
} catch CalculatorError.divisionByZero {
    print("ERROR: Division by zero")
} catch CalculatorError.invalidInteger {
    print("ERROR: Invalid integer")
} catch CalculatorError.invalidOperator {
    print("ERROR: Invalid operator")
} catch CalculatorError.invalidInput {
    print("ERROR: Invalid input")
} catch CalculatorError.integerOverflow {
    print("ERROR: Integer overflow")
} catch {
    print("ERROR: An unknown error occurred")
}

/* LSP doesn't recognise CalculatorError as an enum if I do this (open issue on SourceKit GitHub)
do {
    let result = try calculator.calculate(args: args)
    print(result)
} catch let error as CalculatorError {
    switch error {
    case .divisionByZero: print("ERROR: Division by zero")
    case .invalidInteger: print("ERROR: Invalid integer")
    case .invalidOperator: print("ERROR: Invalid operator")
    case .invalidInput: print("ERROR: Invalid input")
    case .integerOverflow: print("ERROR: Integer overflow")
    }
    exit(1)
} catch {
    print("ERROR: An unknown error occurred")
    exit(1)
}
*/

/* LSP doesn't recognise CalculatorError as an enum if I do this (open issue on SourceKit GitHub)
do {
    let result = try calculator.calculate(args: args)
    print(result)
} catch {
    switch error {
    case CalculatorError.divisionByZero: print("ERROR: Division by zero")
    case CalculatorError.invalidInteger: print("ERROR: Invalid integer")
    case CalculatorError.invalidOperator: print("ERROR: Invalid operator")
    case CalculatorError.invalidInput: print("ERROR: Invalid input")
    case CalculatorError.integerOverflow: print("ERROR: Integer overflow")
    default: print("ERROR: An unknown error occurred")
    }
    exit(1)
}
*/
