part of 'notes_cubit.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}

class SuccessState extends NotesState {}
class LoadingState extends NotesState {}
class ErrorState extends NotesState {}
