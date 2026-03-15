class ArithmeticEngine {
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
    func add(no1: Int, no2: Int) throws -> Int {
        let (result, overflow) = no1.addingReportingOverflow(no2)
        if overflow { throw CalculatorError.integerOverflow }
        return result
    }

    func subtract(no1: Int, no2: Int) throws -> Int {
        let (result, overflow) = no1.subtractingReportingOverflow(no2)
        if overflow { throw CalculatorError.integerOverflow }
        return result
    }

    func multiply(no1: Int, no2: Int) throws -> Int {
        let (result, overflow) = no1.multipliedReportingOverflow(by: no2)
        if overflow { throw CalculatorError.integerOverflow }
        return result
    }

    func divide(no1: Int, no2: Int) throws -> Int {
        if no2 == 0 {  // Exit when dividing by 0
            throw CalculatorError.divisionByZero
        }
        let (result, overflow) = no1.dividedReportingOverflow(by: no2)
        if overflow { throw CalculatorError.integerOverflow }
        return result
    }

    func modulus(no1: Int, no2: Int) throws -> Int {
        if no2 == 0 {  // Exit when dividing by 0
            throw CalculatorError.divisionByZero
        }
        let (result, overflow) = no1.remainderReportingOverflow(dividingBy: no2)
        if overflow { throw CalculatorError.integerOverflow }
        return result
    }
}
