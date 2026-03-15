class EquationParser {
    let arithmeticEngine = ArithmeticEngine()

    func evaluateHighPriority(args: [String]) throws -> [String] {
        // Create a mutable copy of arg so that calculated values can be used in the next iteration
        var mutableArgs = args

        // To do BODMAS the calculater needs to first handle multiply, divide and modulus on the initial input.
        // After that you are left with an equation with just addition and subtraction.
        var lowPriorityEquation: [String] = []

        // Division, Multiplication and Modulus
        var i = 0
        while i < mutableArgs.count {
            if Int(mutableArgs[i]) != nil {  // The current index is a number
                if mutableArgs.count - i > 2 {
                    if Int(mutableArgs[i + 1]) != nil {  // Next index is expected to be an operator
                        throw CalculatorError.invalidOperator
                    }
                }

                if mutableArgs.count - i > 3 {
                    if Int(mutableArgs[i + 2]) == nil {  // Second next index is expected to be a number
                        throw CalculatorError.invalidInteger
                    }
                }
            }

            // Add addition and subtraction operations to addSubEquation
            if Int(mutableArgs[i]) == nil {  // If the current index is an operator
                if mutableArgs.count - i > 3 {
                    if Int(mutableArgs[i + 2]) != nil {  // Second next index is expected to be an operator
                        throw CalculatorError.invalidOperator
                    }
                }

                let _operator = mutableArgs[i]
                let operators = ["-", "+"]  // Any strings other than these are invalid

                if operators.contains(_operator) {
                    lowPriorityEquation.append(_operator)  // Adds the addition and subtraction operators to addSubEquation.
                } else {
                    throw CalculatorError.invalidOperator
                }

                if mutableArgs.count - i <= 2 {
                    if Int(mutableArgs[i + 1]) != nil {
                        lowPriorityEquation.append(String(mutableArgs[i + 1]))  // Include the last number from args into the new equation
                    } else {
                        throw CalculatorError.invalidInteger
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
                    result = try arithmeticEngine.multiply(no1: first, no2: second)
                }
            case "/":
                if let first = Int(mutableArgs[i]), let second = Int(mutableArgs[i + 2]) {
                    result = try arithmeticEngine.divide(no1: first, no2: second)
                }
            case "%":
                if let first = Int(mutableArgs[i]), let second = Int(mutableArgs[i + 2]) {
                    result = try arithmeticEngine.modulus(no1: first, no2: second)
                }
            case "+", "-":
                lowPriorityEquation.append(mutableArgs[i])  // Add the current number to addSubEquation
                i += 1 // Iterate to the next operator so the next iteration can add it t addSubEquation
                continue
            default:
                throw CalculatorError.invalidOperator
            }

            // Check if the next operator is one of x, / or %
            if (mutableArgs.indices.contains(i + 3))
                && (mutableArgs[i + 3] == "x" || mutableArgs[i + 3] == "/"
                    || mutableArgs[i + 3] == "%")
            {
                mutableArgs[i + 2] = String(result)
                i += 2  // Iterate to the next number
            } else {
                lowPriorityEquation.append(String(result))
                i += 3  // Iterate to the next operator
            }
        }

        return lowPriorityEquation
    }

    func evaluateLowPriority(lowPriorityEquation: [String]) throws -> String {
        // Addition/Subtraction
        var result = lowPriorityEquation[0]
        var i = 1
        while i < lowPriorityEquation.count {
            let _operator = lowPriorityEquation[i]
            if _operator == "+" {
                if let first = Int(result), let second = Int(lowPriorityEquation[i + 1]) {
                    result = String(try arithmeticEngine.add(no1: first, no2: second))
                }
            } else if _operator == "-" {
                if let first = Int(result), let second = Int(lowPriorityEquation[i + 1]) {
                    result = String(try arithmeticEngine.subtract(no1: first, no2: second))
                }
            }
            i += 2
        }

        return result
    }

}
