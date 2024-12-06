import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
    required this.submit,
  }) : super(key: key);
  final Function(String) submit;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late final TextEditingController _searchBarController;

  final FocusNode _searchFocusNode = FocusNode();

  void _submit() async {
    String tag = _searchBarController.text.trim().replaceAll(' ', '');
    if (tag.isNotEmpty) {
      tag = tag[0] == '#' ? tag.substring(1) : tag;
      widget.submit(tag);

      _searchBarController.text = '';
      _searchFocusNode.unfocus();
      setState(() {});
    }
  }

  void _cancel() {
    if (_searchFocusNode.hasFocus) {
      _searchFocusNode.unfocus();
    } else {
      _searchBarController.text = "";
    }
    setState(() {});
  }

  @override
  void initState() {
    _searchBarController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildSearchBar()),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: TextField(
        controller: _searchBarController,
        focusNode: _searchFocusNode,
        onTap: () => setState(() {}),
        onChanged: (value) => setState(() {}),
        onSubmitted: (value) => _submit(),
        cursorColor: const Color.fromRGBO(0, 0, 0, 0.6),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 25.0),
          hintText: 'Restaurant, vegan, pizza...',
          hintStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          fillColor: const Color.fromRGBO(244, 246, 248, 1),
          prefixIconConstraints: const BoxConstraints(minWidth: 56),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(120.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(120.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          prefixIcon: _searchBarController.text.isNotEmpty
              ? GestureDetector(
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Color.fromRGBO(0, 0, 0, 0.6),
                  ),
                  onTap: () => _cancel(),
                  onLongPress: () {},
                )
              : null,
          suffixIcon: GestureDetector(
            onTap: () => _submit(),
            onLongPress: () {},
            child: const Icon(
              Icons.search,
              color: Color.fromRGBO(0, 0, 0, 0.6),
            ),
          ),
        ),
      ),
    );
  }
}
