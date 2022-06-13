import 'package:equatable/equatable.dart';

class File extends Equatable {
  const File({
    required this.path,
    required this.name,
  });

  final String path;
  final String name;

  @override
  List<Object?> get props => [path, name];
}
