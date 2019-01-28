using System;
using System.Reflection;

namespace AutoVersionPreBuild
{
    class Program
    {
        static void Main(string[] args)
        {
			Console.WriteLine(Assembly.GetEntryAssembly().GetName().Version.ToString());
            Console.ReadKey();
        }
    }
}
