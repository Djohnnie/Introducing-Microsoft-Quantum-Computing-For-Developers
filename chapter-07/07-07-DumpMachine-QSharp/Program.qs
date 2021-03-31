namespace _07_07_DumpMachine_QSharp
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    
    @EntryPoint()
    operation SayHello() : Unit 
    {
        Superposition();
        Entanglement();
    }

    operation Superposition() : Unit
    {
        use qubits = Qubit[2];
        
        H(qubits[0]);
        H(qubits[1]);

        DumpMachine("superposition.txt");

        Reset(qubits[0]);
        Reset(qubits[1]);
    }

    operation Entanglement() : Unit
    {
        use qubits = Qubit[2];
        
        H(qubits[0]);
        CNOT(qubits[0], qubits[1]);

        DumpMachine("entanglement.txt");

        Reset(qubits[0]);
        Reset(qubits[1]);
    }
}