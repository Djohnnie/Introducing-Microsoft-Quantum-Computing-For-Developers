namespace _07_06_QuantumDebugging_QSharp
{
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    
    @EntryPoint()
    operation DebugYourQuantumProgram() : Unit
    {
        use (q1, q2, q3) = (Qubit(), Qubit(), Qubit());

        let b1 = DebugX(q1);
        let b2 = DebugH(q2);
        let b3 = DebugRy(q3);

        let bits = [b1, b2, b3];
        Message($"{bits}");
    }

    operation DebugX(q : Qubit) : Result
    {
        X(q);
        let b = M(q);
        Reset(q);
        return b;
    }

    operation DebugH(q : Qubit) : Result
    {
        H(q);
        let b = M(q);
        Reset(q);
        return b;
    }

    operation DebugRy(q : Qubit) : Result
    {
        Ry(2.0 * PI() / 3.0, q);
        let b = M(q);
        Reset(q);
        return b;
    }
}