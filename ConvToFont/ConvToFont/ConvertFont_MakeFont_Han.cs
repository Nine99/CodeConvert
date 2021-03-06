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
		static void Image2Bitmap_Han( Bitmap _bitmap, MakeFontResult _result, _HAN_COMP _component )
		{
			UInt16[] target;
			int set_len;
			int code_len;
			int py_offset;

			switch ( _component )
			{
				case _HAN_COMP._FORE:
					target = _result.hanFontData_Fore;
					set_len = _HAN_FORE_SET_NUM;
					code_len = _HAN_FORE_CHAR_NUM;
					py_offset = 0 * _result.bitHeight;
					break;

				case _HAN_COMP._MIDDLE:
					target = _result.hanFontData_Middle;
					set_len = _HAN_MIDDLE_SET_NUM;
					code_len = _HAN_MIDDLE_CHAR_NUM;
					py_offset = 8 * _result.bitHeight;
					break;

				//case _HAN_COMP._UNDER:
				default:
					target = _result.hanFontData_Under;
					set_len = _HAN_UNDER_SET_NUM;
					code_len = _HAN_UNDER_CHAR_NUM;
					py_offset = 12 * _result.bitHeight;
					break;
			}

			for (int set_inx = 0; set_inx < set_len; ++set_inx)
			{
				int set_offset = set_inx * code_len * _result.bitHeight;

				for (int code_inx = 0; code_inx < code_len; ++code_inx)
				{
					int code_offset = code_inx * _result.bitHeight;

					for (int wy = 0; wy < _result.bitHeight; ++wy)
					{
						int arr_index = set_offset + code_offset + wy;
						int py = set_inx * _result.bitHeight + wy + py_offset;

						target[arr_index] = 0x0000;

						for (int wx = 0; wx < _result.bitWidth; ++wx)
						{
							int px = code_inx * _result.bitWidth + wx;

							Color pixel_value = _bitmap.GetPixel(px, py);

							UInt16 bit_value = (UInt16)(pixel_value.R > 0x80 ? 0x8000 : 0x0000);
							target[arr_index] |= (UInt16)(bit_value >> wx);
						}
					}
				}
			}
		}

		static bool GenerateHanBitmapFont(Bitmap _bitmap, MakeFontResult _result )	// int _bit_width, int _bit_height)
		{
			Console.WriteLine("Image Loaded.");
			Console.WriteLine();
			Console.WriteLine("Image Size : {0} x {1}", _bitmap.Width, _bitmap.Height);
			Console.WriteLine("Font Size : {0} x {1}", _result.bitWidth, _result.bitHeight);
			Console.WriteLine();

			_result.hanFontData_Fore = new UInt16[_result.bitHeight * _HAN_FORE_CHAR_NUM * _HAN_FORE_SET_NUM];
			_result.hanFontData_Middle = new UInt16[_result.bitHeight * _HAN_MIDDLE_CHAR_NUM * _HAN_MIDDLE_SET_NUM];
			_result.hanFontData_Under = new UInt16[_result.bitHeight * _HAN_UNDER_CHAR_NUM * _HAN_UNDER_SET_NUM];

			Image2Bitmap_Han(_bitmap, _result, _HAN_COMP._FORE);			// 초성( 32 byte * 19 char * 8 set = 4864 byte )	0x1300
			Image2Bitmap_Han(_bitmap, _result, _HAN_COMP._MIDDLE);          // 중성( 32 byte * 21 char * 4 set = 2688 byte )	0x0A80
			Image2Bitmap_Han(_bitmap, _result, _HAN_COMP._UNDER);           // 종성( 32 byte * 28 char * 4 set = 3584 byte )	0x0E00

			return true;
		}

		static bool WriteHanComponentToCPP(StreamWriter _file, MakeFontResult _result, _HAN_COMP _component)
		{
			UInt16[] font_arr = default(UInt16[]);
			int code_len = 0;
			int set_len = 0;

			switch (_component)
			{
				case _HAN_COMP._FORE:
					font_arr = _result.hanFontData_Fore;
					_file.WriteLine("uint16_t {0}_Fore[] = {{", _result.fontName);
					code_len = _HAN_FORE_CHAR_NUM;
					set_len = _HAN_FORE_SET_NUM;
					break;

				case _HAN_COMP._MIDDLE:
					font_arr = _result.hanFontData_Middle;
					_file.WriteLine("uint16_t {0}_Middle[] = {{", _result.fontName);
					code_len = _HAN_MIDDLE_CHAR_NUM;
					set_len = _HAN_MIDDLE_SET_NUM;
					break;

				case _HAN_COMP._UNDER:
					font_arr = _result.hanFontData_Under;
					_file.WriteLine("uint16_t {0}_Under[] = {{", _result.fontName);
					code_len = _HAN_UNDER_CHAR_NUM;
					set_len = _HAN_UNDER_SET_NUM;
					break;

				default:
					return false;
			}

			int last_index = (set_len - 1) * (code_len - 1) * (_result.bitHeight - 1);

			for (int set_inx = 0; set_inx < set_len; ++set_inx)
			{
				int set_offset = set_inx * code_len * _result.bitHeight;
				_file.WriteLine("\t// Set {0}", set_inx);

				for (int code_inx = 0; code_inx < code_len; ++code_inx)
				{
					int code_offset = code_inx * _result.bitHeight;
					_file.Write("\t");

					for (int line_inx = 0; line_inx < _result.bitHeight; ++line_inx)
					{
						//int arr_index = (set_inx * _result.bitHeight + code_inx) * _result.bitWidth + line_inx;
						int arr_index = set_offset + code_offset + line_inx;
						UInt16 data = font_arr[arr_index];
						_file.Write("0x{0:X4}", data);

						if (set_inx * code_inx * line_inx < last_index)
							_file.Write(", ");
					}

					_file.WriteLine();
				}
			}

			_file.WriteLine("};");
			_file.WriteLine();

			return true;
		}

		static bool WriteHanComponentToBin(FileStream _file, MakeFontResult _result, _HAN_COMP _component )
		{
			switch (_component)
			{
				case _HAN_COMP._FORE:
					for( int wi=0; wi<_result.hanFontData_Fore.Length; ++wi )
					{
						_file.Write(BitConverter.GetBytes(_result.hanFontData_Fore[wi]), 0, 2);
					}
					break;

				case _HAN_COMP._MIDDLE:
					for( int wi=0; wi<_result.hanFontData_Middle.Length; ++wi )
					{
						_file.Write(BitConverter.GetBytes(_result.hanFontData_Middle[wi]), 0, 2);
					}
					break;

				case _HAN_COMP._UNDER:
					for( int wi=0; wi<_result.hanFontData_Under.Length; ++wi)
					{
						_file.Write(BitConverter.GetBytes(_result.hanFontData_Under[wi]), 0, 2);
					}
					break;

				default:
					return false;
			}

			return true;
		}

		static string WriteHanBitmapFontToFile(string _arg, MakeFontResult _result)
		{
			string output_file_name = string.Format("{0}\\{1}_{2}x{3}.bin", Path.GetDirectoryName(_arg), Path.GetFileNameWithoutExtension(_arg), _result.bitWidth, _result.bitHeight);
			string font_name = Path.GetFileNameWithoutExtension(_arg);
			font_name = font_name.Replace("-", "_");
			_result.fontName = string.Format("{0}_{1}x{2}", font_name, _result.bitWidth, _result.bitHeight);

			FileStream file = new FileStream(output_file_name, FileMode.Create, FileAccess.Write);

			for (int wi = 0; wi < _result.hanFontData_Fore.Length; ++wi)
				file.Write(BitConverter.GetBytes(_result.hanFontData_Fore[wi]), 0, 2);
			for (int wi = 0; wi < _result.hanFontData_Middle.Length; ++wi)
				file.Write(BitConverter.GetBytes(_result.hanFontData_Middle[wi]), 0, 2);
			for (int wi = 0; wi < _result.hanFontData_Under.Length; ++wi)
				file.Write(BitConverter.GetBytes(_result.hanFontData_Under[wi]), 0, 2);

			file.Close();

			return output_file_name;
		}

		static string WriteHanBitmapHeaderFile( string _input_file_name, MakeFontResult _result )
		{
			string output_file_name = string.Format("{0}\\{1}_{2}x{3}.h", Path.GetDirectoryName(_input_file_name), Path.GetFileNameWithoutExtension(_input_file_name), _result.bitWidth, _result.bitHeight);
			string font_name = Path.GetFileNameWithoutExtension(_input_file_name);
			font_name = font_name.Replace("-", "_");

			StreamWriter file = new StreamWriter(output_file_name);

			string[] file_contents =
			{
				"#pragma once",
				"",
				"#define _FONT_BASE_ADDR		0x0800b800	// for STM32F103C8T6",
				"",
				"#define _FONT_LEN_FORE		" + string.Format( "0x{0:x04}", _result.hanFontData_Fore.Length * 2 ),
				"#define _FONT_LEN_MIDDLE	" + string.Format( "0x{0:x04}", _result.hanFontData_Middle.Length * 2 ),
				"#define _FONT_LEN_UNDER		" + string.Format( "0x{0:x04}", _result.hanFontData_Under.Length * 2 ),
				"",
				"#define _FONT_ADDR_FORE		_FONT_BASE_ADDR",
				"#define _FONT_ADDR_MIDDLE	(_FONT_ADDR_FORE + _FONT_LEN_FORE)",
				"#define _FONT_ADDR_UNDER	(_FONT_ADDR_MIDDLE + _FONT_LEN_MIDDLE)",
				""
			};

			foreach (string str in file_contents)
			{
				file.WriteLine(str);
			}

			file.Close();

			return output_file_name;
		}


	}
}

