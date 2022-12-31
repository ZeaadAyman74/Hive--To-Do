import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_todo/models/note_model.dart';
import 'package:hive_todo/view/widgets/note_item.dart';
import '../../business_logic/notes_cubit/notes_cubit.dart';

class NotesViewBody extends StatelessWidget {
  const NotesViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 8.h),
      child: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          List<NoteModel> notes = NotesCubit.get(context).notes ?? [];
          return ListView.separated(
              itemBuilder: (context, index) => NoteItem(
                    note: notes[index],
                  ),
              separatorBuilder: (context, index) => SizedBox(
                    height: 10.h,
                  ),
              itemCount: notes.length);
        },
      ),
    );
  }
}
