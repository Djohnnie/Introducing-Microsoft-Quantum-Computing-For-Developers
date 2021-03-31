namespace _07_04_ToffoliSimulator_QSharp
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    
    @EntryPoint()
    operation ToffoliSimulator() : Unit 
    {
        Perform(AllQubitsOne);
        Perform(AllQubitsOneExceptLast);
    }

    operation AllQubitsOne(qs: Qubit[]) : Unit
    {
        ApplyToEach(X, qs);
    }

    operation AllQubitsOneExceptLast(qs: Qubit[]) : Unit
    {
        ApplyToEach(X, qs);
        ApplyToTail(X, qs);
    }

    operation Perform(op: (Qubit[] => Unit)) : Unit
    {
        use qubits = Qubit[65535];
        op(qubits);
        use qResult = Qubit();
        Controlled X(qubits, qResult);

        let bResult = M(qResult);
        
        ResetAll(qubits);
        Reset(qResult);

        Message($"{op}: {bResult}");
    }
}