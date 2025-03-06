part of 'add_new_major_cubit.dart';

@immutable
abstract class AddNewMajorState {
  const AddNewMajorState();
}

class AddNewMajorInitial extends AddNewMajorState {
  const AddNewMajorInitial();
}

class AddNewMajorLoading extends AddNewMajorState {
  const AddNewMajorLoading();
}

class AddNewMajorLoaded extends AddNewMajorState {
  const AddNewMajorLoaded();
}

class AddNewMajorError extends AddNewMajorState {
  final String message;
  const AddNewMajorError(this.message);
}
