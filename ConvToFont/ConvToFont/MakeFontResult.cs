using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ConvToFont
{
	class MakeFontResult
	{
		public string fontName;
		public _FONT_CODE fontCode;

		public UInt16 bitWidth;
		public UInt16 bitHeight;

		public byte[] engFontData;

		public UInt16[] hanFontData_Fore;
		public UInt16[] hanFontData_Middle;
		public UInt16[] hanFontData_Under;

		public MakeFontResult()
		{
			fontCode = _FONT_CODE._ENG;

			bitWidth = 0;
			bitHeight = 0;

			engFontData = default(byte[]);

			hanFontData_Fore = default(UInt16[]);
			hanFontData_Middle = default(UInt16[]);
			hanFontData_Under = default(UInt16[]);
		}
	}
}
