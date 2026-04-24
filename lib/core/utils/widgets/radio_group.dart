import 'package:flutter/material.dart';

class RadioGroupOption<T> {
  final T value;
  final String label;

  RadioGroupOption({required this.value, required this.label});
}

class RadioGroup<T> extends StatefulWidget {
  final List<RadioGroupOption<T>> options;
  final List<T>? initialValues;
  final bool isMultipleChoice;
  final void Function(List<T> selectedValues)? onChanged;

  const RadioGroup({
    super.key,
    required this.options,
    this.initialValues,
    this.isMultipleChoice = false,
    this.onChanged,
  });

  @override
  State<RadioGroup<T>> createState() => _RadioGroupState<T>();
}

class _RadioGroupState<T> extends State<RadioGroup<T>> {
  late List<T> _selectedValues;

  @override
  void initState() {
    super.initState();
    _selectedValues = widget.initialValues ?? [];
  }

  void _handleSelect(T value) {
    setState(() {
      if (widget.isMultipleChoice) {
        if (_selectedValues.contains(value)) {
          _selectedValues.remove(value);
        } else {
          _selectedValues.add(value);
        }
      } else {
        _selectedValues = [value];
      }
    });
    widget.onChanged?.call(_selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options.map((option) {
        final isSelected = _selectedValues.contains(option.value);
        return InkWell(
          onTap: () => _handleSelect(option.value),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: widget.isMultipleChoice ? BoxShape.rectangle : BoxShape.circle,
                    borderRadius: widget.isMultipleChoice ? BorderRadius.circular(4) : null,
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.grey,
                      width: 2,
                    ),
                    color: isSelected ? Colors.blue : null,
                  ),
                  child: isSelected
                      ? Center(
                          child: widget.isMultipleChoice
                              ? const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                )
                              : Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    option.label,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
