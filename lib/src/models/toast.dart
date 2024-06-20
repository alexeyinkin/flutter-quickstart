import '../enums/toast_type.dart';

class Toast {
  final String description;
  final String title;
  final ToastType type;

  const Toast({
    required this.description,
    required this.title,
    required this.type,
  });
}
