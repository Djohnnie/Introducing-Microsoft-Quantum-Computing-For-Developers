import qsharp

from _05_06_Quantum import GenerateRandomNumber

max = input( 'Maximum: ')
result = GenerateRandomNumber.simulate( maximum = max )

print( result )