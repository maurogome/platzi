# Programacion Orientada a Objetos

POO Course: platzi.com/oop

Used lang: php, javascript, java, python

## Diagramas de Modelado

### OMT: Object Modeling Techniques
- Diagramas de clases y objetos

### UML: Unified Modelin Language
- Clases
- Casos de uso
- Objetos
- Actividades
- Iteracion
- Estados
- Implementacion
---
## Objetos
Son aquellos que tienen propiedades y comportomaientos. Pueden ser fisicos o conceptuales

## Propiedades
Tambien pueden llamarse atributos (seran sustantivos): nombre, tamano, forma, etc.

## Clase
Es el modelo sobre el cual se construira nuestro objeto.
- Las clases me permitiran generar mas objetos.

## Abstraccion
Es el analisis que hacemos sobre nuestros objetos para crear las clases

## Modularidad
Dividir un sistema para crear modulos independientes, evitando un colapso masivo en el codigo y mejorando la legibilidad.
---
# Definicion de Clases
### Java
```
class Person{}
```

### JavaScript
```
function Person(){}
```

### Python
```
class Person:
```

### PHP
```
class Person{}
```

## Difinicion de atributos y metodos 
- Atributo: Name
- Metodo: Walk

### Java
```
class Person{
	String name = "";
	void walk(){}
}
```

### JavaScript
```
Person.prototype.walk = funtion(){
}
```

### Python
```
class Person:
	name = ""
	def walk():
```

### PHP
```
class Person{
	$name = "";
	function walk(){}
}
```
---
# Herencia
DRY *Don't Repeat Yourself:*
- Promueve la reduccion de duplicacion en programacion
- Toda pieza de informacion **nunca deberia ser duplicada** debido a que la duplicacion **incrementa la dificultad** en los cambios y evolucion.

La herencia nos permite crear nuevas clases a partir de otras.
- Se establece una relacion **padre e hijo**
- La clase padre es conocida como la superclase
- Las clases hijas son las subclases.

Cuando detecto una relacion entre los elementos de diferentes objetos, puedo generar una abstraccion y crear una clase que contenga todos estos elementos.
---
## Declaracion de Objetos
Un objeto es una instancia de una clase

**Java**
```
Person person = new Person();
```

**JavaScript**
```
var person = new Person();
```

**Python**
```
person = Person()
```

**PHP**
```
$person = new Person();
```
---
# Metodo Constructor
- Da un estado inicial al objeto
- Tiene el mismo nombre de la clase
- Son los parametros minimos que necesita el objeto para que pueda vivir

**Java**
```
public Person(String name){
	this.name = name;
}
```

**JavaScript**
```
function Person(name){
	this.name = name
}
```

**Python**
```
def __init__(self, name):
	self.name = name
```

**PHP**
```
public function_construct($name){
	$this->name = name;
}
```
# Herencia
**Java**
```
class Student extends Person
```

**JavaScript**
```student.prototype = new Person();
```

**Python**
```
class Student(Person):
```

**PHP**
```
class Student extends Person
```
---
# Encapsulamiento
Para que un dato permanezca inviolable, inalterable, se le asigna un modificador de acceso

- public: Permite ser accedido por cualquier elemento.
- protected: Puede ser accedido por la clase, paquetes y subclases.
- default: Puede ser accedido por clases y paquetes.
- private: Puede ser accedido solo por clases.
---
# Polimorfismo
- Muchas Formas.
- Construir metodos con el mismo nombre pero con comportamiento diferente.

