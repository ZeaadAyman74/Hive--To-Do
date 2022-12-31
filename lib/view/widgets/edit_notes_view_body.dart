import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_todo/view/widgets/custom_textfield.dart';

import '../../business_logic/notes_cubit/notes_cubit.dart';

class EditNotesViewBody extends StatelessWidget {
   const EditNotesViewBody({Key? key, required this.title, required this.subTitle})
      : super(key: key);

  final String title, subTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
      child: Column(
        children: [
          CustomTextField(
            hint: 'Title',
            maxLines: 1,
            controller: TextEditingController(text:title),
            onSaved: (value) {
              NotesCubit.get(context).editTitle(value!);
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
          ),
          CustomTextField(
            hint: 'Content',
            maxLines: 5,
            controller: TextEditingController(text: subTitle),
            onSaved: (value) {
              NotesCubit.get(context).editSubTitle(value!);
            },
          ),
        ],
      ),
    );
  }

}
