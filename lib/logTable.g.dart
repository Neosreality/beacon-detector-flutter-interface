// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logTable.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetLogCollection on Isar {
  IsarCollection<int, Log> get logs => this.collection();
}

const LogSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'Log',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'timestamp',
        type: IsarType.dateTime,
      ),
      IsarPropertySchema(
        name: 'eventType',
        type: IsarType.byte,
        enumMap: {
          "warning": 0,
          "error": 1,
          "add": 2,
          "remove": 3,
          "update": 4,
          "enter": 5,
          "leave": 6,
          "detect": 7,
          "lost": 8
        },
      ),
      IsarPropertySchema(
        name: 'source',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'message',
        type: IsarType.string,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<int, Log>(
    serialize: serializeLog,
    deserialize: deserializeLog,
    deserializeProperty: deserializeLogProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeLog(IsarWriter writer, Log object) {
  IsarCore.writeLong(
      writer, 1, object.timestamp.toUtc().microsecondsSinceEpoch);
  IsarCore.writeByte(writer, 2, object.eventType.index);
  IsarCore.writeString(writer, 3, object.source);
  IsarCore.writeString(writer, 4, object.message);
  return object.id;
}

@isarProtected
Log deserializeLog(IsarReader reader) {
  final DateTime _timestamp;
  {
    final value = IsarCore.readLong(reader, 1);
    if (value == -9223372036854775808) {
      _timestamp =
          DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
    } else {
      _timestamp =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  final EventType _eventType;
  {
    if (IsarCore.readNull(reader, 2)) {
      _eventType = EventType.warning;
    } else {
      _eventType =
          _logEventType[IsarCore.readByte(reader, 2)] ?? EventType.warning;
    }
  }
  final String _source;
  _source = IsarCore.readString(reader, 3) ?? '';
  final String _message;
  _message = IsarCore.readString(reader, 4) ?? '';
  final object = Log(
    timestamp: _timestamp,
    eventType: _eventType,
    source: _source,
    message: _message,
  );
  object.id = IsarCore.readId(reader);
  return object;
}

@isarProtected
dynamic deserializeLogProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      {
        final value = IsarCore.readLong(reader, 1);
        if (value == -9223372036854775808) {
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true)
              .toLocal();
        }
      }
    case 2:
      {
        if (IsarCore.readNull(reader, 2)) {
          return EventType.warning;
        } else {
          return _logEventType[IsarCore.readByte(reader, 2)] ??
              EventType.warning;
        }
      }
    case 3:
      return IsarCore.readString(reader, 3) ?? '';
    case 4:
      return IsarCore.readString(reader, 4) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _LogUpdate {
  bool call({
    required int id,
    DateTime? timestamp,
    EventType? eventType,
    String? source,
    String? message,
  });
}

class _LogUpdateImpl implements _LogUpdate {
  const _LogUpdateImpl(this.collection);

  final IsarCollection<int, Log> collection;

  @override
  bool call({
    required int id,
    Object? timestamp = ignore,
    Object? eventType = ignore,
    Object? source = ignore,
    Object? message = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (timestamp != ignore) 1: timestamp as DateTime?,
          if (eventType != ignore) 2: eventType as EventType?,
          if (source != ignore) 3: source as String?,
          if (message != ignore) 4: message as String?,
        }) >
        0;
  }
}

sealed class _LogUpdateAll {
  int call({
    required List<int> id,
    DateTime? timestamp,
    EventType? eventType,
    String? source,
    String? message,
  });
}

class _LogUpdateAllImpl implements _LogUpdateAll {
  const _LogUpdateAllImpl(this.collection);

  final IsarCollection<int, Log> collection;

  @override
  int call({
    required List<int> id,
    Object? timestamp = ignore,
    Object? eventType = ignore,
    Object? source = ignore,
    Object? message = ignore,
  }) {
    return collection.updateProperties(id, {
      if (timestamp != ignore) 1: timestamp as DateTime?,
      if (eventType != ignore) 2: eventType as EventType?,
      if (source != ignore) 3: source as String?,
      if (message != ignore) 4: message as String?,
    });
  }
}

extension LogUpdate on IsarCollection<int, Log> {
  _LogUpdate get update => _LogUpdateImpl(this);

  _LogUpdateAll get updateAll => _LogUpdateAllImpl(this);
}

sealed class _LogQueryUpdate {
  int call({
    DateTime? timestamp,
    EventType? eventType,
    String? source,
    String? message,
  });
}

class _LogQueryUpdateImpl implements _LogQueryUpdate {
  const _LogQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<Log> query;
  final int? limit;

  @override
  int call({
    Object? timestamp = ignore,
    Object? eventType = ignore,
    Object? source = ignore,
    Object? message = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (timestamp != ignore) 1: timestamp as DateTime?,
      if (eventType != ignore) 2: eventType as EventType?,
      if (source != ignore) 3: source as String?,
      if (message != ignore) 4: message as String?,
    });
  }
}

extension LogQueryUpdate on IsarQuery<Log> {
  _LogQueryUpdate get updateFirst => _LogQueryUpdateImpl(this, limit: 1);

  _LogQueryUpdate get updateAll => _LogQueryUpdateImpl(this);
}

class _LogQueryBuilderUpdateImpl implements _LogQueryUpdate {
  const _LogQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<Log, Log, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? timestamp = ignore,
    Object? eventType = ignore,
    Object? source = ignore,
    Object? message = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (timestamp != ignore) 1: timestamp as DateTime?,
        if (eventType != ignore) 2: eventType as EventType?,
        if (source != ignore) 3: source as String?,
        if (message != ignore) 4: message as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension LogQueryBuilderUpdate on QueryBuilder<Log, Log, QOperations> {
  _LogQueryUpdate get updateFirst => _LogQueryBuilderUpdateImpl(this, limit: 1);

  _LogQueryUpdate get updateAll => _LogQueryBuilderUpdateImpl(this);
}

const _logEventType = {
  0: EventType.warning,
  1: EventType.error,
  2: EventType.add,
  3: EventType.remove,
  4: EventType.update,
  5: EventType.enter,
  6: EventType.leave,
  7: EventType.detect,
  8: EventType.lost,
};

extension LogQueryFilter on QueryBuilder<Log, Log, QFilterCondition> {
  QueryBuilder<Log, Log, QAfterFilterCondition> idEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> idGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> idGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> idLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> idLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> idBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 0,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> timestampEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> timestampGreaterThan(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> timestampGreaterThanOrEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> timestampLessThan(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> timestampLessThanOrEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> timestampBetween(
    DateTime lower,
    DateTime upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> eventTypeEqualTo(
    EventType value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> eventTypeGreaterThan(
    EventType value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> eventTypeGreaterThanOrEqualTo(
    EventType value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> eventTypeLessThan(
    EventType value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> eventTypeLessThanOrEqualTo(
    EventType value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> eventTypeBetween(
    EventType lower,
    EventType upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower.index,
          upper: upper.index,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> sourceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> sourceGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> sourceGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> sourceLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> sourceLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> sourceBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> sourceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> sourceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> sourceContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> sourceMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 3,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> sourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> sourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> messageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> messageGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> messageGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> messageLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> messageLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> messageBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> messageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> messageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> messageContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> messageMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 4,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> messageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> messageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }
}

extension LogQueryObject on QueryBuilder<Log, Log, QFilterCondition> {}

extension LogQuerySortBy on QueryBuilder<Log, Log, QSortBy> {
  QueryBuilder<Log, Log, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1);
    });
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc);
    });
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortByEventType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortByEventTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortBySource(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortBySourceDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortByMessage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortByMessageDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension LogQuerySortThenBy on QueryBuilder<Log, Log, QSortThenBy> {
  QueryBuilder<Log, Log, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1);
    });
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc);
    });
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenByEventType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenByEventTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenBySource(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenBySourceDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenByMessage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenByMessageDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension LogQueryWhereDistinct on QueryBuilder<Log, Log, QDistinct> {
  QueryBuilder<Log, Log, QAfterDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1);
    });
  }

  QueryBuilder<Log, Log, QAfterDistinct> distinctByEventType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2);
    });
  }

  QueryBuilder<Log, Log, QAfterDistinct> distinctBySource(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Log, Log, QAfterDistinct> distinctByMessage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }
}

extension LogQueryProperty1 on QueryBuilder<Log, Log, QProperty> {
  QueryBuilder<Log, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Log, DateTime, QAfterProperty> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Log, EventType, QAfterProperty> eventTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Log, String, QAfterProperty> sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<Log, String, QAfterProperty> messageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension LogQueryProperty2<R> on QueryBuilder<Log, R, QAfterProperty> {
  QueryBuilder<Log, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Log, (R, DateTime), QAfterProperty> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Log, (R, EventType), QAfterProperty> eventTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Log, (R, String), QAfterProperty> sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<Log, (R, String), QAfterProperty> messageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension LogQueryProperty3<R1, R2>
    on QueryBuilder<Log, (R1, R2), QAfterProperty> {
  QueryBuilder<Log, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Log, (R1, R2, DateTime), QOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Log, (R1, R2, EventType), QOperations> eventTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Log, (R1, R2, String), QOperations> sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<Log, (R1, R2, String), QOperations> messageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}
