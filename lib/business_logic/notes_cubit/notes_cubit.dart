import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todo/models/note_model.dart';
import 'package:meta/meta.dart';
import '../../core/constants/strings.dart';
import '../../models/note_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  static NotesCubit get(BuildContext context) =>
      BlocProvider.of<NotesCubit>(context);

  List<NoteModel>? notes;

  void fetchAllNotes() {
    var notesBox = Hive.box<NoteModel>(hiveBox);
    notes = notesBox.values.toList();
    emit(SuccessState());
  }

  void deleteNote(NoteModel noteModel) async {
    await noteModel.delete();
  }

  String? newTitle, newSubTitle;

  void editTitle(String title) {
    newTitle = title;
  }

  void editSubTitle(String subTitle) {
    newSubTitle = subTitle;
  }

  void editNote(NoteModel note) async {
    note.title = newTitle!;
    note.subTitle = newSubTitle;
    note.date = DateTime.now().toString();
    await note.save();
  }
}
