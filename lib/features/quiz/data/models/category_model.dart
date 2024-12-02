import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['title'],
    );
  }

  // covert QuestionModel to json

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
    };
  }
}
