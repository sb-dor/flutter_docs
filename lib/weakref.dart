import 'package:flutter/cupertino.dart';

void main() {
  runApp(WeakRefApp());
}

/// Using a regular map would keep all [Placeholder] objects alive forever in the heap:
/// ```dart
/// final placeHolders = <String, Placeholder>{};
/// ```
///
/// Instead, we use [WeakReference] so that a [Placeholder] can be garbage collected
/// as soon as there are no strong references to it — making this suitable for caching.
///
/// See [_PlaceholderTile] which holds a strong reference to [Placeholder]
/// for as long as the tile is visible on screen.
final placeHolders = <String, WeakReference<Placeholder>>{};

class Placeholder {
  Placeholder({required this.name});

  final String name;
}

class WeakRefApp extends StatefulWidget {
  const WeakRefApp({super.key});

  @override
  State<WeakRefApp> createState() => _WeakRefAppState();
}

class _WeakRefAppState extends State<WeakRefApp> {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(home: WeakRefScreen());
  }
}

class WeakRefScreen extends StatefulWidget {
  const WeakRefScreen({super.key});

  @override
  State<WeakRefScreen> createState() => _WeakRefScreenState();
}

class _WeakRefScreenState extends State<WeakRefScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Contacts'),
            trailing: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => WeakRefCreationScreen()),
                );
              },
              child: Icon(CupertinoIcons.add_circled),
            ),
          ),
        ],
      ),
    );
  }
}

class WeakRefCreationScreen extends StatefulWidget {
  const WeakRefCreationScreen({super.key});

  @override
  State<WeakRefCreationScreen> createState() => _WeakRefCreationScreenState();
}

class _WeakRefCreationScreenState extends State<WeakRefCreationScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void add(final String name) {
    placeHolders[name] = WeakReference(Placeholder(name: name));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            previousPageTitle: 'Contacts',
            largeTitle: Text('Contacts Creation'),
            trailing: GestureDetector(
              onTap: () {
                final name = _nameController.text.trim();
                if (name.isEmpty) return;
                add(name);
                // Navigator.pop(context);
              },
              child: Icon(CupertinoIcons.check_mark_circled_solid),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 55,
              child: CupertinoTextField(
                controller: _nameController,
                placeholder: 'Name of placeholder',
              ),
            ),
          ),
          SliverList.builder(
            itemCount: placeHolders.length,
            itemBuilder: (context, index) {
              final placeholder = placeHolders.entries.elementAt(index).value.target;
              return _PlaceholderTile(placeholder: placeholder);
            },
          ),
        ],
      ),
    );
  }
}

class _PlaceholderTile extends StatefulWidget {
  const _PlaceholderTile({required this.placeholder});

  final Placeholder? placeholder;

  @override
  State<_PlaceholderTile> createState() => _PlaceholderTileState();
}

class _PlaceholderTileState extends State<_PlaceholderTile> {
  // strong reference
  // By doing this you will create strong reference and while you leave this page GC will clear weakReference
  Placeholder? _strongRef;

  @override
  void initState() {
    super.initState();
    // keep the object while it's alive
    _strongRef = widget.placeholder;
  }

  @override
  void dispose() {
    // GC now can delete this (not necessary to do this cause GC removes it anyway when there is no address/reference to this object)
    _strongRef = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(title: Text(_strongRef?.name ?? ''));
  }
}
