namespace _05_06_Quantum
{    
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    
    operation GenerateRandomNumber(maximum : Int) : Int
    {
        let bitSize = BitSizeI(maximum);
        mutable resultArray = new Result[0];
        mutable randomNumber = 0;

        repeat
        {
            set resultArray = new Result[0];
            
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

        return randomNumber;
    }
}