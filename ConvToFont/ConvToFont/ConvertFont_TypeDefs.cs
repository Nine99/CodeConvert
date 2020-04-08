using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ConvToFont
{
	enum _FONT_CODE
	{
		_ENG = 'e',
		_HAN = 'h'
	};

	enum _HAN_COMP
	{
		_FORE,
		_MIDDLE,
		_UNDER,

		_MAX
	}

	partial class ConvertFont_Main
	{
		static readonly UInt16 _ENG_WIDTH_CHAR_NUM = 16;
		static readonly UInt16 _ENG_HEIGHT_CHAR_NUM = 6;
		static readonly UInt16 _ENG_TOTAL_CHAR_NUM = (UInt16)(_ENG_WIDTH_CHAR_NUM * _ENG_HEIGHT_CHAR_NUM);

		static readonly UInt16 _HAN_FORE_CHAR_NUM = 19;
		static readonly UInt16 _HAN_FORE_SET_NUM = 8;

		static readonly UInt16 _HAN_MIDDLE_CHAR_NUM = 21;
		static readonly UInt16 _HAN_MIDDLE_SET_NUM = 4;

		static readonly UInt16 _HAN_UNDER_CHAR_NUM = 28;
		static readonly UInt16 _HAN_UNDER_SET_NUM = 4;
	}
}
