import 'package:flutter/material.dart';
import 'package:iot_app_prot1/shared_widgets/custom_card.dart';

class CustomDropdown extends StatefulWidget {
  final String label;
  final List<String> options;
  final List<String> descriptions;
  final String? selectedDevice;
  final Function(String) onChanged;
  final IconData? icon;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.options,
    this.descriptions = const [],
    this.selectedDevice,
    required this.onChanged,
    this.icon,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    List<String> sortedOptions = List.from(widget.options);
    List<String> sortedDescriptions = List.from(widget.descriptions);
    int selectedIndex = sortedOptions.indexWhere((option) => option == widget.selectedDevice);
    if (selectedIndex != -1 && selectedIndex != 0) {
      String selectedOption = sortedOptions.removeAt(selectedIndex);
      sortedOptions.insert(0, selectedOption);
      if (sortedDescriptions.isNotEmpty && selectedIndex < sortedDescriptions.length) {
        String selectedDescription = sortedDescriptions.removeAt(selectedIndex);
        sortedDescriptions.insert(0, selectedDescription);
      }
    }

    return CustomCard(
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 18.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: DropdownButton<String>(
            isExpanded: true,
            value: widget.selectedDevice,
            itemHeight: 65.0,
            items: sortedOptions.map((String option) {
              int index = sortedOptions.indexOf(option);
              String description = sortedDescriptions.isNotEmpty && index < sortedDescriptions.length ? sortedDescriptions[index] : '';
              return DropdownMenuItem<String>(
                value: option,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      if (widget.icon != null) Icon(widget.icon),
                      if (widget.icon != null) const SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(option),
                          if (description.isNotEmpty)
                            Text(
                              description,
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                int index = widget.options.indexOf(newValue);
                if (index != -1 && index != 0) {
                  String selectedOption = widget.options.removeAt(index);
                  widget.options.insert(0, selectedOption);
                  if (widget.descriptions.isNotEmpty && index < widget.descriptions.length) {
                    String selectedDescription = widget.descriptions.removeAt(index);
                    widget.descriptions.insert(0, selectedDescription);
                  }
                }
                widget.onChanged(newValue);
              }
            },
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ],
    );
  }
}
