# github_client

A new Flutter project.

# 5. GitHub 액세스
## GitHub에 연결
OAuth 인증 흐름을 사용하여 GitHub의 데이터에 액세스하는 데 필요한 토큰을 얻었습니다. 이 작업을 원활하게 하기 위해 pub.dev에서 사용할 수 있는 github 패키지를 사용합니다.

더 많은 종속 항목 추가
다음 명령어를 실행합니다.

```bash
$ flutter pub add github
```

## GitHub 패키지에서 OAuth 사용자 인증 정보 사용
이전 단계에서 만든 GithubLoginWidget은 GitHub API와 상호작용할 수 있는 HttpClient를 제공합니다. 이 단계에서는 HttpClient에 포함된 사용자 인증 정보를 사용하여 GitHub 패키지로 GitHub API에 액세스합니다(아래 참조).

```dart
final accessToken = httpClient.credentials.accessToken;
final gitHub = GitHub(auth: Authentication.withToken(accessToken));
```

## 다시 코드 통합
이제 GitHub 클라이언트를 lib/main.dart 파일에 통합할 차례입니다.

> lib/main.dart

```dart
import 'package:flutter/material.dart';
import 'package:github/github.dart';

import 'github_oauth_credentials.dart';
import 'src/github_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Client',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'GitHub Client'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return GithubLoginWidget(
      builder: (context, httpClient) {
        return FutureBuilder<CurrentUser>(
          future: viewerDetail(httpClient.credentials.accessToken),
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                title: Text(title),
              ),
              body: Center(
                child: Text(
                  snapshot.hasData
                      ? 'Hello ${snapshot.data!.login}!'
                      : 'Retrieving viewer login details...',
                ),
              ),
            );
          },
        );
      },
      githubClientId: githubClientId,
      githubClientSecret: githubClientSecret,
      githubScopes: githubScopes,
    );
  }
}

Future<CurrentUser> viewerDetail(String accessToken) async {
  final gitHub = GitHub(auth: Authentication.withToken(accessToken));
  return gitHub.users.getCurrentUser();
}
```

이 Flutter 애플리케이션을 실행하면 GitHub OAuth 로그인 흐름을 시작하는 버튼이 표시됩니다. 버튼을 클릭한 다음 웹브라우저에서 로그인 흐름을 완료합니다. 이제 앱에 로그인되었습니다.

다음 단계에서는 현재 코드베이스의 문제를 해결할 수 있습니다. 웹브라우저에서 애플리케이션을 인증한 후 애플리케이션을 다시 포그라운드로 가져옵니다.

## 6. Windows, macOS 및 Linux용 Flutter 플러그인 만들기
### 문제 해결하기
현재 코드에는 불편한 부분이 있습니다. 인증 흐름 후 GitHub가 애플리케이션을 인증할 때 웹브라우저 페이지가 표시됩니다. 애플리케이션으로 자동 복귀하는 것이 최선입니다. 이를 해결하려면 데스크톱 플랫폼용 Flutter 플러그인을 생성해야 합니다.

### Windows, macOS 및 Linux용 Flutter 플러그인 만들기
OAuth 흐름이 완료된 후 애플리케이션이 애플리케이션 창 스택의 맨 앞에 자동으로 표시되도록 하려면 몇 가지 네이티브 코드가 필요합니다. macOS의 경우 필요한 API는 NSApplication의 activate(ignoringOtherApps:) 인스턴스 메서드이며, Linux에는 gtk_window_present를 사용하고, Windows에서는 Stack Overflow를 이용합니다. 이러한 API를 호출하려면 Flutter 플러그인을 만들어야 합니다.

flutter를 사용하여 새 플러그인 프로젝트를 만들 수 있습니다.

```bash
$ cd .. # step outside of the github_client project
$ flutter create -t plugin --platforms=linux,macos,windows window_to_front
```

생성된 pubspec.yaml이 다음과 같이 표시되는지 확인합니다.

> ../window_to_front/pubspec.yaml

```yaml
name: window_to_front
description: A new flutter plugin project.
version: 0.0.1

environment:
  sdk: ">=2.12.0 <3.0.0"
  flutter: ">=1.20.0"

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^1.0.0

flutter:
  plugin:
    platforms:
      linux:
        pluginClass: WindowToFrontPlugin
      macos:
        pluginClass: WindowToFrontPlugin
      windows:
        pluginClass: WindowToFrontPlugin
```

이 플러그인은 macOS, Linux, Windows용으로 구성되어 있습니다. 이제 창이 앞에 나타나게 하는 Swift 코드를 추가할 수 있습니다. 다음과 같이 macos/Classes/WindowToFrontPlugin.swift를 수정합니다.

> ../window_to_front/macos/Classes/WindowToFrontPlugin.swift

```swift
import Cocoa
import FlutterMacOS

public class WindowToFrontPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "window_to_front", binaryMessenger: registrar.messenger)
    let instance = WindowToFrontPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    // Add from here
    case "activate":
      NSApplication.shared.activate(ignoringOtherApps: true)
      result(nil)
    // to here.
    // Delete the getPlatformVersion case,
    // as we won't be using it.
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
```

Linux 플러그인에서 동일한 작업을 하려면 linux/window_to_front_plugin.cc 콘텐츠를 다음으로 바꿉니다.

> ../window_to_front/linux/window_to_front_plugin.cc

```cpp
#include "include/window_to_front/window_to_front_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>

#define WINDOW_TO_FRONT_PLUGIN(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), window_to_front_plugin_get_type(), \
                              WindowToFrontPlugin))

struct _WindowToFrontPlugin {
  GObject parent_instance;

  FlPluginRegistrar* registrar;
};

G_DEFINE_TYPE(WindowToFrontPlugin, window_to_front_plugin, g_object_get_type())

// Called when a method call is received from Flutter.
static void window_to_front_plugin_handle_method_call(
    WindowToFrontPlugin* self,
    FlMethodCall* method_call) {
  g_autoptr(FlMethodResponse) response = nullptr;

  const gchar* method = fl_method_call_get_name(method_call);

  if (strcmp(method, "activate") == 0) {
    FlView* view = fl_plugin_registrar_get_view(self->registrar);
    if (view != nullptr) {
      GtkWindow* window = GTK_WINDOW(gtk_widget_get_toplevel(GTK_WIDGET(view)));
      gtk_window_present(window);
    }

    response = FL_METHOD_RESPONSE(fl_method_success_response_new(nullptr));
  } else {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }

  fl_method_call_respond(method_call, response, nullptr);
}

static void window_to_front_plugin_dispose(GObject* object) {
  G_OBJECT_CLASS(window_to_front_plugin_parent_class)->dispose(object);
}

static void window_to_front_plugin_class_init(WindowToFrontPluginClass* klass) {
  G_OBJECT_CLASS(klass)->dispose = window_to_front_plugin_dispose;
}

static void window_to_front_plugin_init(WindowToFrontPlugin* self) {}

static void method_call_cb(FlMethodChannel* channel, FlMethodCall* method_call,
                           gpointer user_data) {
  WindowToFrontPlugin* plugin = WINDOW_TO_FRONT_PLUGIN(user_data);
  window_to_front_plugin_handle_method_call(plugin, method_call);
}

void window_to_front_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
  WindowToFrontPlugin* plugin = WINDOW_TO_FRONT_PLUGIN(
      g_object_new(window_to_front_plugin_get_type(), nullptr));

  plugin->registrar = FL_PLUGIN_REGISTRAR(g_object_ref(registrar));

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  g_autoptr(FlMethodChannel) channel =
      fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
                            "window_to_front",
                            FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(channel, method_call_cb,
                                            g_object_ref(plugin),
                                            g_object_unref);

  g_object_unref(plugin);
}
```

Windows 플러그인에서 동일한 작업을 하려면 windows/window_to_front_plugin.cc 콘텐츠를 다음과 같이 바꿉니다.

> ..\window_to_front\windows\window_to_front_plugin.cpp

```cpp
#include "include/window_to_front/window_to_front_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <map>
#include <memory>

namespace {

class WindowToFrontPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  WindowToFrontPlugin(flutter::PluginRegistrarWindows *registrar);

  virtual ~WindowToFrontPlugin();

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<>> result);

  // The registrar for this plugin, for accessing the window.
  flutter::PluginRegistrarWindows *registrar_;
};

// static
void WindowToFrontPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<>>(
          registrar->messenger(), "window_to_front",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<WindowToFrontPlugin>(registrar);

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

WindowToFrontPlugin::WindowToFrontPlugin(flutter::PluginRegistrarWindows *registrar)
  : registrar_(registrar) {}

WindowToFrontPlugin::~WindowToFrontPlugin() {}

void WindowToFrontPlugin::HandleMethodCall(
    const flutter::MethodCall<> &method_call,
    std::unique_ptr<flutter::MethodResult<>> result) {
  if (method_call.method_name().compare("activate") == 0) {
    // See https://stackoverflow.com/a/34414846/2142626 for an explanation of how
    // this raises a window to the foreground.
    HWND m_hWnd = registrar_->GetView()->GetNativeWindow();
    HWND hCurWnd = ::GetForegroundWindow();
    DWORD dwMyID = ::GetCurrentThreadId();
    DWORD dwCurID = ::GetWindowThreadProcessId(hCurWnd, NULL);
    ::AttachThreadInput(dwCurID, dwMyID, TRUE);
    ::SetWindowPos(m_hWnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOSIZE | SWP_NOMOVE);
    ::SetWindowPos(m_hWnd, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_SHOWWINDOW | SWP_NOSIZE | SWP_NOMOVE);
    ::SetForegroundWindow(m_hWnd);
    ::SetFocus(m_hWnd);
    ::SetActiveWindow(m_hWnd);
    ::AttachThreadInput(dwCurID, dwMyID, FALSE);
    result->Success();
  } else {
    result->NotImplemented();
  }
}

}  // namespace

void WindowToFrontPluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  WindowToFrontPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
```

코드를 추가하여 위에서 만든 네이티브 기능을 Flutter에서 사용할 수 있게 합니다.

> ../window_to_front/lib/window_to_front.dart

```dart
import 'dart:async';

import 'package:flutter/services.dart';

class WindowToFront {
  static const MethodChannel _channel = MethodChannel('window_to_front');
  // Add from here
  static Future<void> activate(){
    return _channel.invokeMethod('activate');
  }
  // to here.

  // Delete the getPlatformVersion getter method.
}
```

이 Flutter 플러그인은 완료되면 다시 github_graphql_client 프로젝트 편집으로 돌아갈 수 있습니다.

```bash
$ cd ../github_client
```

### 종속 항목 추가
방금 만든 Flutter 플러그인은 훌륭하지만 그 자체만으로는 그리 유용하지 않습니다. 이를 제대로 사용하려면 Flutter 애플리케이션에 종속 항목으로 추가해야 합니다.

```bash
$ flutter pub add --path ../window_to_front window_to_front
Resolving dependencies...
  js 0.6.3 (0.6.4 available)
  path 1.8.0 (1.8.1 available)
  source_span 1.8.1 (1.8.2 available)
  test_api 0.4.8 (0.4.9 available)
+ window_to_front 0.0.1 from path ..\window_to_front
Changed 1 dependency!
```

window_to_front 종속 항목에 지정된 경로를 확인합니다. pub.dev에 게시된 패키지가 아닌 로컬 패키지이므로 버전 번호 대신 경로를 지정합니다.

### 다시 또 한 번 코드 통합
이제 window_to_front를 lib/main.dart 파일에 통합할 차례입니다. 적절한 시점에 가져오기를 추가하고 네이티브 코드를 호출하기만 하면 됩니다.

> lib/main.dart

```dart
import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:window_to_front/window_to_front.dart';    // Add this

import 'github_oauth_credentials.dart';
import 'src/github_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Client',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'GitHub Client'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return GithubLoginWidget(
      builder: (context, httpClient) {
        WindowToFront.activate();                        // and this.
        return FutureBuilder<CurrentUser>(
          future: viewerDetail(httpClient.credentials.accessToken),
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                title: Text(title),
              ),
              body: Center(
                child: Text(
                  snapshot.hasData
                      ? 'Hello ${snapshot.data!.login}!'
                      : 'Retrieving viewer login details...',
                ),
              ),
            );
          },
        );
      },
      githubClientId: githubClientId,
      githubClientSecret: githubClientSecret,
      githubScopes: githubScopes,
    );
  }
}

Future<CurrentUser> viewerDetail(String accessToken) async {
  final gitHub = GitHub(auth: Authentication.withToken(accessToken));
  return gitHub.users.getCurrentUser();
}
```

이 Flutter 애플리케이션을 실행하면 동일한 모습의 앱이 표시되지만 버튼을 클릭하면 동작 측면에서 차이를 보입니다. 인증에 사용하는 웹브라우저 위에 앱을 배치하면 로그인 버튼을 클릭할 때 웹브라우저 뒤에 애플리케이션이 푸시됩니다. 반면 브라우저에서 인증 흐름을 완료하면 애플리케이션이 다시 앞에 표시되어 훨씬 더 세련된 느낌을 줍니다.


다음 섹션에서는 보유하고 있는 코드베이스를 토대로 빌드하여 GitHub에서 이용할 수 있는 기능을 알려 주는 데스크톱 GitHub 클라이언트를 만듭니다. 계정 내 저장소 목록, Flutter 프로젝트의 pull 요청, 할당된 문제를 살펴볼 수 있습니다.
