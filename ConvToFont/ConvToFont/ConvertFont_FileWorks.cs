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
		static void Proc_MakeFont( string[] args )
		{
			string file_name = Path.GetFileNameWithoutExtension(args[1]);
			string output_file_name;

			switch (args[0][1])
			{
				case 'e':
				case 'E':
					{
						MakeFontResult result = MakeBitmapFont(args[1], _FONT_CODE._ENG);

						output_file_name = WriteEngBitmapFontToFile(args[1], result);
					}
					break;

				case 'h':
				case 'H':
					{
						MakeFontResult result = MakeBitmapFont(args[1], _FONT_CODE._HAN);

						output_file_name = WriteHanBitmapFontToFile(args[1], result);
					}
					break;

				case 'a':
				case 'A':
					{
						if (file_name.EndsWith("_1361"))
							file_name = file_name.Remove(file_name.Length - 5);

						output_file_name = string.Format("{0}\\{1}_UTF8.txt", Path.GetDirectoryName(args[1]), Path.GetFileNameWithoutExtension(args[1]));
						StreamReader in_file = new StreamReader(args[1], System.Text.Encoding.GetEncoding(1361));

						string text_line = in_file.ReadToEnd();

						in_file.Close();

						Console.Write(text_line);

						StreamWriter out_file = new StreamWriter(output_file_name);

						out_file.Write(text_line);

						out_file.Close();
					}
					break;

				case 'c':
				case 'C':
					{
						if (file_name.EndsWith("_UTF8"))
							file_name = file_name.Remove(file_name.Length - 5);

						output_file_name = string.Format("{0}\\{1}_1361.txt", Path.GetDirectoryName(args[1]), file_name);
						StreamReader in_file = new StreamReader(args[1]);

						string text_line = in_file.ReadToEnd();

						in_file.Close();

						Console.Write(text_line);

						System.Text.Encoding encorder = System.Text.Encoding.GetEncoding(1361);

						FileStream out_file = new FileStream(output_file_name, FileMode.Create, FileAccess.Write);
						//StreamWriter out_file = new StreamWriter(output_file_name);

						byte[] encoded_text = encorder.GetBytes(text_line);
						out_file.Write( encoded_text, 0, encoded_text.Length );

						out_file.Close();
					}
					break;

				default:
					PrintUsage();
					return;
			}

			Console.ForegroundColor = ConsoleColor.Green;
			Console.WriteLine("Create {0}, Complete.", output_file_name);
			Console.WriteLine();
			Console.ResetColor();

		}

		static MakeFontResult MakeBitmapFont(string _input_file_name, _FONT_CODE _font_code)
		{
			Bitmap bitmap;
			MakeFontResult result = new MakeFontResult();
			result.fontCode = _font_code;

			try
			{
				bitmap = (Bitmap)Image.FromFile(_input_file_name);
			}
			catch (FileNotFoundException e)
			{
				Console.ForegroundColor = ConsoleColor.Red;
				Console.WriteLine("File Not Found.");

				return default(MakeFontResult);
			}

			switch (result.fontCode)
			{
				case _FONT_CODE._ENG:
					result.bitWidth = (UInt16)(bitmap.Width / _ENG_WIDTH_CHAR_NUM);
					result.bitHeight = (UInt16)(bitmap.Height / 6);

					GenerateEngBitmapFont(bitmap, result);
					break;

				case _FONT_CODE._HAN:
					result.bitWidth = 16;
					result.bitHeight = 16;

					GenerateHanBitmapFont(bitmap, result);
					break;
			}

			bitmap.Dispose();

			return result;
		}
	}
}
