namespace _07_01_FullStateSimulator_QSharp 
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    
    @EntryPoint()
    operation FullStateSimulator() : Unit 
    {
        let maximum = 1023;

        let bitSize = BitSizeI(maximum);
        mutable resultArray = [Zero, size = 0];
        mutable randomNumber = 0;

        set resultArray = [Zero, size = 0];            
        for index in 0..bitSize-1
        {
            use q = Qubit();
            use qubit = Qubit();
            H(qubit);
            set resultArray += [M(qubit)];
            Reset(qubit);
        }

        set randomNumber = ResultArrayAsInt(resultArray);
        Message($"{randomNumber}");
    }
}