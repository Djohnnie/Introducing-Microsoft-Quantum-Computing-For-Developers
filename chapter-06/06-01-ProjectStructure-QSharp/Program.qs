namespace _06_01
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;    
    open Microsoft.Quantum.Math; 
    open Microsoft.Quantum.Diagnostics;
    
    /// # Summary
    /// Puts a qubit in superposition and measures its
    /// state to return as a result from this operation.
    ///
    /// # Output
    /// A result, Zero or One, after qubit measurement.
    ///
    /// # See Also
    /// - Microsoft.Quantum.Intrinsic.H
    @EntryPoint()
    operation HelloQuantum() : Result 
    {
        // Allocate a single qubit and assign it 
        // to the immutable variable 'qubit'.
        use qubit = Qubit();

        Conjugation(qubit);     

        // Apply the Hadamard transformation to that qubit.
        // DumpRegister("quantum0.txt",[qubit]);
        // CUSTOM(qubit);
        // DumpRegister("quantum1.txt",[qubit]);
        // Adjoint CUSTOM(qubit);
        // DumpRegister("quantum2.txt",[qubit]);


        // Perform a measurement of the qubit in the Pauli-Z 
        // basis and return the result of that measurement.
        //return M(qubit);

        ExecuteManyTimes(qubit, H, 2);

        ExecuteManyTimes(qubit, Ry(PI() / 4.0, _), 2);


let twice = Multiply(_, 2);
let result = twice(10);

    let values = [true, false, true, false];
    let results = Project<Bool, Result>(values, BoolAsResult);

// let sum = CalculateSum(4, 5);
// let calculateSumCall = CalculateSum;
// let anotherSum = calculateSumCall(6, 7);

        return M(qubit);
    }

operation Conjugation(q : Qubit) : Unit
{
    use temp = Qubit();

    within
    {
        H(temp);
        CNOT(temp, q);
    }
    apply
    {
        H(q);
    }
}

function Project<'TIn, 'TOut>(input: 'TIn[], projection: 'TIn -> 'TOut) : 'TOut[]
{
    let arrayLength = Length(input);
    mutable projected = new 'TOut[arrayLength];

    for i in 0..arrayLength-1
    {
        set projected w/= i <- projection(input[i]);
    }

    return projected;
}


operation First() : Unit
{
    let (x, y) = (1, 2);

    if(x == y)
    {
        let n = 4;
        // n is 4
    }

    let n = 9;
    // n is 9
}

operation Second() : Unit
{
    let (x, y) = (1, 2);

    if(x == y)
    {
        let n = 4;
        // n is 4
    }
    else
    {
        let n = 9;
        // n is 9
    }    

    // n does not exist
}


operation ExecuteManyTimes(q: Qubit, op: Qubit => Unit, n: Int) : Unit
{
    for _ in 1..n
    {
        op(q);
    }
}

function CalculateSum(x: Int, y: Int) : Int
{
    return x + y;
}

function Multiply(number: Int, factor: Int) : Int
{
    return number * factor;
}

operation OP(q : Qubit) : Unit
{
    Ry(PI() / 2.0, q);
}

// operation OP(q : Qubit) : Unit
// {
//     body(...)
//     {
//         Ry(PI() / 2.0, q);
//     }
// }



    operation CUSTOM(q: Qubit) : Unit is Adj + Ctl
    {
        body(...)
        {
            Ry(PI() / 2.0, q);
            Rz(PI(), q);
        }

        //adjoint self;

        adjoint (...)
        {
            Ry(PI() / 2.0, q);
        }
    }

}


