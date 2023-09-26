part of 'clipboard_cubit.dart';

sealed class ClipboardState extends Equatable {
  const ClipboardState();

  @override
  List<Object> get props => [];
}

final class ClipboardInitial extends ClipboardState {}

final class Copied extends ClipboardState {
  
}

final class ClipboardError extends ClipboardState {
  final String message;

  const ClipboardError({required this.message});

  @override
  List<Object> get props => [message];
}
