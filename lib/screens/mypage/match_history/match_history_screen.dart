import 'package:flutter/material.dart';

class MatchHistoryScreen extends StatelessWidget {
  const MatchHistoryScreen({super.key});

  void _onBackPress(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '매칭전적',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: const Color(0xffefefef),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => _onBackPress(context),
            icon: const Icon(
              Icons.close,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
