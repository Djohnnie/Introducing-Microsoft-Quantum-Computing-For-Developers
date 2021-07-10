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
        let constantZeroResult = DeutchJozsa(3, "1-ConstantZero", ConstantZero);
        Message($"ConstantZero => {constantZeroResult}");

        let constantOneResult = DeutchJozsa(3, "2-ConstantOne", ConstantOne);
        Message($"ConstantOne => {constantOneResult}");

        let identityResult = DeutchJozsa(3, "3-Xmod2", Xmod2);
        Message($"X mod 2 => {identityResult}");

        let negationResult = DeutchJozsa(3, "4-OddNumberOfOnes", OddNumberOfOnes);
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
        n: Int, description: String,
        oracle: ((Qubit[], Qubit) => Unit)) : String
    {
        mutable isConstant = true;

        use (qN, qOutput) = (Qubit[n], Qubit());
        
        DumpRegister($"{description}-step1.txt", qN);

        ApplyToEachA(H, qN);
        X(qOutput);
        
        DumpRegister($"{description}-step2.txt", qN);

        H(qOutput);
        
        DumpRegister($"{description}-step3.txt", qN);
        
        oracle(qN, qOutput);
        
        DumpRegister($"{description}-step4.txt", qN);
        
        ApplyToEachA(H, qN);
        
        DumpRegister($"{description}-step5.txt", qN);

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