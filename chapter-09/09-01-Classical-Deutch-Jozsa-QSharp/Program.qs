namespace _09_01_Classical_Deutch_Jozsa_QSharp 
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;

    @EntryPoint()
    operation ClassicalDeutchJozsa() : Unit 
    {
        let constantZeroResult = DeutchJozsa(3, ConstantZero);
        Message($"ConstantZero => {constantZeroResult}");

        let constantOneResult = DeutchJozsa(3, ConstantOne);
        Message($"ConstantOne => {constantOneResult}");

        let identityResult = DeutchJozsa(3, Xmod2);
        Message($"X mod 2 => {identityResult}");

        let negationResult = DeutchJozsa(3, OddNumberOfOnes);
        Message($"Odd number of Ones => {negationResult}");
    }

    function ConstantZero(bInput: Bool[]) : Bool
    {
        return false;
    }

    function ConstantOne(bInput: Bool[]) : Bool
    {
        return true;
    }

    function Xmod2(bInput: Bool[]) : Bool
    {
        mutable output = false;

        for b in bInput
        {
            if( b )
            {
                set output = not output;
            }
        }

        return output;
    }

    function OddNumberOfOnes(bInput: Bool[]) : Bool
    {
        mutable output = false;

        for b in bInput
        {
            if( b )
            {
                set output = not output;
            }
        }

        return not output;
    }

    operation DeutchJozsa(
        n: Int, 
        oracle: ((Bool[]) -> Bool)) : String
    {
        let firstValue = oracle(IntAsBoolArray(0, n));

        for input in 1 .. (2 ^ n - 1)
        {
            let nextValue = oracle(IntAsBoolArray(input, n));
            
            if (nextValue != firstValue) 
            {
                return "BALANCED";
            }
        }
        
        return "CONSTANT";
    }
}