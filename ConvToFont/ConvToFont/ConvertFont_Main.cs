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
		
		static void Main(string[] args)
		{
			PrintAppInfo();

			if (args.Length < 2 || args[0][0] != '-' || args[0].Length < 2)
			{
				PrintUsage();

				Proc_CodeConvert();

				return;
			}

			Proc_MakeFont(args);

		}
	}
}
