import 'package:flutter/material.dart';

class RequestDetailsTile extends StatelessWidget {
  final String title, desc;
  const RequestDetailsTile({required this.title, required this.desc, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Color(0xffBCBCBC), fontSize: 12),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            desc,
            style: const TextStyle(color: Color(0xff545454)),
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            height: 0,
          )
        ],
      ),
    );
  }
}
