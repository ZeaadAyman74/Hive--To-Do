import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_todo/core/constants/colors.dart';
import '../../business_logic/notes_cubit/notes_cubit.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/notes_view_body.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  void initState() {
    NotesCubit.get(context).fetchAllNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar('Notes', Icons.search),
      body: const NotesViewBody(),
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.w)),
              context: context,
              builder: (context) {
                return const NoteBottomSheet();
              });
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
