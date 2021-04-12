namespace _08_02_Quantum_Deutch_QSharp 
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;

    @EntryPoint()
    operation QuantumDeutsch() : Unit 
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

    operation ConstantZero(
        qInput: Qubit, qOutput: Qubit) : Unit
    {
        // NOP
    }

    operation ConstantOne(
        qInput: Qubit, qOutput: Qubit) : Unit
    {
        X(qOutput);
    }

    operation Identity(
        qInput: Qubit, qOutput: Qubit) : Unit
    {
        CNOT(qInput, qOutput);
    }

    operation Negation(
        qInput: Qubit, qOutput: Qubit) : Unit
    {
        CNOT(qInput, qOutput);
        X(qOutput);
    }

    operation Deutch(
        oracle: ((Qubit, Qubit) => Unit)) : String
    {
        use (qInput, qOutput) = (Qubit(), Qubit());
        
        X(qInput);
        X(qOutput);

        H(qInput);
        H(qOutput);

        oracle(qInput, qOutput);

        H(qInput);
        H(qOutput);

        let bInput = MResetZ(qInput);
        let bOutput = MResetZ(qOutput);

        if( bInput == bOutput )
        {
            return $"CONSTANT ({bInput}, {bOutput})";
        }
        else
        {
            return $"VARIABLE ({bInput}, {bOutput})";
        }
    }
}