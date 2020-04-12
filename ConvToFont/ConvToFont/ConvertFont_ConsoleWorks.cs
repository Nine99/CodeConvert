using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ConvToFont
{
	partial class ConvertFont_Main
	{
		static string Proc_CodeConvert()
		{
			System.Text.Encoding encorder = System.Text.Encoding.GetEncoding(1361);

			while (true)
			{
				Console.Write("> ");			// Prompt 출력

				string input_str = Console.ReadLine();

				// 입력값이 '-' 로 시작 되면 파일 변환 수행( Command Line Execute )
				if (input_str[0] == '-')
				{
					if (input_str[1] == 'q' || input_str[2] == 'Q')
						return "exit";

					string[] args =
					{
						input_str.Substring(0, 2 ),
						input_str.Substring(2).TrimStart( ' ' )
					};

					Proc_MakeFont(args);

					return "";
				}

				byte[] comb_han = encorder.GetBytes( input_str );

				string code_buff = "";

				for( int wi=0; wi< comb_han.Length; ++wi )
					code_buff += string.Format("0x{0:X02}, ", comb_han[wi]);

				code_buff += "0x00";	// NULL 로 끝나도록...

				Console.ForegroundColor = ConsoleColor.Yellow;
				Console.WriteLine(code_buff);
				Console.ResetColor();

				return code_buff;
				
			}
		}
	}
}
