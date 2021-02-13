import 'dart:math' as math;

const denomination = 18;
final oneEGLD = BigInt.from(1000000000000000000);

class Balance {
  final BigInt value;

  Balance(this.value) : assert(value >= BigInt.zero, 'balance can\'t be negative');

  Balance.zero() : value = BigInt.from(0) * oneEGLD;

  factory Balance.fromString(String value) {
    return Balance(BigInt.parse(value));
  }

  factory Balance.fromEGLD(num value) {
    var v = value;
    var count = 0;
    while (v.truncate() != v) {
      v = v * 10;
      count++;
    }
    final bigGold = BigInt.from(v);
    final bigUnits = bigGold * (oneEGLD ~/ BigInt.from(math.pow(10, count)));
    final bigUnitsString = bigUnits.toString().padRight(denomination, '0');
    return Balance(BigInt.parse(bigUnitsString));
  }

  String toDenominated() {
    final padded = value.toString().padLeft(denomination, '0');
    final decimals = padded.substring(padded.length - denomination);
    final integer = padded.substring(0, padded.length - denomination).padLeft(1, '0');
    return '$integer.$decimals';
  }

  @override
  String toString() => value.toString();
}
