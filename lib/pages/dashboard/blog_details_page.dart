import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/environment.dart';

class BlogDetailsPage extends StatefulWidget {
  static const routeName = '/blogDetails';
  const BlogDetailsPage({Key? key}) : super(key: key);

  @override
  State<BlogDetailsPage> createState() => _BlogDetailsPageState();
}

class _BlogDetailsPageState extends State<BlogDetailsPage> {
  late String image;
  late String title, desc;
  @override
  void initState() {
    super.initState();
    Map<String, dynamic> map = Get.arguments;
    if (map != null) {
      image = map['image'];
      title = map['title'];
      desc = map['desc'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Image.network(
            image,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: const TextStyle(
                      fontFamily: Environment.fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  desc,
                  style: const TextStyle(
                      fontFamily: Environment.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                )),
          ),
        ],
      ),
    );
  }
}
