/// Base class for all data classes
abstract class AbstractBase {
  /// Unique identifier of the object.
  late final String _id;

  /// Date and time of creation of the object.
  late final DateTime _createdAt;

  /// Date and time of the last update of the object.
  DateTime? _updatedAt;

  /// Date and time of deletion of the object.
  DateTime? _deletedAt;

  /// Whether the object is deleted or not.
  int _isDeleted = 0;

  String get id => _id;

  DateTime get createdAt => _createdAt;

  DateTime? get updatedAt => _updatedAt;

  DateTime? get deletedAt => _deletedAt;

  int get isDeleted => _isDeleted;

  AbstractBase({
    required String id,
    required DateTime createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  })  : _id = id,
        _createdAt = DateTime.now(),
        _updatedAt = updatedAt ?? DateTime.now(),
        _deletedAt = deletedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'createdAt': _createdAt.toIso8601String(),
      'updatedAt': _updatedAt?.toIso8601String(),
      'deletedAt': _deletedAt?.toIso8601String(),
      'isDeleted': _isDeleted,
    };
  }

  AbstractBase.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _createdAt = DateTime.parse(map['createdAt']);
    _updatedAt =
        map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null;
    _deletedAt =
        map['deletedAt'] != null ? DateTime.parse(map['deletedAt']) : null;
    _isDeleted = map['isDeleted'];
  }

  @override
  String toString() {
    return 'AbstractBase{id: $_id, createdAt: $_createdAt, updatedAt: $_updatedAt, deletedAt: $_deletedAt, isDeleted: $_isDeleted}';
  }
}
