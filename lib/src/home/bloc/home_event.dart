part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetUser extends HomeEvent {}

class GetUserCategories extends HomeEvent {}

class UploadFiles extends HomeEvent {
  const UploadFiles(this.files);

  final List<File> files;

  @override
  List<Object> get props => [files];
}

class SelectCategory extends HomeEvent {
  const SelectCategory(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}