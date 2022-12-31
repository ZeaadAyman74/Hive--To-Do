import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar customAppbar(String title, IconData icon, [Function()? iconAction]) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 24.sp,
      ),
    ),
    actions: [
      CustomIcon(
        icon: icon,
        iconAction: iconAction,
      )
    ],
    elevation: 0,
    toolbarHeight: 70.h,
  );
}

class CustomIcon extends StatelessWidget {
  const CustomIcon({Key? key, required this.icon, this.iconAction})
      : super(key: key);
  final IconData icon;
  final Function()? iconAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent.withOpacity(.1),
            borderRadius: BorderRadius.all(Radius.circular(8.w))),
        child: Padding(
            padding: EdgeInsets.all(5.h),
            child: IconButton(
              icon: Icon(
                icon,
                size: 35.w,
              ),
              onPressed: iconAction,
            )),
      ),
    );
  }
}
