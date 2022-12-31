import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_todo/core/constants/routes.dart';
import 'package:hive_todo/models/note_model.dart';

import '../../business_logic/notes_cubit/notes_cubit.dart';


class NoteItem extends StatelessWidget {
  const NoteItem({Key? key,required this.note}) : super(key: key);

  final NoteModel note;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, editNotesViewRoute,arguments: note);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(note.color),
          borderRadius: BorderRadius.all(Radius.circular(15.w)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(note.title,
                    style: TextStyle(color: Colors.black, fontSize: 26.sp),),
                  const Spacer(),
                  IconButton(icon: Icon(
                    FontAwesomeIcons.trash, color: Colors.black, size: 28.sp,),
                    onPressed: () {
                      NotesCubit.get(context).deleteNote(note);
                      NotesCubit.get(context).fetchAllNotes();

                    },),
                ],
              ),
              Text(note.subTitle!, style: TextStyle(
                  color: Colors.black.withOpacity(.4), fontSize: 20.sp),),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height / 20,),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Text(note.date, style: TextStyle(
                      color: Colors.black.withOpacity(.4), fontSize: 18.sp)))
            ],
          ),
        ),
      ),
    );
  }
}
