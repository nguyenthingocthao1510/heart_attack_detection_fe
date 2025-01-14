import 'dart:async';

import 'package:flutter/material.dart';

class SearchFunction extends StatefulWidget {
  final Function(String) onSearch;

  const SearchFunction({super.key, required this.onSearch});

  @override
  State<SearchFunction> createState() => _SearchFunctionState();
}

class _SearchFunctionState extends State<SearchFunction> {
  Timer? _debounceTimer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5, top: 5),
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            TextField(
              onChanged: (query) {
                if (_debounceTimer != null) {
                  _debounceTimer!.cancel();
                }
                _debounceTimer = Timer(const Duration(milliseconds: 500), () {
                  widget.onSearch(query);
                });
              },
              cursorWidth: 1,
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                  hintText: 'Input search',
                  suffixIcon: Icon(
                    Icons.search,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  filled: true,
                  fillColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
