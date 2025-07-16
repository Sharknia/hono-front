# 공용 위젯 문서

이 문서는 프로젝트 전반에서 사용되는 공용 위젯의 사용법을 안내합니다.

## `CustomAlertDialog`

앱의 일관된 사용자 경험을 제공하기 위한 공용 다이얼로그 위젯입니다.

### 사용법

`showCustomDialog` 헬퍼 함수를 사용하여 다이얼로그를 표시합니다.

```dart
import 'package:hotdeal_with_hono/src/presentation/widget/custom_alert_dialog.dart';

showCustomDialog(
  context: context,
  dialogType: DialogType.success, // success, error, confirmation 중 선택
  title: '제목',
  content: '내용',
  onConfirm: () {
    // OK 버튼을 눌렀을 때 실행할 콜백 (선택 사항)
  },
);
```

### `DialogType`

-   `DialogType.success`: 성공 메시지를 표시할 때 사용합니다. 'OK' 버튼만 표시됩니다.
-   `DialogType.error`: 에러 메시지를 표시할 때 사용합니다. 'OK' 버튼만 표시됩니다.
-   `DialogType.confirmation`: 사용자에게 확인을 받을 때 사용합니다. 'Cancel'과 'OK' 버튼이 모두 표시됩니다.

### 예시

#### 성공 다이얼로그

```dart
showCustomDialog(
  context: context,
  dialogType: DialogType.success,
  title: '성공',
  content: '작업이 성공적으로 완료되었습니다.',
);
```

#### 확인 다이얼로그

```dart
final result = await showCustomDialog(
  context: context,
  dialogType: DialogType.confirmation,
  title: '삭제 확인',
  content: '정말로 삭제하시겠습니까?',
);

if (result == true) {
  // 'OK' 버튼 클릭 시 로직
}
```
