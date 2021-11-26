namespace _07_02_QuantumResourceEstimators_QSharp
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    
    @EntryPoint()
    operation HelloQ() : Unit
    {
        let maximum = 1023;

        let bitSize = BitSizeI(maximum);
        Message($"{bitSize}");
        mutable resultArray = [Zero, size = 0];
        mutable randomNumber = 0;

        repeat
        {
            set resultArray = [Zero, size = 0];
            
            use qubits = Qubit[bitSize];
            ApplyToEach(X, qubits);
            ApplyToEach(Y, qubits);
            ApplyToEach(Z, qubits);
            ApplyToEach(H, qubits);

            Ry(PI(), qubits[0]);

            for index in 0..bitSize-1
            {
                set resultArray += [M(qubits[index])];
            }

            set randomNumber = ResultArrayAsInt(resultArray);
        }
        until(randomNumber < maximum);

        Message($"{randomNumber}");
    }
}