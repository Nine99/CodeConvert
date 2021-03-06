﻿using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Drawing;

namespace ConvToFont
{
	partial class ConvertFont_Main
	{
		//static MakeFontResult MakeEngBitmapFont(string _input_file_name)
		//{
		//	Bitmap bitmap;
		//	MakeFontResult result = new MakeFontResult();

		//	try
		//	{
		//		bitmap = (Bitmap)Image.FromFile(_input_file_name);
		//	}
		//	catch (FileNotFoundException e)
		//	{
		//		Console.ForegroundColor = ConsoleColor.Red;
		//		Console.WriteLine("File Not Found.");

		//		return default( MakeFontResult );
		//	}

		//	result.bitWidth = (UInt16)(bitmap.Width / _WIDTH_CHAR_NUM);
		//	result.bitHeight = (UInt16)(bitmap.Height / 6);

		//	GenerateEngBitmapFont(bitmap, result);//, result.bitWidth,  result.bitHeight);

		//	bitmap.Dispose();

		//	return result;
		//}

		//static byte[] GenerateEngBitmapFont(Bitmap _bitmap, int _bit_width, int _bit_height)
		static bool GenerateEngBitmapFont( Bitmap _bitmap, MakeFontResult _result )
		{
			Console.WriteLine("Image Loaded.");
			Console.WriteLine();
			Console.WriteLine("Image Size : {0} x {1}", _bitmap.Width, _bitmap.Height);
			Console.WriteLine("Font Size : {0} x {1}", _result.bitWidth, _result.bitHeight);
			Console.WriteLine();

			//byte[] bit_font = new byte[_result.bitHeight * (_result.bitWidth / 7 + 1) * _TOTAL_CHAR_NUM];
			_result.engFontData = new byte[_result.bitHeight * (_result.bitWidth / 7 + 1) * _ENG_TOTAL_CHAR_NUM];

			for (int wy = 0; wy < _bitmap.Height; ++wy)
			{
				for (int wx = 0; wx < _bitmap.Width; ++wx)
				{
					int char_code = (wx / _result.bitWidth) + (wy / _result.bitHeight) * _result.bitHeight;
					int bit_pos_x = wx % _result.bitWidth;
					int bit_pos_y = wy % _result.bitHeight;

					Color pixel_value = _bitmap.GetPixel(wx, wy);

					byte bit_value = (byte)(pixel_value.R > 0x80 ? 0x80 : 0x00);
					_result.engFontData[char_code * _result.bitHeight + bit_pos_y] |= (byte)(bit_value >> bit_pos_x);
				}
			}

			return true;
		}

		//static string WriteToFile(string _arg, byte[] _bm_arr, int _bit_width, int _bit_height)
		static string WriteEngBitmapFontToFile(string _arg, MakeFontResult _result)
		{
			string output_file_name = string.Format("{0}\\{1}_{2}x{3}.cpp", Path.GetDirectoryName(_arg), Path.GetFileNameWithoutExtension(_arg), _result.bitWidth, _result.bitHeight);
			string font_name = Path.GetFileNameWithoutExtension(_arg);
			string var_name = string.Format("{0}_{1}x{2}", font_name, _result.bitWidth, _result.bitHeight);

			StreamWriter file = new StreamWriter(output_file_name);

			file.WriteLine("// Font Name : {0}", font_name);
			file.WriteLine("// Generated by Nine99's ConvToFont.exe");
			file.WriteLine();

			file.WriteLine("#define _BIT_WIDTH_{0} {1}", font_name.ToUpper(), _result.bitWidth);
			file.WriteLine("#define _BIT_HEIGHT_{0} {1}", font_name.ToUpper(), _result.bitHeight);
			file.WriteLine();

			file.WriteLine("uint8_t {0}[] = {{", var_name);

			for (int font_byte = 0; font_byte < _ENG_TOTAL_CHAR_NUM; ++font_byte)
			{
				file.Write("\t");

				for (int height = 0; height < _result.bitHeight; ++height)
				{
					byte data = _result.engFontData[font_byte * _result.bitHeight + height];
					file.Write("0x{0:X2}", data);
					if (height >= _result.bitHeight - 1)
						file.Write("");
					else
						file.Write(", ");
				}

				if (font_byte >= _ENG_TOTAL_CHAR_NUM - 1)
				{
					file.WriteLine("\t// 'DEL'");
				}
				else
				{
					file.WriteLine(",\t// '{0}'", (char)(font_byte + 0x20));
				}
			}

			file.WriteLine("};");
			file.WriteLine();

			file.Close();

			return output_file_name;
		}
	}
}
