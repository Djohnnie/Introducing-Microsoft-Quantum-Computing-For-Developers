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

        let xmodResult = DeutchJozsa(3, Xmod2);
        Message($"X mod 2 => {xmodResult}");

        let oddOnesResult = DeutchJozsa(3, OddNumberOfOnes);
        Message($"Odd number of Ones => {oddOnesResult}");
    }

    function ConstantZero(input: Bool[]) : Bool
    {
        return false;
    }

    function ConstantOne(input: Bool[]) : Bool
    {
        return true;
    }

    function Xmod2(input: Bool[]) : Bool
    {
        return input[0];
    }

    function OddNumberOfOnes(input: Bool[]) : Bool
    {
        mutable output = false;

        for bit in input
        {
            if( bit )
            {
                set output = not output;
            }
        }

        return output;
    }

    operation DeutchJozsa(
        n: Int, 
        oracle: Bool[] -> Bool) : String
    {
        mutable result = "CONSTANT";

        let firstValue = oracle(IntAsBoolArray(0, n));

        for input in 1 .. 2 ^ n - 1
        {
            let bits = IntAsBoolArray(input, n);            
            let nextValue = oracle(bits);

            if (nextValue != firstValue) 
            {
                set result = "BALANCED";
            }
        }
        
        return result;
    }
}