import "model/ir_model.dart";

Module createModule() {
  TextComponent textComponent = TextComponent(0,0,0,0,'my text');
  ImageComponent imageCompoonent = ImageComponent(10,10,10,10,'foo.jpg');
  List<Component> components = [textComponent, imageCompoonent];
  Page page = Page(components: components, slideId: "slide001");
  List<Page> pages = [page];
  return Module(
      height: 100,
      moduleId: 'module01',
      pages: pages,
      slideCount: 1,
      width: 200,
      name: 'fred',
      title: 'a title',
      author: 'Chester Alan Author');
}

void main() {
  Module m = createModule();
  var jsonStr = m.toRawJson();
  print('from module: $jsonStr');

  Module m2 = Module.fromRawJson(jsonStr);
  print('to module: $m2');
}
