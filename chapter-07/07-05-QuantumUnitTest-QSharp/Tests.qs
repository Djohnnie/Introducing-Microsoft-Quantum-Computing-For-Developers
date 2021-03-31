namespace _07_05_QuantumUnitTest_QSharp
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;

    @Test("QuantumSimulator")
    @Test("ToffoliSimulator")
    operation Qubit_In_Zero_State() : Unit
    {     
        // Arrange   
        use q = Qubit();

        // Act
        NoOp(q);

        // Assert
        AssertQubit(Zero, q);

        // Cleanup
        Reset(q);
    }

    @Test("QuantumSimulator")
    @Test("ToffoliSimulator")
    operation Qubit_In_One_State() : Unit
    {     
        // Arrange   
        use q = Qubit();

        // Act
        X(q);

        // Assert
        AssertQubit(One, q);

        // Cleanup
        Reset(q);
    }

    @Test("QuantumSimulator")
    operation Qubit_In_Superposition_State() : Unit
    {        
        // Arrange   
        use q = Qubit();

        // Act
        H(q);
        
        // Assert
        AssertMeasurementProbability(
            [PauliZ], [q], Zero, 0.5, "", .1);

        // Cleanup
        Reset(q);
    }
}