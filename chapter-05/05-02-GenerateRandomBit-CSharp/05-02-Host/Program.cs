using System;
using System.Threading.Tasks;
using Microsoft.Quantum.Simulation.Simulators;

namespace _05_02_Host
{
    class Program
    {
        static async Task Main(string[] args)
        {
            using var simulator = new QuantumSimulator();
            var result = await _05_02_Quantum.GenerateRandomBit.Run(simulator);

            Console.WriteLine(result ? "0" : "1");
        }
    }
}