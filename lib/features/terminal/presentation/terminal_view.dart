import 'package:flutter/material.dart';
import 'terminal_logic.dart';

class TerminalView extends StatefulWidget {
  const TerminalView({super.key});

  @override
  State<TerminalView> createState() => _TerminalViewState();
}

class _TerminalViewState extends State<TerminalView> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final TerminalLogic _logic = TerminalLogic();

  // History: Each item is a map with 'type' (command/output) and 'text'
  final List<Map<String, String>> _history = [
    {'type': 'output', 'text': 'Welcome to FlutterOS Terminal v2.0'},
    {'type': 'output', 'text': 'Type "help" for a list of commands.'},
  ];

  void _handleSubmitted(String input) {
    setState(() {
      // Add user command
      _history.add({'type': 'command', 'text': input});

      if (input.trim() == 'clear') {
        _history.clear();
      } else {
        final response = _logic.processCommand(input);
        if (response.isNotEmpty) {
          _history.add({'type': 'output', 'text': response});
        }
      }
      _controller.clear();
    });

    _scrollToBottom();
    _focusNode.requestFocus();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 50), () {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const monoStyle = TextStyle(
      color: Color(0xFFE0E0E0), // Off-white for better readability
      fontFamily: 'Courier New',
      fontFamilyFallback: ['monospace'],
      fontSize: 14,
      height: 1.2,
    );

    const greenStyle = TextStyle(
      color: Color(0xFF50FA7B), // Dracula Green
      fontFamily: 'Courier New',
      fontFamilyFallback: ['monospace'],
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );

    const blueStyle = TextStyle(
      color: Color(0xFFBD93F9), // Dracula Purple/Blue
      fontFamily: 'Courier New',
      fontFamilyFallback: ['monospace'],
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );

    return SelectionArea(
      // Allow text selection
      child: Container(
        color: const Color(0xFF1E1E1E), // Dracula Dark Background
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _focusNode.requestFocus(),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    final item = _history[index];
                    if (item['type'] == 'command') {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'baskaran@flutter-os',
                              style: greenStyle,
                            ),
                            const Text(
                              ':',
                              style: TextStyle(color: Colors.white),
                            ),
                            const Text('~', style: blueStyle),
                            const Text(
                              '\$ ',
                              style: TextStyle(color: Colors.white),
                            ),
                            Expanded(
                              child: Text(item['text']!, style: monoStyle),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(item['text']!, style: monoStyle),
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Input Line
            Row(
              children: [
                const Text('baskaran@flutter-os', style: greenStyle),
                const Text(':', style: TextStyle(color: Colors.white)),
                const Text('~', style: blueStyle),
                const Text('\$ ', style: TextStyle(color: Colors.white)),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    onSubmitted: _handleSubmitted,
                    style: monoStyle,
                    cursorColor: const Color(0xFF50FA7B),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
