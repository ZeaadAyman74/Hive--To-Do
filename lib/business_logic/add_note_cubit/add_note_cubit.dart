import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todo/core/constants/strings.dart';
import 'package:hive_todo/models/note_model.dart';
import 'add_note_states.dart';

class AddNoteCubit extends Cubit<AddNoteStates> {
  AddNoteCubit() : super(InitialState());

  static AddNoteCubit get(BuildContext context) =>
      BlocProvider.of<AddNoteCubit>(context);

  addNote(NoteModel note) async {
    try {
      emit(AddNoteLoadingState());
      var notesBox = Hive.box<NoteModel>(hiveBox);
      await notesBox.add(note);
      emit(AddNoteSuccessState());
    } catch (e) {
      emit(AddNoteErrorState(e.toString()));
    }
  }
}
