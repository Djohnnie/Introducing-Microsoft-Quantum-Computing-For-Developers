using System;
using System.Threading.Tasks;
using Microsoft.Quantum.Simulation.Simulators;

namespace _05_05_Host
{
    class Program
    {
        static async Task Main(string[] args)
        {
            Console.Write("Maximum: ");
            string input = Console.ReadLine();
            int maximum = Convert.ToInt32(input);

            using var simulator = new QuantumSimulator();
            var result = await _05_05_Quantum.GenerateRandomNumber.Run(simulator, maximum);

            Console.WriteLine(result);
        }
    }
}