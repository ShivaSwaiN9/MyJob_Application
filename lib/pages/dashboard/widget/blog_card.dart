import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/environment.dart';
import 'package:my_job_flutter/data_models/blog_dm.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/dashboard/blog_details_page.dart';
import 'package:timeago/timeago.dart' as time_ago;

///
///Created By Sisira Sahoo (coolsisira1998@gmail.com) on 17-05-2021 22:13
///

class BlogsCard extends StatefulWidget {
  final BlogDatum data;

  const BlogsCard({Key? key, required this.data}) : super(key: key);

  @override
  _BlogsCardState createState() => _BlogsCardState();
}

class _BlogsCardState extends State<BlogsCard> {
  bool _readMore = true;

  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(BlogDetailsPage.routeName, arguments: {
          "image": widget.data.banner,
          "title": widget.data.title,
          "desc": widget.data.description
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 11, 16, 18),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: SizedBox(
                  height: 120,
                  child: Stack(children: [
                    Image.network(
                      widget.data.banner!,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                            const Color(0xff000000).withOpacity(0.47),
                            const Color(0xff000000),
                          ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                    ),
                    Positioned(
                      top: 80,
                      left: 14,
                      child: Row(
                        children: [
                          const Icon(Icons.access_time_rounded,
                              size: 14, color: Color(0xffFFFFFF)),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            timeInAgoShort(widget.data.updatedAt!),
                            style: const TextStyle(
                                color: Color(0xffFFFFFF),
                                fontWeight: FontWeight.w400,
                                fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ])),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "${widget.data.title}",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: Environment.fontFamily),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                  text: TextSpan(
                text: widget.data.description!.length < 60
                    ? widget.data.description!
                    : _readMore
                        ? widget.data.description!.substring(0, 50)
                        : widget.data.description,
                style: const TextStyle(
                    fontFamily: Environment.fontFamily,
                    color: Color(0xff2F2F2F)),
                children: [
                  if (widget.data.description!.length >= 60)
                    TextSpan(
                      text: _readMore
                          ? S.of(context).readMore
                          : S.of(context).readLess,
                      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff3E9AFF),
                          fontSize: 13),
                    ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}

String timeInAgoShort(DateTime dateTime) {
  return time_ago.format(dateTime, locale: 'en_short', allowFromNow: true);
}
