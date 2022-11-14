# firestore_quickstart

- [Cloud Firestore](https://firebase.flutter.dev/docs/firestore/usage/)

- [Cloud Firestore 시작하기](https://firebase.google.com/docs/firestore/quickstart#dart)


## STEP 0. Firebase 데이터베이스 만들기

- [moon-firebase-flutter-prj](https://console.firebase.google.com/u/0/project/moon-firebase-flutter-prj/firestore)
- 데이터베이스 만들기 > 테스트 모드


## STEP 1. Flutter 프로젝트 생성/설정

```
onCloud> flutter create --platform=web,ios,android firestore_quickstart
onCloud> cd firestore_quickstart

onCloud/firestore_quickstart> flutter pub add firebase_core cloud_firestore
```

## STEP 2. Firebase 설정

### PreRequirements(사전 환경 준비)
> Firebase CLI
> firebase 프로젝트 생성

```shell
onCloud/firestore_quickstart> flutterfire configure --project=moon-firebase-flutter-prj
```


## STEP 3. Coding
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
