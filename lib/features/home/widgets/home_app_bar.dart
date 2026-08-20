import 'package:flutter/material.dart';
import 'package:sasto_mart/core/adaptive/adaptive.dart';
import 'package:sasto_mart/features/chatbot/views/chat_page.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          Container(
            padding: EdgeInsets.all(context.wp(2)),
            decoration: BoxDecoration(
              color: AppColors.navyBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
              size: context.sp(18),
            ),
          ),
          SizedBox(width: context.wp(2.5)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SastoMart",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppColors.navyBlue,
                  fontSize: context.sp(18),
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                "Best deals delivered",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.textGrey,
                  fontSize: context.sp(11),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_none_rounded,
            color: AppColors.navyBlue,
            size: context.sp(22),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.smart_toy_outlined,
            color: AppColors.accentBlue,
            size: context.sp(22),
          ),
          tooltip: "Chat with SastoMart AI",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatPage()),
            );
          },
        ),
        SizedBox(width: context.wp(2)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
