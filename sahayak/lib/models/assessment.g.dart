// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAssessmentCollection on Isar {
  IsarCollection<Assessment> get assessments => this.collection();
}

const AssessmentSchema = CollectionSchema(
  name: r'Assessment',
  id: -7365692047566751431,
  properties: {
    r'assessmentDate': PropertySchema(
      id: 0,
      name: r'assessmentDate',
      type: IsarType.dateTime,
    ),
    r'calculatedLevel': PropertySchema(
      id: 1,
      name: r'calculatedLevel',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'mathLevel': PropertySchema(
      id: 3,
      name: r'mathLevel',
      type: IsarType.string,
    ),
    r'mathScore': PropertySchema(
      id: 4,
      name: r'mathScore',
      type: IsarType.long,
    ),
    r'notes': PropertySchema(
      id: 5,
      name: r'notes',
      type: IsarType.string,
    ),
    r'readingLevel': PropertySchema(
      id: 6,
      name: r'readingLevel',
      type: IsarType.string,
    ),
    r'readingScore': PropertySchema(
      id: 7,
      name: r'readingScore',
      type: IsarType.long,
    ),
    r'studentId': PropertySchema(
      id: 8,
      name: r'studentId',
      type: IsarType.long,
    )
  },
  estimateSize: _assessmentEstimateSize,
  serialize: _assessmentSerialize,
  deserialize: _assessmentDeserialize,
  deserializeProp: _assessmentDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _assessmentGetId,
  getLinks: _assessmentGetLinks,
  attach: _assessmentAttach,
  version: '3.1.0+1',
);

int _assessmentEstimateSize(
  Assessment object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.calculatedLevel;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.mathLevel;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.readingLevel;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _assessmentSerialize(
  Assessment object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.assessmentDate);
  writer.writeString(offsets[1], object.calculatedLevel);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.mathLevel);
  writer.writeLong(offsets[4], object.mathScore);
  writer.writeString(offsets[5], object.notes);
  writer.writeString(offsets[6], object.readingLevel);
  writer.writeLong(offsets[7], object.readingScore);
  writer.writeLong(offsets[8], object.studentId);
}

Assessment _assessmentDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Assessment();
  object.assessmentDate = reader.readDateTime(offsets[0]);
  object.calculatedLevel = reader.readStringOrNull(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.id = id;
  object.mathLevel = reader.readStringOrNull(offsets[3]);
  object.mathScore = reader.readLongOrNull(offsets[4]);
  object.notes = reader.readStringOrNull(offsets[5]);
  object.readingLevel = reader.readStringOrNull(offsets[6]);
  object.readingScore = reader.readLongOrNull(offsets[7]);
  object.studentId = reader.readLong(offsets[8]);
  return object;
}

P _assessmentDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _assessmentGetId(Assessment object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _assessmentGetLinks(Assessment object) {
  return [];
}

void _assessmentAttach(IsarCollection<dynamic> col, Id id, Assessment object) {
  object.id = id;
}

extension AssessmentQueryWhereSort
    on QueryBuilder<Assessment, Assessment, QWhere> {
  QueryBuilder<Assessment, Assessment, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AssessmentQueryWhere
    on QueryBuilder<Assessment, Assessment, QWhereClause> {
  QueryBuilder<Assessment, Assessment, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AssessmentQueryFilter
    on QueryBuilder<Assessment, Assessment, QFilterCondition> {
  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      assessmentDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assessmentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      assessmentDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'assessmentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      assessmentDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'assessmentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      assessmentDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'assessmentDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      calculatedLevelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'calculatedLevel',
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      calculatedLevelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'calculatedLevel',
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      calculatedLevelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'calculatedLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      calculatedLevelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'calculatedLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      calculatedLevelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'calculatedLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      calculatedLevelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'calculatedLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      calculatedLevelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'calculatedLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      calculatedLevelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'calculatedLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      calculatedLevelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'calculatedLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      calculatedLevelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'calculatedLevel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      calculatedLevelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'calculatedLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      calculatedLevelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'calculatedLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      mathLevelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mathLevel',
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      mathLevelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mathLevel',
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> mathLevelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mathLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      mathLevelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mathLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> mathLevelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mathLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> mathLevelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mathLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      mathLevelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mathLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> mathLevelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mathLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> mathLevelContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mathLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> mathLevelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mathLevel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      mathLevelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mathLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      mathLevelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mathLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      mathScoreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mathScore',
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      mathScoreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mathScore',
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> mathScoreEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mathScore',
        value: value,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      mathScoreGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mathScore',
        value: value,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> mathScoreLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mathScore',
        value: value,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> mathScoreBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mathScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> notesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> notesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      readingLevelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'readingLevel',
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      readingLevelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'readingLevel',
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      readingLevelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'readingLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      readingLevelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'readingLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      readingLevelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'readingLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      readingLevelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'readingLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      readingLevelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'readingLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      readingLevelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'readingLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      readingLevelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'readingLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      readingLevelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'readingLevel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      readingLevelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'readingLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      readingLevelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'readingLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      readingScoreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'readingScore',
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      readingScoreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'readingScore',
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      readingScoreEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'readingScore',
        value: value,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      readingScoreGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'readingScore',
        value: value,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      readingScoreLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'readingScore',
        value: value,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      readingScoreBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'readingScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> studentIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'studentId',
        value: value,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition>
      studentIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'studentId',
        value: value,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> studentIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'studentId',
        value: value,
      ));
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterFilterCondition> studentIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'studentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AssessmentQueryObject
    on QueryBuilder<Assessment, Assessment, QFilterCondition> {}

extension AssessmentQueryLinks
    on QueryBuilder<Assessment, Assessment, QFilterCondition> {}

extension AssessmentQuerySortBy
    on QueryBuilder<Assessment, Assessment, QSortBy> {
  QueryBuilder<Assessment, Assessment, QAfterSortBy> sortByAssessmentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assessmentDate', Sort.asc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy>
      sortByAssessmentDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assessmentDate', Sort.desc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> sortByCalculatedLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calculatedLevel', Sort.asc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy>
      sortByCalculatedLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calculatedLevel', Sort.desc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> sortByMathLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mathLevel', Sort.asc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> sortByMathLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mathLevel', Sort.desc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> sortByMathScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mathScore', Sort.asc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> sortByMathScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mathScore', Sort.desc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> sortByReadingLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readingLevel', Sort.asc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> sortByReadingLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readingLevel', Sort.desc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> sortByReadingScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readingScore', Sort.asc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> sortByReadingScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readingScore', Sort.desc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> sortByStudentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studentId', Sort.asc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> sortByStudentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studentId', Sort.desc);
    });
  }
}

extension AssessmentQuerySortThenBy
    on QueryBuilder<Assessment, Assessment, QSortThenBy> {
  QueryBuilder<Assessment, Assessment, QAfterSortBy> thenByAssessmentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assessmentDate', Sort.asc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy>
      thenByAssessmentDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assessmentDate', Sort.desc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> thenByCalculatedLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calculatedLevel', Sort.asc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy>
      thenByCalculatedLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calculatedLevel', Sort.desc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> thenByMathLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mathLevel', Sort.asc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> thenByMathLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mathLevel', Sort.desc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> thenByMathScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mathScore', Sort.asc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> thenByMathScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mathScore', Sort.desc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> thenByReadingLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readingLevel', Sort.asc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> thenByReadingLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readingLevel', Sort.desc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> thenByReadingScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readingScore', Sort.asc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> thenByReadingScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readingScore', Sort.desc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> thenByStudentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studentId', Sort.asc);
    });
  }

  QueryBuilder<Assessment, Assessment, QAfterSortBy> thenByStudentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studentId', Sort.desc);
    });
  }
}

extension AssessmentQueryWhereDistinct
    on QueryBuilder<Assessment, Assessment, QDistinct> {
  QueryBuilder<Assessment, Assessment, QDistinct> distinctByAssessmentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'assessmentDate');
    });
  }

  QueryBuilder<Assessment, Assessment, QDistinct> distinctByCalculatedLevel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calculatedLevel',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Assessment, Assessment, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Assessment, Assessment, QDistinct> distinctByMathLevel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mathLevel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Assessment, Assessment, QDistinct> distinctByMathScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mathScore');
    });
  }

  QueryBuilder<Assessment, Assessment, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Assessment, Assessment, QDistinct> distinctByReadingLevel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'readingLevel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Assessment, Assessment, QDistinct> distinctByReadingScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'readingScore');
    });
  }

  QueryBuilder<Assessment, Assessment, QDistinct> distinctByStudentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'studentId');
    });
  }
}

extension AssessmentQueryProperty
    on QueryBuilder<Assessment, Assessment, QQueryProperty> {
  QueryBuilder<Assessment, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Assessment, DateTime, QQueryOperations>
      assessmentDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'assessmentDate');
    });
  }

  QueryBuilder<Assessment, String?, QQueryOperations>
      calculatedLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calculatedLevel');
    });
  }

  QueryBuilder<Assessment, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Assessment, String?, QQueryOperations> mathLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mathLevel');
    });
  }

  QueryBuilder<Assessment, int?, QQueryOperations> mathScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mathScore');
    });
  }

  QueryBuilder<Assessment, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<Assessment, String?, QQueryOperations> readingLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'readingLevel');
    });
  }

  QueryBuilder<Assessment, int?, QQueryOperations> readingScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'readingScore');
    });
  }

  QueryBuilder<Assessment, int, QQueryOperations> studentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'studentId');
    });
  }
}
