namespace _09_02_Quantum_Deutch_Jozsa_QSharp 
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;

    @EntryPoint()
    operation QuantumDeutschJozsa() : Unit 
    {
        let constantZeroResult = DeutchJozsa(5, ConstantZero);
        Message($"ConstantZero => {constantZeroResult}");

        let constantOneResult = DeutchJozsa(5, ConstantOne);
        Message($"ConstantOne => {constantOneResult}");

        let identityResult = DeutchJozsa(5, Xmod2);
        Message($"X mod 2 => {identityResult}");

        let negationResult = DeutchJozsa(5, OddNumberOfOnes);
        Message($"Odd number of Ones => {negationResult}");
    }

    operation ConstantZero(
        qN: Qubit[], qOutput: Qubit) : Unit
    {
        // NOP
    }

    operation ConstantOne(
        qN: Qubit[], qOutput: Qubit) : Unit
    {
         X(qOutput);
    }

    operation Xmod2(
        qN: Qubit[], qOutput: Qubit) : Unit
    {
        for q in qN
        {
            CNOT(q, qOutput);
        }
    }

    operation OddNumberOfOnes(
        qN: Qubit[], qOutput: Qubit) : Unit
    {
        for q in qN
        {
            CNOT(q, qOutput);
        }

        X(qOutput);
    }   

    operation DeutchJozsa(
        n: Int,
        oracle: ((Qubit[], Qubit) => Unit)) : String
    {
        mutable isConstant = true;

        use (qN, qOutput) = (Qubit[n], Qubit());
        
        ApplyToEachA(H, qN);
        X(qOutput);
        H(qOutput);
        
        oracle(qN, qOutput);
        
        ApplyToEachA(H, qN);

        for q in qN
        {
            if (M(q) == One) 
            {
                set isConstant = false;
            }
        }
 
        ResetAll(qN);
        Reset(qOutput);  

        return isConstant ? "CONSTANT" | "BALANCED";
    }
}