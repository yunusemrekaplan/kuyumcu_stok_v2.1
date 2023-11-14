import '../enum/log_state.dart';

extension ToString on LogState {
  String get stringDefinition {
    switch (this) {
      case LogState.openDatabase:
        return 'Open database';
      case LogState.addData:
        return 'Add data';
      case LogState.getData:
        return 'Get data';
      case LogState.getAllData:
        return 'Get all data';
      case LogState.updateData:
        return 'Update data';
      case LogState.deleteData:
        return 'Delete data';
      case LogState.getCurrenciesHakanAltin:
        return 'Get currencies of Hakan Altın';
      default:
        return 'Unknown state';
    }
  }
}
