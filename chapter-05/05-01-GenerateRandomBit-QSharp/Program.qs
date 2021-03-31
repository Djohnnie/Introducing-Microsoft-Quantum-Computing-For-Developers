namespace _05_01
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    
    @EntryPoint()
    operation GenerateRandomBit() : Unit 
    {
        use qubit = Qubit();
        
        H(qubit);

        let measuredResult = M(qubit);

        Reset(qubit);

        if(measuredResult == Zero)
        {
            Message("0");
        }
        else
        {
            Message("1");
        }
    }
}