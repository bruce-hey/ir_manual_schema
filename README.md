# ir\_manual\_schema
## Luna IR Native Data Objects

Uses only native Dart libraries to construct immutable data objects. The "schema" is implicit in the way those objects are created and serialized.

Data object classes are defined in [schema](./lib/model/ir_model.dart). One interesting difference between this model and the schema-generated models is that it allows true inheritence; note the differences in the Component model. I'm not sure this is the right way to go since there is a bit more overhead and runtime type inference needed to serialize/deserialize those objects but it seems a bit cleaner from an OO standpoint. I'm sure this code can be improved.

In any case, the [parser](./lib/parser.dart) is very simple code:

```
$ dart run lib/parser.dart
from module: {"author":"Chester Alan Author","height":100.0,"moduleId":"module01","name":"fred","pages":[{"components":[{"componentType":"text","height":0.0,"width":0.0,"x":0.0,"y":0.0,"content":"my text"},{"componentType":"image","height":10.0,"width":10.0,"x":10.0,"y":10.0,"imageFile":"foo.jpg"}],"slideId":"slide001"}],"slideCount":1,"title":"a title","width":200.0}
to module: Instance of 'Module'
```