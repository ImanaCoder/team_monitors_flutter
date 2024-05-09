import 'package:flutter/material.dart';

class ValueSelector extends StatelessWidget {
  final String label;
  final String textColumn;
  final TextEditingController controller;
  final Future future;
  const ValueSelector({
    super.key,
    required this.label,
    required this.textColumn,
    required this.controller,
    required this.future,
  });

  @override
  Widget build(BuildContext context) {
    return ValueSelectorBox(
      label: label,
      child: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error ${snapshot.error.toString()}"));
          } else if (snapshot.hasData) {
            var options = snapshot.data;
            return _ValueDropdown(controller: controller, textColumn: textColumn, options: options!);
          } else {
            return const Center(child: Text("Something went wrong"));
          }
        },
      ),
    );
  }
}

class ValueSelectorBox extends StatelessWidget {
  final String label;
  final Widget child;
  const ValueSelectorBox({super.key, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        height: 40,
        padding: const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          // border: Border.all(color: Colors.blue),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(width: 8),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class _ValueDropdown extends StatefulWidget {
  final TextEditingController controller;
  final List<dynamic> options;
  final String textColumn;
  const _ValueDropdown({required this.controller, required this.options, required this.textColumn});

  @override
  State<_ValueDropdown> createState() => __ValueDropdownState();
}

class __ValueDropdownState extends State<_ValueDropdown> {
  late dynamic selected;

  @override
  void initState() {
    super.initState();
    if (widget.controller.text != "") {
      selected = widget.options.firstWhere((element) => element['id'] == int.parse(widget.controller.text));
    } else {
      selected = widget.options[0];
    }
    widget.controller.text = "${selected['id']}";
  }

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton<dynamic>(
        isExpanded: true,
        underline: Container(),
        items: widget.options.map((item) {
          return DropdownMenuItem<dynamic>(
            value: item,
            child: Text(item[widget.textColumn], style: const TextStyle(fontSize: 14)),
          );
        }).toList(),
        value: selected,
        onChanged: (value) {
          setState(() {
            selected = value!;
            widget.controller.text = "${value['id']}";
          });
        },
      ),
    );
  }
}
