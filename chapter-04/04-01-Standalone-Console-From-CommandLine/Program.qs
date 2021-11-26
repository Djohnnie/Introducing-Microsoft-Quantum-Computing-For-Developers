namespace _04_01_Standalone_Console_From_CommandLine
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    @EntryPoint()
    operation SayHello() : Unit 
    {
        Message("Hello quantum world!");
    }
}