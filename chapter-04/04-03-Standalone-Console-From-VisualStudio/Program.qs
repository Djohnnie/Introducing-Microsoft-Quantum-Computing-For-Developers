namespace Quantum._04_03_Standalone_Console_From_VisualStudio
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    
    @EntryPoint()
    operation SayHello() : Unit 
    {
        Message("Hello quantum world!");
    }
}