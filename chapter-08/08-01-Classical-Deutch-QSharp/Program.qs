namespace _08_01_Classical_Deutch_QSharp 
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    @EntryPoint()
    operation SayHello() : Unit 
    {
        let constantZeroResult = Deutch(ConstantZero);
        Message($"ConstantZero => {constantZeroResult}");

        let constantOneResult = Deutch(ConstantOne);
        Message($"ConstantOne => {constantOneResult}");

        let identityResult = Deutch(Identity);
        Message($"Identity => {identityResult}");

        let negationResult = Deutch(Negation);
        Message($"Negation => {negationResult}");
    }

    operation ConstantZero(bInput: Bool) : Bool
    {
        return false;
    }

    operation ConstantOne(bInput: Bool) : Bool
    {
        return true;
    }

    operation Identity(bInput: Bool) : Bool
    {
        return bInput;
    }

    operation Negation(bInput: Bool) : Bool
    {
        return not bInput;
    }

    operation Deutch(oracle: ((Bool) => Bool)) : String
    {
        let output1 = oracle(false);
        let output2 = oracle(true);
        
        if( output1 == output2 )
        {
            return "CONSTANT";
        }
        else
        {
            return "VARIABLE";
        }
    }
}