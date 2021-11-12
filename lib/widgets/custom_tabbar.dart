import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    Key? key,
    required this.labels,
    required this.getContent,
  }) : super(key: key);

  final List<Widget> labels;
  final Widget Function(int index) getContent;

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int _selectedIndex = 0;

  void _onHeaderItemTapped(Widget label) {
    setState(() {
      _selectedIndex = widget.labels.indexOf(label);
    });
  }

  Widget _buildSwitcherLayout(
    Widget? currentChild,
    List<Widget> previousChildren,
  ) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        ...previousChildren,
        if (currentChild != null) currentChild,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTextStyle(
          style: Theme.of(context).textTheme.subtitle1!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (final label in widget.labels)
                _HeaderItem(
                  onTap: () => _onHeaderItemTapped(label),
                  label: label,
                  isSelected: widget.labels.indexOf(label) == _selectedIndex,
                ),
            ],
          ),
        ),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            layoutBuilder: _buildSwitcherLayout,
            child: widget.getContent(_selectedIndex),
          ),
        ),
      ],
    );
  }
}

class _HeaderItem extends StatelessWidget {
  const _HeaderItem({
    Key? key,
    required this.onTap,
    required this.label,
    required this.isSelected,
  }) : super(key: key);

  final void Function() onTap;
  final Widget label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 4,
              color: isSelected ? Colors.black : Colors.transparent,
            ),
          ),
        ),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            isSelected ? Colors.black : Colors.black54,
            BlendMode.srcIn,
          ),
          child: label,
        ),
      ),
    );
  }
}
