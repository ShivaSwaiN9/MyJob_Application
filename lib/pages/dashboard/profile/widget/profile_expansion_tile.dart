import 'package:flutter/material.dart';
import 'package:my_job_flutter/app_configs/environment.dart';
import 'package:my_job_flutter/generated/l10n.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class ProfileExpansionTile extends StatefulWidget {
  const ProfileExpansionTile(
      {Key? key,
      this.leadingIcon,
      required this.title,
      this.onExpansionChanged,
      this.children = const <Widget>[],
      this.trailing,
      this.initiallyExpanded = false,
      this.onEdit,
      this.onAdd})
      : super(key: key);

  final Widget? leadingIcon;
  final String title;
  final ValueChanged<bool>? onExpansionChanged;
  final VoidCallback? onEdit;
  final VoidCallback? onAdd;
  final List<Widget> children;
  final Widget? trailing;
  final bool initiallyExpanded;

  @override
  ProfileExpansionTileState createState() => ProfileExpansionTileState();
}

class ProfileExpansionTileState extends State<ProfileExpansionTile>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.25);

  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  late Animation<Color?> _iconColor;

  bool _isExpanded = false;
  toggle() {
    setState(() {
      _isExpanded = true;
      if (_isExpanded) {
        _controller.forward();
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged?.call(_isExpanded);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));

    _isExpanded = PageStorage.of(context)?.readState(context) as bool? ??
        widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged?.call(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xffEAEAEA), width: 1),
          boxShadow: [
            BoxShadow(
                color: const Color(0xff000000).withOpacity(0.1),
                blurRadius: 49,
                spreadRadius: -28,
                offset: const Offset(0, 27))
          ]),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTileTheme.merge(
            iconColor: _iconColor.value,
            child: ListTile(
              onTap: _handleTap,
              leading: widget.leadingIcon,
              title: Row(
                children: [
                  Flexible(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          fontFamily: Environment.fontFamily,
                          fontSize: 16,
                          fontWeight:
                              _isExpanded ? FontWeight.w500 : FontWeight.w400),
                    ),
                  ),
                  if (widget.onEdit != null && _isExpanded) ...[
                    const SizedBox(width: 16),
                    Material(
                      shape: const StadiumBorder(),
                      color: const Color(0xffDCE6FF),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: widget.onEdit,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                          child: Text(
                            S.of(context).edit,
                            style: const TextStyle(
                              color: Color(0xff2851BA),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (widget.onAdd != null && _isExpanded) ...[
                    const SizedBox(width: 16),
                    Material(
                      shape: const StadiumBorder(),
                      color: const Color(0xffDCE6FF),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: widget.onAdd,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                          child: Text(
                            "Add",
                            style: const TextStyle(
                              color: Color(0xff2851BA),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              trailing: widget.trailing ??
                  RotationTransition(
                    turns: _iconTurns,
                    child: const Icon(Icons.navigate_next),
                  ),
            ),
          ),
          ClipRect(
            child: Align(
              heightFactor: _heightFactor.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    color: Colors.grey,
                    endIndent: 16,
                    indent: 16,
                  ),
                  if (child != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: child,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    _iconColorTween
      ..begin = theme.unselectedWidgetColor
      ..end = theme.primaryColor;
    _backgroundColorTween.end = Colors.transparent;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed
          ? null
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.children),
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile(
      {Key? key,
      this.leadingIcon,
      required this.title,
      this.trailing,
      this.onTap})
      : super(key: key);

  final Widget? leadingIcon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: onTap,
        leading: leadingIcon,
        title: Text(
          title,
          style: const TextStyle(
              fontFamily: Environment.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
        trailing: trailing ?? const Icon(Icons.navigate_next),
      ),
    );
  }
}
