namespace _09_03_Quantum_Deutch_Jozsa_Phase_Oracle_QSharp
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

    operation ConstantZero(qN: Qubit[]) : Unit
    {
        // NOP
    }

    operation ConstantOne(qN: Qubit[]) : Unit
    {
         R(PauliI, 2.0 * PI(), qN[0]);
    }

    operation Xmod2(qN: Qubit[]) : Unit
    {
        Z(qN[Length(qN) - 1]);
    }

    operation OddNumberOfOnes(qN: Qubit[]) : Unit
    {
        ApplyToEach(Z, qN);
    }   

    operation DeutchJozsa(
        n: Int, description: String,
        oracle: ((Qubit[]) => Unit)) : String
    {
        mutable isConstant = true;

        use qN = Qubit[n];
        
        DumpMachine($"{description}-step1.txt");

        ApplyToEachA(H, qN);
        
        DumpMachine($"{description}-step2.txt");
        
        oracle(qN);
        
        DumpMachine($"{description}-step3.txt");
        
        ApplyToEachA(H, qN);
        
        DumpMachine($"{description}-step4.txt");

        for q in qN
        {
            if (M(q) == One) 
            {
                set isConstant = false;
            }
        }
 
        ResetAll(qN);

        return isConstant ? "CONSTANT" | "BALANCED";
    }
}