import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:flutter/material.dart';

List<String> query = ['البان', ' حليب', 'ارز ابو كأس', 'دجاج', 'بيض', 'خبز'];

class WrapList extends StatefulWidget {
  const WrapList({super.key});

  @override
  State<WrapList> createState() => _WrapListState();
}

class _WrapListState extends State<WrapList> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),

      child: Wrap(
        spacing: 4,
        children:
        query.asMap().entries.map((entry) {
          final int index = entry.key;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color:
                _selectedIndex == index ? Colors.red : Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                entry.value,
                style: getSemiBoldStyle(
                  color:
                  _selectedIndex == index ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}