using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Drawing;

namespace ConvToFont
{
	partial class ConvertFont_Main
	{
		[STAThreadAttribute]
		static void Main(string[] args)
		{
			PrintAppInfo();

			if (args.Length < 2 || args[0][0] != '-' || args[0].Length < 2)
			{
				PrintUsage();

				while (true)
				{
					string ret_value = Proc_CodeConvert();
					if (ret_value == "exit") break;

					if ( ret_value.Length > 0)
						System.Windows.Forms.Clipboard.SetText(ret_value);
				}

				Console.WriteLine("Good bye.");
				Console.WriteLine();

				return;
			}

			Proc_MakeFont(args);
		}
	}
}
