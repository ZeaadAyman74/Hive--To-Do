import 'package:flutter/material.dart';
import 'package:hive_todo/core/constants/routes.dart';
import 'package:hive_todo/models/note_model.dart';
import 'package:hive_todo/view/screens/edit_notes_view.dart';
import 'package:hive_todo/view/screens/notes_view.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings){
    switch(settings.name){
      case notesViewRoute:
        return MaterialPageRoute(builder: (_)=>const NotesView());
      case editNotesViewRoute:
        final note=settings.arguments as NoteModel;
        return MaterialPageRoute(builder: (_)=>  EditNotesView(note: note,));
    }
    return null;
  }
}