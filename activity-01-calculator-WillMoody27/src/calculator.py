"""
CS3810 - Principles of Database Systems - Spring 2024
Instructor: Thyago Mota
Student: William Hellems-Moody
Description: Activity 01 - Calculator
"""
import math


class Calculator:
    DELTA = 0.0000000001

    @staticmethod
    def add(a, b):
        return a + b

    @staticmethod
    def subtract(a, b):
        return a - b

    @staticmethod
    def multiply(a, b):
        return a * b

    @staticmethod
    def divide(a, b):
        return a / b
