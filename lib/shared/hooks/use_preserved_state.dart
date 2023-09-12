import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ValueNotifier<T> usePreservedState<T>(
    [T? initialData, String? key, BuildContext? context]) {
  final state = useState<T>(PageStorage.of(context as BuildContext)
          .readState(context, identifier: key) ??
      initialData);

  useEffect(() {
    PageStorage.of(context).writeState(context, state.value, identifier: key);
    return null;
  }, [state.value]);

  return state;
}
