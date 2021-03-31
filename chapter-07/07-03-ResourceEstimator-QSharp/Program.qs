namespace _07_03_ResourceEstimator_QSharp 
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    
    @EntryPoint()
    operation ResourceEstimator() : Unit 
    {
        let maximum = 1023;

        let bitSize = BitSizeI(maximum);
        mutable randomNumber = 0;

        use qubits = Qubit[bitSize];
        ApplyToEach(H, qubits);
        let resultArray = MultiM(qubits);
        ResetAll(qubits);
        set randomNumber = ResultArrayAsInt(resultArray);
        Message($"{randomNumber}");
    }
}