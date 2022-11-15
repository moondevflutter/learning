- [Flutter로 Web 만들기 (덤으로 안드로이드, iOS 앱이 만들어질 뿐)](https://dalgonakit.tistory.com/156)

1. 기본 프로젝트 만들기
```
inDart> flutter create flutter_web

```

2. 프로젝트 실행
```
inDart> cd flutter_web
inDart\flutter_web> flutter run -d chrome
```

3. 빌드
```
inDart\flutter_web> flutter build web
```

4. localhost
```
inDart\flutter_web> cd build/web
inDart\flutter_web\build\web> python -m http.server 8000
```

### 웹 렌더러 옵션
Flutter는 웹 페이지를 그리는데 사용하는 방식을 설정할 수 있습니다.

1. HTML
흔히 웹 개발에서 다루는 HTML, CSS, Canvas, SVG를 이용하여 화면을 구성합니다.
그래서 용량은 적지만 화면 출력 속도는 느리다고 합니다.

2. Canvaskit (추천)
Skia 그래픽 엔진과 WebAssembly의 합작으로 만든 화면을 그리는 객체로
용량은 2MB정도 늘지만, 화면 출력 속도는 빠르다고 합니다.
최근에는 모든 웹브라우저에서 Skia 그래픽 엔진을 지원하니 Canvaskit로 선택하시는걸 추천드립니다.

3. Auto
기본 값은 Auto 입니다.
모바일 폰에서 실행된 브라우저에서는 HTML로 실행되고,
데스크탑에서 실행된 브라우저에서는 Canvaskit로 실행됩니다.

*기본 생성된 프로젝트를 가지고 시간을 측정해보니, 파일 로드시에만 시간이 canvaskit으로 빌드한 웹이 0.4초 정도 더 걸리는 것 뿐이였습니다.

```shell
# 플러터 실행 명령어 + 렌더러 옵션
inDart\flutter_web> flutter run -d chrome --web-renderer html
inDart\flutter_web> flutter run -d chrome --web-renderer canvaskit

# 빌드 명령어 + 렌더러 옵션
inDart\flutter_web> flutter build web --web-renderer html
inDart\flutter_web> flutter build web --web-renderer canvaskit
```