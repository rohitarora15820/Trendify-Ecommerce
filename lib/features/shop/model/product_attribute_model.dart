class ProductAttributeModel{
  String? name;
  final List<String>? values;

  ProductAttributeModel({
    this.name,
    this.values,
  });

  Map<String, dynamic> toMap() {
    return {
      'Name': this.name,
      'Values': this.values,
    };
  }

  factory ProductAttributeModel.fromMap(Map<String, dynamic> map) {
    if(map.isEmpty) return ProductAttributeModel();
    return ProductAttributeModel(
      name:map.containsKey('Name')? map['Name'] :'',
      values:List<String>.from(map['Values']),
    );
  }
}