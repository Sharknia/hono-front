# Hotdeal Tuum (Flutter Frontend)

이 프로젝트는 핫딜 정보를 제공하는 서비스 'Tuum'의 Flutter 프론트엔드 애플리케이션입니다.

## 개발 환경 실행 가이드

이 애플리케이션은 실행 환경(local, production)에 따라 다른 API 서버를 바라봅니다.

### 로컬 환경 실행

로컬 백엔드 서버(`http://localhost:8787`)와 통신하며, CORS 문제를 피하기 위해 **반드시 3000번 포트를 사용해야 합니다.**

아래 명령어를 Flutter 프로젝트 디렉토리(`hotdeal_tuum`) 안에서 실행하세요.

```bash
flutter run -d chrome --web-port=3000
```

### 프로덕션 환경 실행

프로덕션 백엔드 서버(`https://hono-be.furychick0.workers.dev`)와 통신합니다.

```bash
flutter run -d chrome --web-port=3000 --dart-define=ENV=production
```
