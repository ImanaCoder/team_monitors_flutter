import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:team_monitor/helpers/color_extension.dart';

class AppFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String? initialValue;
  final bool readOnly;
  final int? maxLines;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String?)? onSaved;

  const AppFormField({
    super.key,
    this.controller,
    required this.label,
    this.initialValue,
    this.maxLines = 1,
    this.readOnly = false,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        maxLines: maxLines,
        readOnly: readOnly,
        controller: controller,
        initialValue: initialValue,
        validator: validator,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onSaved: onSaved,
        decoration: InputDecoration(
          label: Text(label),
          contentPadding: const EdgeInsets.all(15),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: TeamMonitorColor.borderColor),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: TeamMonitorColor.primaryColor1),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        style: TextStyle(
            color: TeamMonitorColor.blackColor,
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
    );
  }
}

class AppPasswordField extends StatefulWidget {
  final TextEditingController passController;
  const AppPasswordField({super.key, required this.passController});

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool obscurePassword = true;
  Icon visible = const Icon(Icons.visibility, color: Colors.black, size: 20);
  Icon nonVisible =
      const Icon(Icons.visibility_off, color: Colors.black, size: 20);

  Widget toggleButton() {
    return IconButton(
      icon: obscurePassword ? visible : nonVisible,
      onPressed: () => setState(() => obscurePassword = !obscurePassword),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 25,
      child: TextFormField(
        controller: widget.passController,

        obscureText: obscurePassword,
        // validator: ValidationService.validateNonEmptiness,//TODO
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Password",
          suffixIcon: toggleButton(),
          contentPadding: const EdgeInsets.all(15),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: TeamMonitorColor.borderColor),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: TeamMonitorColor.primaryColor1),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        style: TextStyle(
            color: TeamMonitorColor.blackColor,
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
    );
  }
}

class AppCheckBox extends StatefulWidget {
  final bool value;
  final TextEditingController controller;
  const AppCheckBox({super.key, required this.value, required this.controller});

  @override
  State<AppCheckBox> createState() => _AppCheckBoxState();
}

class _AppCheckBoxState extends State<AppCheckBox> {
  late bool checkBoxValue;
  @override
  void initState() {
    checkBoxValue = widget.value;
    widget.controller.text = checkBoxValue.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Checkbox(
        value: checkBoxValue,
        onChanged: ((value) {
          setState(() {
            checkBoxValue = value!;
            widget.controller.text = checkBoxValue.toString();
          });
        }),
        activeColor: const Color.fromRGBO(210, 210, 210, 1),
      ),
    ]);
  }
}

class AppSearchableDropdown extends StatelessWidget {
  final String labelText;
  final String keyString;
  final List<dynamic> items;
  // final String Function(dynamic)? itemAsString;
  // final bool Function(dynamic, String)? filterFn;
  final void Function(dynamic)? onChanged;
  const AppSearchableDropdown({
    super.key,
    required this.labelText,
    required this.keyString,
    required this.items,
    // required this.itemAsString,
    // this.filterFn,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: DropdownSearch<dynamic>(
        popupProps: const PopupProps.menu(
          showSearchBox: true,
          searchDelay: Duration(microseconds: 1),
          showSelectedItems: false,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              contentPadding: EdgeInsets.all(0),
            ),
          ),
        ),
        items: items,
        itemAsString: (item) => item[keyString],
        filterFn: (item, filter) =>
            item[keyString].toLowerCase().startsWith(filter.toLowerCase()),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labelText,
            prefixIcon:
                const Icon(Icons.search, color: Color(0xFF171717), size: 18),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          ),
        ),
        onChanged: onChanged,
        // selectedItem: item,
      ),
    );
  }
}

class AppSwichInput extends StatefulWidget {
  final String activeText, inActiveText;
  final bool isActive;
  final Function? onSwitch;
  const AppSwichInput({
    super.key,
    required this.activeText,
    required this.inActiveText,
    required this.isActive,
    this.onSwitch,
  });

  @override
  State<AppSwichInput> createState() => _AppSwichInputState();
}

class _AppSwichInputState extends State<AppSwichInput> {
  Widget title(String text) =>
      Text(text, style: const TextStyle(color: Color(0xFF2D3B8A)));
  Widget switchInput() => Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0XFF2C2F74),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onSwitch != null) widget.onSwitch!();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFF049C2F)),
        ),
        child: Row(
          children: [
            widget.isActive ? title(widget.activeText) : switchInput(),
            const SizedBox(width: 5),
            widget.isActive ? switchInput() : title(widget.inActiveText),
          ],
        ),
      ),
    );
  }
}

class TinyTextbox extends StatelessWidget {
  final void Function(String?)? onChanged;
  const TinyTextbox({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 20,
      child: TextFormField(
        cursorHeight: 20,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
