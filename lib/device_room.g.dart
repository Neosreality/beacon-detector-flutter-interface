// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_room.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetDeviceRoomCollection on Isar {
  IsarCollection<int, DeviceRoom> get deviceRooms => this.collection();
}

const DeviceRoomSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'DeviceRoom',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'name',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'macAddress',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'room',
        type: IsarType.string,
      ),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'macAddress',
        properties: [
          "macAddress",
        ],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, DeviceRoom>(
    serialize: serializeDeviceRoom,
    deserialize: deserializeDeviceRoom,
    deserializeProperty: deserializeDeviceRoomProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeDeviceRoom(IsarWriter writer, DeviceRoom object) {
  {
    final value = object.name;
    if (value == null) {
      IsarCore.writeNull(writer, 1);
    } else {
      IsarCore.writeString(writer, 1, value);
    }
  }
  IsarCore.writeString(writer, 2, object.macAddress);
  IsarCore.writeString(writer, 3, object.room);
  return object.id;
}

@isarProtected
DeviceRoom deserializeDeviceRoom(IsarReader reader) {
  final object = DeviceRoom();
  object.id = IsarCore.readId(reader);
  object.name = IsarCore.readString(reader, 1);
  object.macAddress = IsarCore.readString(reader, 2) ?? '';
  object.room = IsarCore.readString(reader, 3) ?? '';
  return object;
}

@isarProtected
dynamic deserializeDeviceRoomProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1);
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      return IsarCore.readString(reader, 3) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _DeviceRoomUpdate {
  bool call({
    required int id,
    String? name,
    String? macAddress,
    String? room,
  });
}

class _DeviceRoomUpdateImpl implements _DeviceRoomUpdate {
  const _DeviceRoomUpdateImpl(this.collection);

  final IsarCollection<int, DeviceRoom> collection;

  @override
  bool call({
    required int id,
    Object? name = ignore,
    Object? macAddress = ignore,
    Object? room = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (name != ignore) 1: name as String?,
          if (macAddress != ignore) 2: macAddress as String?,
          if (room != ignore) 3: room as String?,
        }) >
        0;
  }
}

sealed class _DeviceRoomUpdateAll {
  int call({
    required List<int> id,
    String? name,
    String? macAddress,
    String? room,
  });
}

class _DeviceRoomUpdateAllImpl implements _DeviceRoomUpdateAll {
  const _DeviceRoomUpdateAllImpl(this.collection);

  final IsarCollection<int, DeviceRoom> collection;

  @override
  int call({
    required List<int> id,
    Object? name = ignore,
    Object? macAddress = ignore,
    Object? room = ignore,
  }) {
    return collection.updateProperties(id, {
      if (name != ignore) 1: name as String?,
      if (macAddress != ignore) 2: macAddress as String?,
      if (room != ignore) 3: room as String?,
    });
  }
}

extension DeviceRoomUpdate on IsarCollection<int, DeviceRoom> {
  _DeviceRoomUpdate get update => _DeviceRoomUpdateImpl(this);

  _DeviceRoomUpdateAll get updateAll => _DeviceRoomUpdateAllImpl(this);
}

sealed class _DeviceRoomQueryUpdate {
  int call({
    String? name,
    String? macAddress,
    String? room,
  });
}

class _DeviceRoomQueryUpdateImpl implements _DeviceRoomQueryUpdate {
  const _DeviceRoomQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<DeviceRoom> query;
  final int? limit;

  @override
  int call({
    Object? name = ignore,
    Object? macAddress = ignore,
    Object? room = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (name != ignore) 1: name as String?,
      if (macAddress != ignore) 2: macAddress as String?,
      if (room != ignore) 3: room as String?,
    });
  }
}

extension DeviceRoomQueryUpdate on IsarQuery<DeviceRoom> {
  _DeviceRoomQueryUpdate get updateFirst =>
      _DeviceRoomQueryUpdateImpl(this, limit: 1);

  _DeviceRoomQueryUpdate get updateAll => _DeviceRoomQueryUpdateImpl(this);
}

class _DeviceRoomQueryBuilderUpdateImpl implements _DeviceRoomQueryUpdate {
  const _DeviceRoomQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<DeviceRoom, DeviceRoom, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? name = ignore,
    Object? macAddress = ignore,
    Object? room = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (name != ignore) 1: name as String?,
        if (macAddress != ignore) 2: macAddress as String?,
        if (room != ignore) 3: room as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension DeviceRoomQueryBuilderUpdate
    on QueryBuilder<DeviceRoom, DeviceRoom, QOperations> {
  _DeviceRoomQueryUpdate get updateFirst =>
      _DeviceRoomQueryBuilderUpdateImpl(this, limit: 1);

  _DeviceRoomQueryUpdate get updateAll =>
      _DeviceRoomQueryBuilderUpdateImpl(this);
}

extension DeviceRoomQueryFilter
    on QueryBuilder<DeviceRoom, DeviceRoom, QFilterCondition> {
  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition>
      idGreaterThanOrEqualTo(
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

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition>
      idLessThanOrEqualTo(
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

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> idBetween(
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

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 1));
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 1));
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition>
      nameGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition>
      nameLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> macAddressEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition>
      macAddressGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition>
      macAddressGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition>
      macAddressLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition>
      macAddressLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> macAddressBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition>
      macAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition>
      macAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition>
      macAddressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> macAddressMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 2,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition>
      macAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition>
      macAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> roomEqualTo(
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

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> roomGreaterThan(
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

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition>
      roomGreaterThanOrEqualTo(
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

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> roomLessThan(
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

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition>
      roomLessThanOrEqualTo(
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

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> roomBetween(
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

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> roomStartsWith(
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

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> roomEndsWith(
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

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> roomContains(
      String value,
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

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> roomMatches(
      String pattern,
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

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> roomIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterFilterCondition> roomIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }
}

extension DeviceRoomQueryObject
    on QueryBuilder<DeviceRoom, DeviceRoom, QFilterCondition> {}

extension DeviceRoomQuerySortBy
    on QueryBuilder<DeviceRoom, DeviceRoom, QSortBy> {
  QueryBuilder<DeviceRoom, DeviceRoom, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterSortBy> sortByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterSortBy> sortByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterSortBy> sortByMacAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterSortBy> sortByMacAddressDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterSortBy> sortByRoom(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterSortBy> sortByRoomDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension DeviceRoomQuerySortThenBy
    on QueryBuilder<DeviceRoom, DeviceRoom, QSortThenBy> {
  QueryBuilder<DeviceRoom, DeviceRoom, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterSortBy> thenByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterSortBy> thenByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterSortBy> thenByMacAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterSortBy> thenByMacAddressDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterSortBy> thenByRoom(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterSortBy> thenByRoomDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension DeviceRoomQueryWhereDistinct
    on QueryBuilder<DeviceRoom, DeviceRoom, QDistinct> {
  QueryBuilder<DeviceRoom, DeviceRoom, QAfterDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterDistinct> distinctByMacAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeviceRoom, DeviceRoom, QAfterDistinct> distinctByRoom(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }
}

extension DeviceRoomQueryProperty1
    on QueryBuilder<DeviceRoom, DeviceRoom, QProperty> {
  QueryBuilder<DeviceRoom, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<DeviceRoom, String?, QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<DeviceRoom, String, QAfterProperty> macAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<DeviceRoom, String, QAfterProperty> roomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension DeviceRoomQueryProperty2<R>
    on QueryBuilder<DeviceRoom, R, QAfterProperty> {
  QueryBuilder<DeviceRoom, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<DeviceRoom, (R, String?), QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<DeviceRoom, (R, String), QAfterProperty> macAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<DeviceRoom, (R, String), QAfterProperty> roomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension DeviceRoomQueryProperty3<R1, R2>
    on QueryBuilder<DeviceRoom, (R1, R2), QAfterProperty> {
  QueryBuilder<DeviceRoom, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<DeviceRoom, (R1, R2, String?), QOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<DeviceRoom, (R1, R2, String), QOperations> macAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<DeviceRoom, (R1, R2, String), QOperations> roomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}
