# Hotdeal Tuum (Flutter Frontend)

이 프로젝트는 핫딜 정보를 제공하는 서비스 'Tuum'의 Flutter 프론트엔드 애플리케이션입니다.

## 개발 환경 실행 가이드

이 애플리케이션을 로컬 환경에서 웹(Chrome)으로 실행하려면, 백엔드 API 서버와의 CORS(Cross-Origin Resource Sharing) 문제를 피하기 위해 **반드시 3000번 포트를 사용해야 합니다.**

아래 명령어를 Flutter 프로젝트 디렉토리(`hotdeal_tuum`) 안에서 실행하세요.

```bash
flutter run -d chrome --web-port=3000
```
