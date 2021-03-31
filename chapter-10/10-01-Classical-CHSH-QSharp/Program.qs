namespace _10_01_Classical_CHSH_QSharp 
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    
    @EntryPoint()
    operation SayHello() : Unit 
    {
        let numberOfGames = 10000;
        mutable winCount = 0;

        for playCount in 1 .. numberOfGames
        {
            let boolForAlice = GetRandomBit();
            let boolForBob = GetRandomBit();

            let (classicalXorA, classicalXorB) = 
                PlayClassic(boolForAlice, boolForBob);

            let bitForAlice = BoolArrayAsInt([boolForAlice]);
            let bitForBob = BoolArrayAsInt([boolForBob]);
            let bitProduct = bitForAlice * bitForBob;
            let bitXorClassic = 
                ModulusI(classicalXorA + classicalXorB, 2);
            
            if( bitProduct == bitXorClassic )
            {
                set winCount += 1;
            }
        }

        let winPercentage = 
            IntAsDouble(winCount) / IntAsDouble(numberOfGames)
              * 100.0;
        Message($"Win percentage: {Round(winPercentage)}%");
    }

    operation GetRandomBit() : Bool
    {
        use q = Qubit();
        H(q);
        let bit = MResetZ(q);
        return bit == One;
    }

    operation PlayClassic( 
        bitForAlice : Bool, bitForBob : Bool ) : (Int, Int)
    {        
        return (0, 0);
    }
}