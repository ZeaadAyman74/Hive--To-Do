abstract class AddNoteStates {}

class InitialState extends AddNoteStates {}
class AddNoteSuccessState extends AddNoteStates {}
class AddNoteLoadingState extends AddNoteStates {}
class AddNoteErrorState extends AddNoteStates{
  String? error;
  AddNoteErrorState(this.error);
}