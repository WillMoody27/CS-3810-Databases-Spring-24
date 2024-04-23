"""
CS3810 - Principles of Database Systems - Spring 2024
Instructor: Thyago Mota
Student:
Description: Activity 01 - CalculatorTest
"""

import unittest
from calculator import Calculator


class CalculatorTest(unittest.TestCase):
    DELTA = 0.0000000001

    def testZeroAddZero(self):
        self.assertEqual(0, Calculator.add(0, 0))

    def testZeroAddPositive(self):
        self.assertEqual(5, Calculator.add(0, 5))

    def testPositiveAddZero(self):
        self.assertEqual(5, Calculator.add(5, 0))

    def testPositiveAddPositive(self):
        self.assertEqual(7, Calculator.add(5, 2))
        self.assertEqual(7, Calculator.add(2, 5))

    def testZeroAddNegative(self):
        self.assertEqual(-5, Calculator.add(0, -5))

    def testNegativeAddZero(self):
        self.assertEqual(-5, Calculator.add(-5, 0))

    def testNegativeAddNegative(self):
        self.assertEqual(-7, Calculator.add(-5, -2))
        self.assertEqual(-7, Calculator.add(-2, -5))

    def testPositiveAddNegative(self):
        self.assertEqual(3, Calculator.add(5, -2))

    def testNegativeAddPositive(self):
        self.assertEqual(-3, Calculator.add(-5, 2))

    def testZeroSubtractZero(self):
        self.assertEqual(0, Calculator.subtract(0, 0))

    def testZeroSubtractPositive(self):
        self.assertEqual(-5, Calculator.subtract(0, 5))

    def testPositiveSubtractZero(self):
        self.assertEqual(5, Calculator.subtract(5, 0))

    def testPositiveSubtractPositive(self):
        self.assertEqual(3, Calculator.subtract(5, 2))
        self.assertEqual(-3, Calculator.subtract(2, 5))

    def testZeroSubtractNegative(self):
        self.assertEqual(5, Calculator.subtract(0, -5))

    def testNegativeSubtractZero(self):
        self.assertEqual(-5, Calculator.subtract(-5, 0))

    def testNegativeSubtractNegative(self):
        self.assertEqual(-3, Calculator.subtract(-5, -2))
        self.assertEqual(3, Calculator.subtract(-2, -5))

    def testPositiveSubtractNegative(self):
        self.assertEqual(7, Calculator.subtract(5, -2))

    def testNegativeSubtractPositive(self):
        self.assertEqual(-7, Calculator.subtract(-5, 2))

    def testZeroMultiplyZero(self):
        self.assertEqual(0, Calculator.multiply(0, 0))

    def testZeroMultiplytPositive(self):
        self.assertEqual(0, Calculator.multiply(0, 5))

    def testPositiveMultiplytZero(self):
        self.assertEqual(0, Calculator.multiply(5, 0))

    def testPositiveMultiplyPositive(self):
        self.assertEqual(10, Calculator.multiply(5, 2))
        self.assertEqual(10, Calculator.multiply(2, 5))

    def testZeroMultiplyNegative(self):
        self.assertEqual(0, Calculator.multiply(0, -5))

    def testNegativeMultiplyZero(self):
        self.assertEqual(0, Calculator.multiply(-5, 0))

    def testNegativeMultiplyNegative(self):
        self.assertEqual(10, Calculator.multiply(-5, -2))
        self.assertEqual(10, Calculator.multiply(-2, -5))

    def testPositiveMultiplyNegative(self):
        self.assertEqual(-10, Calculator.multiply(5, -2))

    def testNegativeMultiplytPositive(self):
        self.assertEqual(-10, Calculator.multiply(-5, 2))

    def testZeroDivideZero(self):
        with self.assertRaises(ZeroDivisionError):
            Calculator.divide(0, 0)

    def testZeroDividePositive(self):
        self.assertAlmostEqual(0, Calculator.divide(0, 5), CalculatorTest.DELTA)

    def testPositiveDivideZero(self):
        with self.assertRaises(ZeroDivisionError):
            Calculator.divide(5, 0)

    def testPositiveDividePositive(self):
        self.assertAlmostEqual(2.5, Calculator.divide(5, 2), CalculatorTest.DELTA)
        self.assertAlmostEqual(0.4, Calculator.divide(2, 5), CalculatorTest.DELTA)

    def testZeroDivideNegative(self):
        self.assertAlmostEqual(0, Calculator.divide(0, -5), CalculatorTest.DELTA)

    def testNegativeDivideZero(self):
        with self.assertRaises(ZeroDivisionError):
            Calculator.divide(-5, 0)

    def testNegativeDivideNegative(self):
        self.assertAlmostEqual(2.5, Calculator.divide(-5, -2), CalculatorTest.DELTA)
        self.assertAlmostEqual(0.4, Calculator.divide(-2, -5), CalculatorTest.DELTA)

    def testPositiveDivideNegative(self):
        self.assertAlmostEqual(-2.5, Calculator.divide(5, -2), CalculatorTest.DELTA)

    def testNegativeDividePositive(self):
        self.assertAlmostEqual(-2.5, Calculator.divide(-5, 2), CalculatorTest.DELTA)


if __name__ == "__main__":
    unittest.main()
