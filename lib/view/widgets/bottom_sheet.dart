import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hive_todo/core/constants/colors.dart';
import 'package:hive_todo/models/note_model.dart';
import 'package:hive_todo/view/widgets/custom_textfield.dart';

import '../../business_logic/add_note_cubit/add_note_cubit.dart';
import '../../business_logic/add_note_cubit/add_note_states.dart';
import '../../business_logic/notes_cubit/notes_cubit.dart';

class NoteBottomSheet extends StatelessWidget {
  const NoteBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNoteCubit(),
      child: BlocConsumer<AddNoteCubit,AddNoteStates>(
        listener: (context, state) {
          if (state is AddNoteSuccessState) {
            Navigator.pop(context);
          }
          if (state is AddNoteErrorState) {
            if (kDebugMode) {
              print('Errooooooor');
            }
          }
        },
        builder: (context,state){
          return AbsorbPointer(
            absorbing: state is AddNoteLoadingState ? true : false,
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
                top: 20.h,
                bottom: MediaQuery.of(context).viewInsets.bottom
              ),
              child: const SingleChildScrollView(child: NoteForm()),
            ),
          );
        }
      ),
    );
  }
}

class NoteForm extends StatefulWidget {
  const NoteForm({Key? key}) : super(key: key);

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  String? title;
  String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autoValidate,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Column(
          children: [
            CustomTextField(
                hint: 'Title',
                maxLines: 1,
                onSaved: (value) {
                  title = value;
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            CustomTextField(
              hint: 'Content',
              maxLines: 5,
              onSaved: (value) {
                subTitle = value;
              },
            ),
             SizedBox(height: MediaQuery.of(context).size.height/12,),
            BlocBuilder<AddNoteCubit, AddNoteStates>(
              builder: (context, state) {
                return SizedBox(
                  height: 40.h,
                  width: double.infinity,
                  child: state is AddNoteLoadingState
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              var noteModel = NoteModel(
                                  title: title!,
                                  subTitle: subTitle,
                                  color: Colors.teal.value,
                                  date: DateTime.now().toString());
                              AddNoteCubit.get(context).addNote(noteModel);
                              NotesCubit.get(context).fetchAllNotes();
                            } else {
                              setState(() {
                                autoValidate = AutovalidateMode.always;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text(
                            'Add',
                            style:
                                TextStyle(color: Colors.black, fontSize: 18.sp),
                          ),
                        ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
