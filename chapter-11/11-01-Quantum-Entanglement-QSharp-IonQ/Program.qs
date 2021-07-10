namespace _11_01_Quantum_Entanglement_QSharp_IonQ
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    
    @EntryPoint()
    operation EntangleQubits() : (Result, Result)
    {
        use (q1, q2) = (Qubit(), Qubit());

        Ry(2.0 * PI() / 3.0, q1);
        CNOT(q1,q2);
        
        return (M(q1), M(q2));
    }
}