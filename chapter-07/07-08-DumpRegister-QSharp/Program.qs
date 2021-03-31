namespace _07_08_DumpRegister_QSharp 
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Diagnostics;

    @EntryPoint()
    operation SayHello() : Unit 
    {
        use (qMessage, qAlice, qBob) 
            = (Qubit(), Qubit(), Qubit());
        
        Ry( 2.0 * PI() / 3.0, qMessage );

        DumpRegister("qMessage-before.txt", [qMessage]);
        DumpRegister("qAlice-before.txt", [qAlice]);
        DumpRegister("qBob-before.txt", [qBob]);

        H(qAlice);
        CNOT(qAlice, qBob);

        CNOT(qMessage, qAlice);
        H(qMessage);

        let bAlice = M(qAlice);
        if( bAlice == One )
        {
            X(qBob);
        }

        let bMessage = M(qMessage);
        if( bMessage == One )
        {
            Z(qBob);
        }            

        DumpRegister("qMessage-after.txt", [qMessage]);
        DumpRegister("qAlice-after.txt", [qAlice]);
        DumpRegister("qBob-after.txt", [qBob]);

        Reset(qMessage);
        Reset(qAlice);
        Reset(qBob);
    }
}