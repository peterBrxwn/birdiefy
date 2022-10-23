import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class FiberSearchProps extends TextFieldProps {
  final String labelText;
  @override
  InputDecoration get decoration => InputDecoration(
        prefixIcon: const Icon(Icons.search),
        labelText: labelText,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      );

  const FiberSearchProps({this.labelText = 'Search'}) : super();
}
