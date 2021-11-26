namespace _05_04
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
 
    @EntryPoint()
    operation GenerateRandomNumber() : Unit
    {
        let maximum = 10;

        let bitSize = BitSizeI(maximum);
        mutable resultArray = [Zero, size = 0];
        mutable randomNumber = 0;

        repeat
        {
            set resultArray = [Zero, size = 0];
            
            for index in 0..bitSize-1
            {
                use qubit = Qubit();
                
                H(qubit);
                set resultArray += [M(qubit)];
                Reset(qubit);
            }

            set randomNumber = ResultArrayAsInt(resultArray);
        }
        until(randomNumber < maximum);

        Message($"{randomNumber}");
    }
}