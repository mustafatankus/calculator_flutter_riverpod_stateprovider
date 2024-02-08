import 'package:calculator_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalculatorView extends ConsumerWidget {
  const CalculatorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theFirstNumber = ref.watch(theFirstNumberProvider);
    final theSecondNumber = ref.watch(theSecondNumberProvider);

    void sum() {
      if (ref.watch(theSecondNumberProvider.notifier).state == 0) {
        ref.read(theSecondNumberProvider.notifier).state =
            double.parse(ref.watch(theFirstNumberProvider.notifier).state);
        ref.read(theFirstNumberProvider.notifier).state = '0';
        ref.read(operatorProvider.notifier).state = '+';
      } else {
        ref.read(theSecondNumberProvider.notifier).state =
            double.parse(ref.watch(theFirstNumberProvider.notifier).state) +
                ref.watch(theSecondNumberProvider.notifier).state;
        ref.read(theFirstNumberProvider.notifier).state = '0';
        ref.read(operatorProvider.notifier).state = '+';
      }
    }

    void minus() {
      if (ref.watch(theSecondNumberProvider.notifier).state == 0) {
        ref.read(theSecondNumberProvider.notifier).state =
            double.parse(ref.watch(theFirstNumberProvider.notifier).state);
        ref.read(theFirstNumberProvider.notifier).state = '0';
        ref.read(operatorProvider.notifier).state = '-';
      } else {
        ref.read(theSecondNumberProvider.notifier).state =
            ref.watch(theSecondNumberProvider.notifier).state -
                double.parse(ref.watch(theFirstNumberProvider.notifier).state);
        ref.read(theFirstNumberProvider.notifier).state = '0';
        ref.read(operatorProvider.notifier).state = '+';
      }
    }

    void multiplication() {
      if (ref.watch(theFirstNumberProvider.notifier).state == '0') {
        ref.read(operatorProvider.notifier).state = '*';
      } else if (ref.watch(theSecondNumberProvider.notifier).state == 0) {
        ref.read(theSecondNumberProvider.notifier).state =
            double.parse(ref.watch(theFirstNumberProvider.notifier).state);
        ref.read(theFirstNumberProvider.notifier).state = '0';
        ref.read(operatorProvider.notifier).state = '*';
      } else {
        ref.read(theSecondNumberProvider.notifier).state =
            ref.watch(theSecondNumberProvider.notifier).state *
                double.parse(ref.watch(theFirstNumberProvider.notifier).state);
        ref.read(theFirstNumberProvider.notifier).state = '0';
        ref.read(operatorProvider.notifier).state = '*';
      }
    }

    void divison() {
      if (ref.watch(theFirstNumberProvider.notifier).state == '0') {
        ref.read(operatorProvider.notifier).state = '/';
      } else if (ref.watch(theSecondNumberProvider.notifier).state == 0) {
        ref.read(theSecondNumberProvider.notifier).state =
            double.parse(ref.watch(theFirstNumberProvider.notifier).state);
        ref.read(theFirstNumberProvider.notifier).state = '0';
        ref.read(operatorProvider.notifier).state = '/';
      } else {
        ref.read(theSecondNumberProvider.notifier).state =
            ref.watch(theSecondNumberProvider.notifier).state /
                double.parse(ref.watch(theFirstNumberProvider.notifier).state);
        ref.read(theFirstNumberProvider.notifier).state = '0';
        ref.read(operatorProvider.notifier).state = '/';
      }
    }

    void equal() {
      switch (ref.watch(operatorProvider.notifier).state) {
        case '+':
          ref.read(theSecondNumberProvider.notifier).state =
              double.parse(ref.watch(theFirstNumberProvider.notifier).state) +
                  ref.watch(theSecondNumberProvider.notifier).state;
          ref.read(theFirstNumberProvider.notifier).state = '0';
          break;
        case '-':
          ref.read(theSecondNumberProvider.notifier).state =
              double.parse(ref.watch(theFirstNumberProvider.notifier).state) -
                  ref.watch(theSecondNumberProvider.notifier).state;
          ref.read(theFirstNumberProvider.notifier).state = '0';
          break;
        case '*':
          ref.read(theSecondNumberProvider.notifier).state =
              double.parse(ref.watch(theFirstNumberProvider.notifier).state) *
                  ref.watch(theSecondNumberProvider.notifier).state;
          ref.read(theFirstNumberProvider.notifier).state = '0';
          break;
        case '/':
          ref.read(theSecondNumberProvider.notifier).state =
              double.parse(ref.watch(theFirstNumberProvider.notifier).state) /
                  ref.watch(theSecondNumberProvider.notifier).state;
          ref.read(theFirstNumberProvider.notifier).state = '0';
          break;
      }
    }

    void delete() {
      if (ref.watch(theFirstNumberProvider.notifier).state != '0' &&
          ref.watch(theFirstNumberProvider.notifier).state.isNotEmpty) {
        ref.read(theFirstNumberProvider.notifier).state = ref
            .watch(theFirstNumberProvider.notifier)
            .state
            .substring(
                0, ref.watch(theFirstNumberProvider.notifier).state.length - 1);
      }
      if (ref.watch(theFirstNumberProvider.notifier).state == '') {
        ref.read(theFirstNumberProvider.notifier).state = '0';
      }
    }

    void dot() {
      if (ref.watch(theFirstNumberProvider.notifier).state.contains('.')) {
      } else {
        ref.read(theFirstNumberProvider.notifier).state =
            ref.watch(theFirstNumberProvider.notifier).state + '.';
      }
    }

    void numberFunction(number) {
      if (ref.watch(theFirstNumberProvider.notifier).state == '0') {
        ref.read(theFirstNumberProvider.notifier).state = '${number}';
      } else {
        final value = ref.watch(theFirstNumberProvider.notifier).state;
        ref.read(theFirstNumberProvider.notifier).state =
            '${value}' + '${number}';
      }
    }

    void ac() {
      ref.read(theFirstNumberProvider.notifier).state = '0';
      ref.read(theSecondNumberProvider.notifier).state = 0;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  theFirstNumber,
                  style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  theSecondNumber.toString(),
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      color: Colors.white70),
                ),
                buildDivider(
                  1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildTextButton(
                      'AC',
                      () {
                        ac();
                      },
                      2,
                      Colors.white12,
                    ),
                   buildIconButton(
                    Icons.backspace,
                    delete,
                    1,
                   ),
                    buildTextButton(
                      '/',
                      () {
                        divison();
                      },
                      1,
                      Colors.orange,
                    ),
                  ],
                ),
                buildDivider(
                  1,
                ),
                Row(
                  children: [
                    buildTextButton(
                      '7',
                      () {
                        numberFunction(7);
                      },
                      1,
                      Colors.blueGrey,
                    ),
                    buildTextButton(
                      '8',
                      () {
                        numberFunction(8);
                      },
                      1,
                      Colors.blueGrey,
                    ),
                    buildTextButton(
                      '9',
                      () {
                        numberFunction(9);
                      },
                      1,
                      Colors.blueGrey,
                    ),
                    buildTextButton(
                      'x',
                      () {
                        multiplication();
                      },
                      1,
                      Colors.orange,
                    ),
                  ],
                ),
                buildDivider(
                  1,
                ),
                Row(
                  children: [
                    buildTextButton(
                      '4',
                      () {
                        numberFunction(4);
                      },
                      1,
                      Colors.blueGrey,
                    ),
                    buildTextButton(
                      '5',
                      () {
                        numberFunction(5);
                      },
                      1,
                      Colors.blueGrey,
                    ),
                    buildTextButton(
                      '6',
                      () {
                        numberFunction(6);
                      },
                      1,
                      Colors.blueGrey,
                    ),
                    buildTextButton(
                      '-',
                      () {
                        minus();
                      },
                      1,
                      Colors.orange,
                    ),
                  ],
                ),
                buildDivider(
                  1,
                ),
                Row(
                  children: [
                    buildTextButton(
                      '1',
                      () {
                        numberFunction(1);
                      },
                      1,
                      Colors.blueGrey,
                    ),
                    buildTextButton(
                      '2',
                      () {
                        numberFunction(2);
                      },
                      1,
                      Colors.blueGrey,
                    ),
                    buildTextButton(
                      '3',
                      () {
                        numberFunction(3);
                      },
                      1,
                      Colors.blueGrey,
                    ),
                    buildTextButton(
                      '+',
                      () {
                        sum();
                      },
                      1,
                      Colors.orange,
                    ),
                  ],
                ),
                buildDivider(
                  1,
                ),
                Row(
                  children: [
                    buildTextButton(
                      '0',
                      () {
                        numberFunction(0);
                      },
                      2,
                      Colors.blueGrey,
                    ),
                    buildTextButton(
                      '.',
                      () {
                        dot();
                      },
                      1,
                      Colors.white12,
                    ),
                    buildTextButton(
                      '=',
                      () {
                        equal();
                      },
                      1,
                      Colors.white12,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextButton(String textButtonText, VoidCallback onpressed,
      int flexValue, Color color) {
    return Expanded(
      flex: flexValue,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
        ),
        onPressed: onpressed,
        child: Text(
          textButtonText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  Widget buildDivider(double thickness) {
    return Divider(
      thickness: thickness,
    );
  }

  Widget buildIconButton(
    IconData icon,
    VoidCallback onpressed,
    int flexValue,
  ) {
    return Expanded(
      flex: flexValue,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white12, 
        ),
        onPressed: onpressed,
        child: Icon(
          icon,
          size: 32,
          color: Colors.white,
        ),
      ),
    );
  }
}


