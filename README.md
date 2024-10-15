# 플러터 JWT 로그인
서버는 이 리파지토리를 사용하고 있습니다.
[클릭](https://github.com/hyeji111544/spring-blog-rest-api)
<br>
자세한 설명은 [이쪽](https://inblog.ai/hj/jwt-로그인-하기2-31570)
# 앱 기능 설명
JWT 저장을 위한 의존성 추가
```dart
dependencies:
  flutter_secure_storage: ^8.0.0
```

## 1. 스플래시 페이지 (SplashPage)

스플래시 페이지는 앱이 시작할 때 로고나 로딩 화면을 표시합니다. 이 예제에서는 세션을 확인하여 `LoginPage` 또는 `MainPage`로 이동시킵니다.

```dart
class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(sessionProvider).autoLogin();

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/splash.gif',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
```
SessionGM 클래스-SessionGM은 세션 정보를 관리하며, 앱이 시작될 때 자동 로그인을 시도합니다.
```dart
class SessionGM {
  int? id;
  String? username;
  String? accessToken;
  bool? isLogin = false;

  final mContext = navigatorKey.currentContext!;

  Future<void> autoLogin() async {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.popAndPushNamed(mContext, "/post/list");
    });
  }
}

final sessionProvider = StateProvider<SessionGM>((ref) => SessionGM());

```

## 2. 통신
서버에 토큰 유효성을 확인하고, 헤더에 Authorization을 추가해 응답을 받습니다.<br>
response 의 헤더가 200이 아닌 경우 에러가 발생하기 때문에 Dio 에서 에러 발생 방지를 합니다.

```dart
class UserRepository {
  Future<Map<String, dynamic>> autoLogin(String accessToken) async {
    final response = await dio.post(
      "/auto/login",
      options: Options(headers: {"Authorization": "Bearer $accessToken"}),
    );
    return response.data;
  }
}

final dio = Dio(BaseOptions(
  baseUrl: baseUrl,
  contentType: "application/json; charset=utf-8",
  validateStatus: (status) => true, // 200이 아니어도 에러 발생 방지
));

```

## 3. 로그인 코드
로그인 성공 시 SessionGM 값을 갱신하고, accessToken을 저장한 뒤 페이지를 이동합니다.
```dart
Future<void> login(String username, String password) async {
  var (body, accessToken) = await UserRepository().login(username, password);
  if (body["success"]) {
    this.id = body["response"]["id"];
    this.username = body["response"]["username"];
    this.accessToken = accessToken;
    this.isLogin = true;
    await secureStorage.write(key: "accessToken", value: accessToken);
    dio.options.headers["Authorization"] = accessToken;
    Navigator.pushNamed(mContext, "/post/list");
  } else {
    ScaffoldMessenger.of(mContext).showSnackBar(
      SnackBar(content: Text("${body["errorMessage"]}")),
    );
  }
}

```

## 4. 자동 로그인
앱 시작 시 토큰을 확인해 자동 로그인을 처리합니다.
```dart
Future<void> autoLogin() async {
  String? accessToken = await secureStorage.read(key: "accessToken");
  if (accessToken == null) {
    Navigator.popAndPushNamed(mContext, '/login');
  } else {
    Map<String, dynamic> body = await UserRepository().autoLogin(accessToken);
    this.id = body["response"]["id"];
    this.username = body["response"]["username"];
    this.accessToken = accessToken;
    this.isLogin = true;
    dio.options.headers["Authorization"] = accessToken;
    Navigator.pushNamed(mContext, "/post/list");
  }
}
```
