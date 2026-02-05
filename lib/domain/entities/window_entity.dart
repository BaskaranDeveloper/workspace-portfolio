class WindowEntity {
  final String id;
  final String title;
  final bool isMinimized;
  final bool isMaximized;

  WindowEntity({
    required this.id,
    required this.title,
    this.isMinimized = false,
    this.isMaximized = false,
  });
}
