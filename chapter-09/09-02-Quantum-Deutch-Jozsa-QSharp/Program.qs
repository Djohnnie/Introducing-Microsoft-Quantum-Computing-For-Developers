namespace _09_02_Quantum_Deutch_Jozsa_QSharp 
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Diagnostics;

    @EntryPoint()
    operation QuantumDeutschJozsa() : Unit 
    {
        let constantZeroResult = DeutchJozsa(1, ConstantZero);
        Message($"ConstantZero => {constantZeroResult}");

        let constantOneResult = DeutchJozsa(1, ConstantOne);
        Message($"ConstantOne => {constantOneResult}");

        let identityResult = DeutchJozsa(1, Xmod2);
        Message($"X mod 2 => {identityResult}");

        let negationResult = DeutchJozsa(1, OddNumberOfOnes);
        Message($"Odd number of Ones => {negationResult}");
    }

    operation ConstantZero(
        qInputs: Qubit[], qOutput: Qubit) : Unit
    {
        // NOP
    }

    operation ConstantOne(
        qInputs: Qubit[], qOutput: Qubit) : Unit
    {
         X(qOutput);
    }

    operation Xmod2(
        qInputs: Qubit[], qOutput: Qubit) : Unit
    {
            CNOT(qInputs[0], qOutput);
    }

    operation OddNumberOfOnes(
        qInputs: Qubit[], qOutput: Qubit) : Unit
    {
        for q in qInputs
        {
            CNOT(q, qOutput);
        }
    }   

    operation DeutchJozsa(
        n: Int,
        oracle: (Qubit[], Qubit) => Unit) : String
    {
        mutable isConstant = true;

        use (qInput, qOutput) = (Qubit[n], Qubit());

        ApplyToEachA(H, qInput);
        X(qOutput);
        H(qOutput);
        
        oracle(qInput, qOutput);
        
        ApplyToEachA(H, qInput);

        for q in qInput
        {
            if (M(q) == One) 
            {
                set isConstant = false;
            }
        }
 
        ResetAll(qInput);
        Reset(qOutput);  

        return isConstant ? "CONSTANT" | "BALANCED";
    }
}