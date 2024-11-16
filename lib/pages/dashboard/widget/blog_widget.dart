import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/data_models/blog_dm.dart';
import 'package:my_job_flutter/pages/dashboard/blog_details_page.dart';

class BlogWidget extends StatelessWidget {
  final BlogDatum state;
  const BlogWidget({required this.state, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(BlogDetailsPage.routeName, arguments: {
          "image": state.banner,
          "title": state.title,
          "desc": state.description
        });
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            child: Image.network(
              state.banner ?? '',
              fit: BoxFit.cover,
              height: 100,
            ),
          ),
          Expanded(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  border: Border.all(color: const Color(0xffEBEBEB), width: 1)
                  // borderRadius: BorderRadius.circular(15),
                  ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(13, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width / 2,
                      child: Text(
                        state.title ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: Get.width / 2 - 40,
                      child: Text(
                        state.description ?? '',
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xff8D8D8D),
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
