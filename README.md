# Hangul Code Converter
## ConvToFont.exe

> ##### 한국어가 전세계 공용어가 되는 그날까지... 
>
> ##### 한글이 세계 공용문자가 되는 그날까지... 
>
> ##### 조합형이 한국 OS의 문자표준으로 잡히는 그날까지...



- 128x96 크기의 이미지 파일에서 영문(0x20 ~ 0x7F) Bitmap Font를 추출할 수 있습니다.
  - .cpp 소스파일 출력
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



2020.04.13

- 조합형 한글 자료를 찾는 이들에게 조금이나마 도움이 될까 하여 공개로 전환합니다.
- 깃허브가 아직 미숙하여 부족한 면이 보입니다만, 도움이 되었으면 좋겠네요.( 조만간 LCD 라이브러리도 공개할 얘정입니다. )

![실행화면](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fk.kakaocdn.net%2Fdn%2Fc1ccdP%2FbtqDuq0Nn7X%2FN7aifwgtznFh64OcOS9Ac1%2Fimg.png){: width=462}

