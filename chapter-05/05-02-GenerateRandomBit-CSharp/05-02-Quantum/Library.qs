namespace _05_02_Quantum
{    
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation GenerateRandomBit() : Bool
    {
        use qubit = Qubit();
        
        H(qubit);

        let measuredBit = M(qubit);

        Reset(qubit);

        return measuredBit == One;
    }
}