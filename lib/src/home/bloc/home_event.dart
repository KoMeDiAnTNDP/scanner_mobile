part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetUser extends HomeEvent {}

class GetUserMainCategories extends HomeEvent {}

class UploadFiles extends HomeEvent {
  const UploadFiles(this.files, this.advance);

  final List<File> files;
  final bool advance;

  @override
  List<Object> get props => [files, advance];
}

class SelectCategory extends HomeEvent {
  const SelectCategory(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}

class AdvanceModeChanged extends HomeEvent {
  const AdvanceModeChanged(this.advance);

  final bool advance;

  @override
  List<Object> get props => [advance];
}