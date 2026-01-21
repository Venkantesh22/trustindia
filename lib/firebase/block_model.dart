
class BlockModel {
    final String? id;
    final String? heading;
    final String? desc;
    final bool? isBlock;

    BlockModel({
        this.id,
        this.heading,
        this.desc,
        this.isBlock,
    });

    factory BlockModel.fromJson(Map<String, dynamic> json) => BlockModel(
        id: json["id"],
        heading: json["Heading"],
        desc: json["desc"],
        isBlock: json["isBlock"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "Heading": heading,
        "desc": desc,
        "isBlock": isBlock,
    };
}
