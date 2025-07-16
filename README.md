# 핫딜 알리미 (Hot Deal Notifier)

사용자가 지정한 키워드에 대한 온라인 핫딜 정보를 실시간으로 알려주는 Flutter 기반 앱/웹 서비스입니다.

## ✨ 주요 기능

-   **사용자 인증:** 간편한 로그인/회원가입 및 자동 로그인 기능을 지원합니다.
-   **개인화 키워드 관리:** 사용자는 자신만의 핫딜 키워드를 자유롭게 등록, 조회, 삭제할 수 있습니다.
-   **실시간 알림 (예정):** 백엔드 시스템이 주기적으로 웹을 크롤링하여, 사용자가 등록한 키워드와 일치하는 핫딜 정보를 찾으면 이메일 또는 푸시 알림을 보내줍니다.

## 🏛️ 아키텍처

-   **Domain-Driven Design (DDD):** 각 계층(Presentation, Application, Domain, Infrastructure)의 역할을 명확히 분리하여 유지보수성과 확장성을 높입니다.
-   **Test-Driven Development (TDD):** 모든 주요 로직은 테스트 코드를 통해 검증하여 안정성을 확보합니다.

## 🚀 시작하기

### 로컬에서 실행 (웹)

1.  저장소를 클론합니다.

    ```bash
    git clone https://github.com/Sharknia/hono-front.git
    cd hono-front
    ```

2.  의존성을 설치합니다.

    ```bash
    flutter pub get
    ```

3.  웹 애플리케이션을 실행합니다. (기본 포트)

    ```bash
    flutter run -d chrome
    ```

4.  특정 포트(예: 3000번)로 실행하려면 아래 명령어를 사용하세요.
    ```bash
    flutter run -d chrome --web-port 3000
    ```

## 🌐 서비스 정보

-   **운영 주소:** [hotdeal.tuum.day](https://hotdeal.tuum.day) (예정)
-   **백엔드 API:** [https://hono-be.furychick0.workers.dev](https://hono-be.furychick0.workers.dev)
