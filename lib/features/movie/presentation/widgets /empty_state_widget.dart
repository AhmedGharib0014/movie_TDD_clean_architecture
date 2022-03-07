import 'package:flutter/material.dart';

class EmptyStateScreen extends StatelessWidget {
  final String msg;
  const EmptyStateScreen({Key? key, required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Row(
            children: [
              Expanded(
                  child: Text(
                msg,
                textAlign: TextAlign.center,
              )),
            ],
          ),
        ));
  }
}
