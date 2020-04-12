using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ConvToFont
{
	partial class ConvertFont_Main
	{
		static void PrintUsage()
		{
			Console.ForegroundColor = ConsoleColor.Gray;
			Console.Write("USAGE : ConvToFont.exe ");
			Console.ForegroundColor = ConsoleColor.Yellow;
			Console.WriteLine("[{-e | -h | -c} input_file_name]");
			Console.ResetColor();

			Console.WriteLine("\t-q : Exit.");
			Console.WriteLine("\t-e : Covert Image File(.bmp) to English Font .CPP File.");
			Console.WriteLine("\t-h : Covert Image File(.bmp) to Hangul Font .CPP File.");
			//Console.WriteLine();
			Console.WriteLine("\t-a : Convert Text File, 1361 to UTF-8.");
			Console.WriteLine("\t-c : Convert Text File, UTF-8 to 1361.");
			Console.WriteLine();
			Console.WriteLine("Type 'exit' to Exit.");
		}

		static void PrintAppInfo()
		{
			Console.ForegroundColor = ConsoleColor.White;
			Console.WriteLine("Bitmap Font Generator. Ver 1.0");
			Console.WriteLine("by Nine99( nine99@live.co.kr )");
			Console.WriteLine();
			Console.ResetColor();
		}

	}
}
