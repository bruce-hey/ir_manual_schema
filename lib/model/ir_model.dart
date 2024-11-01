import "dart:convert";

class Module {
    final String? author;
    final double height;
    final String moduleId;
    final String? name;
    final List<Page> pages;
    final int slideCount;
    final String? title;
    final double width;

    Module({
        this.author,
        required this.height,
        required this.moduleId,
        this.name,
        required this.pages,
        required this.slideCount,
        this.title,
        required this.width,
    });

    factory Module.fromRawJson(String str) => Module.fromJson(json.decode(str));
    String toRawJson() => json.encode(toJson());

    factory Module.fromJson(Map<String, dynamic> json) => Module(
        author: json["author"],
        height: json["height"]?.toDouble(),
        moduleId: json["moduleId"],
        name: json["name"],
        pages: List<Page>.from(json["pages"].map((x) => Page.fromJson(x))),
        slideCount: json["slideCount"],
        title: json["title"],
        width: json["width"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "author": author,
        "height": height,
        "moduleId": moduleId,
        "name": name,
        "pages": List<dynamic>.from(pages.map((x) => x.toJson())),
        "slideCount": slideCount,
        "title": title,
        "width": width,
    };
}

class Page {
    final List<Component> components;
    final String slideId;

    Page({
        required this.components,
        required this.slideId,
    });

    factory Page.fromJson(Map<String, dynamic> json) => Page(
        components: json["components"] == null ? [] : List<Component>.from(json["components"]!.map((x) => Component.fromJson(x))),
        slideId: json["slideId"],
    );

    Map<String, dynamic> toJson() => {
        "components": List<dynamic>.from(components.map((x) => x.toJson())),
        "slideId": slideId,
    };

}

enum ComponentType {
    image,
    text
}

final componentTypeValues = EnumValues({
    "image": ComponentType.image,
    "text": ComponentType.text
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}

abstract class Component {
    final ComponentType componentType;
    final double height;
    final double width;
    final double x;
    final double y;

    Component({
        required this.componentType,
        required this.height,
        required this.width,
        required this.x,
        required this.y,
    });

    factory Component.fromJson(Map<String, dynamic> json) {
        var type = componentTypeValues.map[json["componentType"]];
        if (type == ComponentType.text) {
            return TextComponent.fromJson(json);
        } else {
            return ImageComponent.fromJson(json);
        }
    }

    Map<String, dynamic> toJson() {
        if (this is ImageComponent) {
          return (this as ImageComponent).toJson();
        } else {
          return (this as TextComponent).toJson();
        }
    }
}

class TextComponent extends Component {
    final String content;

    TextComponent(double x, double y, double height, double width, this.content):
        super(componentType: ComponentType.text, height: height, width: width, x: x, y: y);

    factory TextComponent.fromJson(Map<String, dynamic> json) => TextComponent(
        json["x"].toDouble(),
        json["y"].toDouble(),
        json["width"].toDouble(),
        json["height"].toDouble(),
        json["content"]);

    @override
    Map<String, dynamic> toJson() => {
        "componentType": componentTypeValues.reverse[ComponentType.text],
        "height": height,
        "width": width,
        "x": x,
        "y": y,
        "content": content,
    };
}

class ImageComponent extends Component {
    final String imageFile;

    ImageComponent(double x, double y, double height, double width, this.imageFile):
      super(componentType: ComponentType.image, height: height, width: width, x: x, y: y);

    factory ImageComponent.fromJson(Map<String, dynamic> json) => ImageComponent(
        json["x"],
        json["y"],
        json["width"],
        json["height"],
        json["imageFile"]);

    @override
    Map<String, dynamic> toJson() => {
        "componentType": componentTypeValues.reverse[ComponentType.image],
        "height": height,
        "width": width,
        "x": x,
        "y": y,
        "imageFile": imageFile,
    };
}
