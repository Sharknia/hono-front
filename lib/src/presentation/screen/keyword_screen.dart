import 'package:flutter/material.dart';

class KeywordScreen extends StatelessWidget {
  const KeywordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('키워드 관리'),
      ),
      body: const Center(
        child: Text('로그인 성공! 키워드 관리 화면입니다.'),
      ),
    );
  }
}
