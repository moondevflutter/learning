# firebase_auth_mapp

## References
- [(Youtube) Flutter Firebase Auth - The Cleanest & Fastest Way - IOS & Android](https://www.youtube.com/watch?v=rWamixHIKmQ&t=2s)

- [(Source) Flutter Firebase Auth - The Cleanest & Fastest Way](https://flutterworldwide.com/community_rWamixHIKmQ)


- [(Youtube) Flutter Firebase Google Sign in - Android](https://www.youtube.com/watch?v=B_hDZuq3rck)
- [(Source) Flutter Firebase Google Sign in - Android](https://github.com/mappInc/google_auth)


## STEP1: SETUP

### Flutter 프로젝트 생성

```shell
onCloud> flutter create --platform=web,ios,android firebase_auth_mapp
onCloud> cd firebase_auth_mapp
```

### Flutter 패키지(pub) 설치
> 방법1(명령행)

```shell
onCloud/firebase_auth_mapp> flutter pub add firebase_core firebase_auth
```

> 방법2(pubspec.yaml 편집/수정)

```yaml
dependencies:

  # 추가(최신 버전으로 할 경우는 ':' 뒤의 버전 삭제)
  firebase_core: ^1.20.0
  firebase_auth: ^3.5.0
```


## STEP2: FIREBASE SETUP

### PreRequirements(사전 환경 준비)
> Firebase CLI
> firebase 프로젝트 생성

```shell
onCloud/firebase_auth_mapp> flutterfire configure --project=moon-firebase-flutter-01
```

## STEP3: CODING

> [(Source) Flutter Firebase Auth - The Cleanest & Fastest Way](https://flutterworldwide.com/community_rWamixHIKmQ) 내용 복사



## STEP0: PreRequirements 참조

### Firebase CLI 설치
> https://firebase.google.com/docs/cli#setup_update_cli

### path 설정
- 시스템 환경변수 설정에서 path 추가: C:\Users\<User_NAME>\AppData\Local\Pub\Cache\bin
  - FlutterFire를 설치하기 위해서 dart pub global activate flutterfire_cli  실행하면 C:\Users\<User_NAME>\AppData\Local\Pub\Cache\bin 폴더내에 flutterfire.bat 파일이 생성됨

### Firebase 로그인
```shell
onCloud> firebase login --interactive // chrome에서 계정 선택 가능
onCloud> firebase login // 기존 계정으로 로그인
```

### 프로젝트 생성(Firebase CLI)
```shell
onCloud> firebase projects:create moon-firebase-flutter-01
```

### Flutter 프로젝트 생성 / package 설치
```shell
onCloud> flutter create --platform=web,ios,android firebase_auth_mapp
onCloud> cd firebase_auth_mapp
onCloud/firebase_auth_mapp> flutter pub add firebase_core
```

## Firebase 프로젝트 설정

### 앱에 Firebase 추가(0단계)
- [프로젝트 페이지](https://console.firebase.google.com/project/moon-firebase-flutter-01/overview)

- 앱에 Firebase를 추가하여 시작하기 'Flutter' 아이콘 클릭

### 작업공간 준비(1단계)

### FlutterFire CLI 설치 및 실행(2단계)

### Firebase 초기화 및 플러그인 추가(3단계)
```shell
# 처음 한번만 실행
onCloud/firebase_auth_mapp> dart pub global activate flutterfire_cli

onCloud/firebase_auth_mapp> flutterfire configure --project=moon-firebase-flutter-01
  - ERROR: 'flutterfire'은(는) 내부 또는 외부 명령, 실행할 수 있는 프로그램, 또는 배치 파일이 아닙니다.
  - SOL: 시스템 환경변수 설정에서 path 추가: C:\Users\ORM005\AppData\Local\Pub\Cache\bin
```

## Flutter에 적용
> main.dart

```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

```


## ERROR 01:  google login, debug.keystore 관련 버그

>> SOL: debug.keystore 동기화 -> ~/android/app/google-services.json 파일 변경

> 참조 https://jdj610.tistory.com/160

### fingerprint 확인

```shell
# 리스트 확인( "C:\Users\<USER_NAM>\.android\debug.keystore" )
# 생성(keytool -exportcert -v -alias androiddebugkey -keystore "C:\Users\user\.android\debug.keystore")
> keytool -list -v -alias androiddebugkey -keystore "C:\Users\user\.android\debug.keystore"

# 비밀번호 입력
키 저장소 비밀번호 입력: android
...
# 인증서 지문(fingerprint)
인증서 지문:
         SHA1: DF:F7:98:FA:26:42:FB:90:68:CC:F2:EB:47:A3:46:A9:DE:C4:30:BD
         SHA256: C3:8B:45:39:00:28:89:95:E7:D4:B2:0D:DC:9A:0E:E3:DD:A5:8C:43:47:5D:A9:71:58:12:5A:7B:22:3A:A3:E8
...
```

### ~/android/app/google-services.json 파일 변경

- [Firebase > 프로젝트 개요 > 프로젝트 설정 > 일반](https://console.firebase.google.com/u/0/project/moon-firebase-flutter-01/settings/general)
- 내 앱 > Android 앱 > '<해당 앱이름>' 클릭
- '지털 지문 추가' 클릭
- '인증서 지문'에 debug.keystore의 fingerprint 복사/붙여넣기
- 'google-services.json' 다운로드
- ~/android/app/ 폴더에 붙여넣기



## Authentication Sign-in method 추가
- [Authentication > Sign-in method](https://console.firebase.google.com/u/0/project/moon-firebase-flutter-01/authentication/providers)
- 로그인 제공업체 > '새 제공업체 추가' 클릭
- 추가 제공업체 > '<해당 업체>' 클릭
- '사용 설정' 클릭

프로젝트의 공개용 이름: project-769398584437
프로젝트 지원 이메일: moondevdart@gmail.com



## firebase_ui_auth

```
flutter pub add firebase_ui_auth

Because firebase_ui_localizations >=1.0.0-dev.1 depends on path ^1.8.2 and every version of flutter_localizations from sdk depends on path 1.8.1, firebase_ui_localizations >=1.0.0-dev.1 is incompatible with flutter_localizations from sdk.
And because firebase_ui_auth >=1.0.1 depends on firebase_ui_localizations ^1.0.1, flutter_localizations from sdk is incompatible with firebase_ui_auth >=1.0.1.
And because every version of firebase_ui_auth depends on flutter_localizations from sdk and firebase_ui_auth <1.0.1 depends on firebase_core ^1.10.2, every version of firebase_ui_auth requires firebase_core ^1.10.2.
So, because firebase_auth_mapp depends on both firebase_core ^2.1.1 and firebase_ui_auth any, version solving failed.
pub finished with exit code 65
```
