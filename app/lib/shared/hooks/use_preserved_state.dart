import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ValueNotifier usePreservedState(
    [String? key, BuildContext? context, initialData]) {
  final state = useState(PageStorage.of(context as BuildContext)
          .readState(context, identifier: key) ??
      initialData);

  useEffect(() {
    PageStorage.of(context).writeState(context, state.value, identifier: key);
    return null;
  }, [state.value]);

  return state;
}
