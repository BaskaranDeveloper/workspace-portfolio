class TerminalLogic {
  String processCommand(String input) {
    final command = input.trim().toLowerCase();

    switch (command) {
      case 'help':
        return 'Available commands:\n  help    - Show this message\n  about   - About me\n  clear   - Clear screen\n  date    - Show current time\n  echo [text] - Echo text';
      case 'about':
        return 'Flutter OS v1.0\nCreated by baskaran\nBuilt with Flutter & Dart.\nSimulating a desktop environment on the web.';
      case 'date':
        return DateTime.now().toString();
      case 'ls':
        return 'Documents  Downloads  Pictures  Music  Desktop';
      case 'pwd':
        return '/home/user';
      case 'whoami':
        return 'user';
      case '':
        return '';
      default:
        if (command.startsWith('echo ')) {
          return input.substring(5);
        }
        return 'Command not found: $command';
    }
  }
}
