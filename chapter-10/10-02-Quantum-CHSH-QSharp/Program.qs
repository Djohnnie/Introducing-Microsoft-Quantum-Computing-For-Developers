namespace _10_02_Quantum_CHSH_QSharp 
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    
    @EntryPoint()
    operation QuantumCHSH() : Unit 
    {
        let numberOfGames = 10000;
        mutable winCount = 0;

        for playCount in 1 .. numberOfGames
        {
            let boolForAlice = GetRandomBit();
            let boolForBob = GetRandomBit();

            let (quantumXorA, quantumXorB) = 
                PlayQuantum(boolForBob, boolForAlice);

            let bitForAlice = BoolArrayAsInt([boolForAlice]);
            let bitForBob = BoolArrayAsInt([boolForBob]);
            let bitProduct = bitForAlice * bitForBob;
            let bitXorQuantum = 
                ModulusI(quantumXorA + quantumXorB, 2);
                
            if( bitProduct == bitXorQuantum )
            {
                set winCount += 1;
            }
        }

        let winPercentage = 
            IntAsDouble(winCount)             /             IntAsDouble(numberOfGames) 
            *             100.0;
        Message($"Win percentage: {Round(winPercentage)}%");
    }

    operation GetRandomBit() : Bool
    {
        use q = Qubit();
        H(q);
        let bit = MResetZ(q);
        return bit == One;
    }

    operation PlayQuantum( 
        boolForAlice : Bool, boolForBob : Bool ) : (Int, Int)
    {
        use (qubitForAlice, qubitForBob) = (Qubit(), Qubit());

        H(qubitForAlice);
        CNOT(qubitForAlice, qubitForBob);

        if( GetRandomBit() )
        {
            let resultForAlice = 
                MeasureForAlice(boolForAlice, qubitForAlice);
            let bitForAlice = resultForAlice == One ? 1 | 0;
            
            let resultForBob =
                MeasureForBob(boolForBob, qubitForBob);
            let bitForBob = resultForBob == One ? 1 | 0;

            return (bitForAlice, bitForBob);
        }
        else
        {
            let resultForBob =
                MeasureForBob(boolForBob, qubitForBob);
            let bitForBob = resultForBob == One ? 1 | 0;

            let resultForAlice = 
                MeasureForAlice(boolForAlice, qubitForAlice);
            let bitForAlice = resultForAlice == One ? 1 | 0;
            
            return (bitForAlice, bitForBob);
        }
    }

    operation MeasureForAlice( 
        bit : Bool, qubit : Qubit) : Result
    {
        if( bit )
        {
            return MResetX(qubit);
        }
        else
        {
            return MResetZ(qubit);
        }
    }

    operation MeasureForBob( 
        bit : Bool, qubit : Qubit) : Result
    {
        if( bit )
        {
            Ry(2.0 * PI() / 8.0, qubit);
        }
        else
        {
            Ry(-2.0 * PI() / 8.0, qubit);
        }

        return MResetZ(qubit);
    }
}