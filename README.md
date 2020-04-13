# CodeConvert
About Code 1361.

- 128x96 크기의 이미지 파일에서 영문(0x20 ~ 0x7F) Bitmap Font를 추출할 수 있습니다.( .cpp 소스파일 출력 )
- 512x256 크기의 이미지 파일에서 한글 Bitmap Font를 추출할 수 있습니다.
  - .h, .cpp 소스파일 출력
  - .bin 바이너리 파일 출력
- 완성형 Text 파일을 1361 조합형 Text 파일로 변환할 수 있습니다.
- 1361 조합형 Text 파일을 완성형 Text 파일로 변환 할 수 있습니다.
- 콘솔 입력으로 완성형문자열을 조합형 코드로 생성하고 Clipboard 에 복사합니다.

```
USAGE : ConvToFont.exe [-e input_file_name | -h input_file_name |-c input_file_name | -a input_file_name]
-e : Covert Image File(.bmp) to English Font .CPP File.
-h : Covert Image File(.bmp) to Hangul Font .CPP File.
-a : Convert Text File, 1361 to UTF-8.
-c : Convert Text File, UTF-8 to 1361.
-q : Exit.
```

