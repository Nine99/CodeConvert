using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ConvToFont
{
	partial class ConvertFont_Main
	{
		static void Proc_CodeConvert()
		{
			System.Text.Encoding encorder = System.Text.Encoding.GetEncoding(1361);

			while (true)
			{
				Console.Write("> ");

				string input_str = Console.ReadLine();

				if (input_str.ToUpper() == "EXIT" )
				{
					break;
				}

				byte[] comb_han = encorder.GetBytes( input_str );

				Console.ForegroundColor = ConsoleColor.Yellow;

				for( int wi=0; wi< comb_han.Length; ++wi )
				{
					Console.Write("0x{0:X02}", comb_han[wi]);

					if (wi < comb_han.Length - 1)
						Console.Write(", ");
				}
				Console.WriteLine();
				Console.ResetColor();
			}
		}
	}
}
