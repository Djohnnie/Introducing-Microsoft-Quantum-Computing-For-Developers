namespace _04_04_QSharp_From_Python
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    
    @EntryPoint()
    operation HelloQ () : Unit 
    {
        Message("Hello quantum world!");
    }
}