// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_package.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class RealmPackage extends _RealmPackage
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmPackage(
    String name,
    String version,
    String link,
  ) {
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
    RealmObjectBase.set(this, 'link', link);
  }

  RealmPackage._();

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get version => RealmObjectBase.get<String>(this, 'version') as String;
  @override
  set version(String value) => RealmObjectBase.set(this, 'version', value);

  @override
  String get link => RealmObjectBase.get<String>(this, 'link') as String;
  @override
  set link(String value) => RealmObjectBase.set(this, 'link', value);

  @override
  Stream<RealmObjectChanges<RealmPackage>> get changes =>
      RealmObjectBase.getChanges<RealmPackage>(this);

  @override
  RealmPackage freeze() => RealmObjectBase.freezeObject<RealmPackage>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'name': name.toEJson(),
      'version': version.toEJson(),
      'link': link.toEJson(),
    };
  }

  static EJsonValue _toEJson(RealmPackage value) => value.toEJson();
  static RealmPackage _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'name': EJsonValue name,
        'version': EJsonValue version,
        'link': EJsonValue link,
      } =>
        RealmPackage(
          fromEJson(name),
          fromEJson(version),
          fromEJson(link),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RealmPackage._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, RealmPackage, 'RealmPackage', [
      SchemaProperty('name', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('version', RealmPropertyType.string),
      SchemaProperty('link', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
