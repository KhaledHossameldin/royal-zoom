part of 'majors_cubit.dart';

@immutable
abstract class MajorsState {
  const MajorsState();
}

class MajorsInitial extends MajorsState {
  const MajorsInitial();
}

class MajorsLoading extends MajorsState {
  const MajorsLoading();
}

class MajorsLoaded extends MajorsState {
  final List<Major> majors;
  const MajorsLoaded(this.majors);
}

class MajorsError extends MajorsState {
  final String message;
  const MajorsError(this.message);
}
