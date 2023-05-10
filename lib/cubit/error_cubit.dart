import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorCubit extends Cubit<String?> {
  ErrorCubit() : super(null);

  void showError(String message) {
    emit(message);
  }

  void clearError() {
    emit(null);
  }
}
