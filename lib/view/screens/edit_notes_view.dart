import 'package:flutter/material.dart';
import 'package:hive_todo/models/note_model.dart';
import 'package:hive_todo/view/widgets/custom_appbar.dart';
import 'package:hive_todo/view/widgets/edit_notes_view_body.dart';
import '../../business_logic/notes_cubit/notes_cubit.dart';

class EditNotesView extends StatefulWidget {
  const EditNotesView({Key? key, required this.note}) : super(key: key);
  final NoteModel note;

  @override
  State<EditNotesView> createState() => _EditNotesViewState();
}

class _EditNotesViewState extends State<EditNotesView> {
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autoValidate,
      child: Scaffold(
        appBar: customAppbar('Edit Note', Icons.check, () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            NotesCubit.get(context).editNote(widget.note);
            NotesCubit.get(context).fetchAllNotes();
            Navigator.pop(context);
          } else {
            setState(() {
              autoValidate = AutovalidateMode.always;
            });
          }
        }),
        body: EditNotesViewBody(
          title: widget.note.title, subTitle: widget.note.subTitle!,),
      ),
    );
  }
}
