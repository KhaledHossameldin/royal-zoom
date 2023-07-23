part of 'search_cubit.dart';

@immutable
abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchLoaded extends SearchState {
  final List<Major> majors;
  final List<Consultant> consultants;
  const SearchLoaded({required this.majors, required this.consultants});
}

class SearchError extends SearchState {
  final String message;
  const SearchError(this.message);
}
