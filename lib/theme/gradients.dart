import 'dart:ui';

class GradientValues {
  List<Gradient> _gradients = [

    Gradient(
      name: "Lush",
      from: Color(0xFF56ab2f),
      to: Color(0xFFa8e063),
    ),

    Gradient(
      name: "50 Shades of Grey",
      from: Color(0xFF2c3e50),
      to: Color(0xFFbdc3c7),
    ),
    Gradient(
      name: "Pale Wood",
      from: Color(0xFFd6ae7b),
      to: Color(0xFFeacda3),
    ),


  ];

  get gradients => _gradients;
}

class Gradient {
  Color _to;
  Color _from;
  String _name;

  get gradient => [_from, _to];

  get to => _to;

  get from => _from;

  get name => _name;

  Gradient({required String name, required Color from, required Color to})
      : _to = to,
        _from = from,
        _name = name;

  @override
  String toString() {
    return 'Gradient(name: $_name, to: $_from, from: $_to)';
  }
}
