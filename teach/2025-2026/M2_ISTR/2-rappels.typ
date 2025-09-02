#import "../../../my-slides.typ": *

#set text(lang: "fr")


#show: doc => my-slides(
  doc,
  presentation_title: "Rappels",
  presentation_subtitle: "Université Toulouse Paul Sabatier - KEAT9AA1",
  date: "2025-09-01",
)

#section-slide("Hello World")

#laas-slide(title: "Hello world: C++")[
  ```cpp
  #include <iostream>

  auto main() -> int {
    std::cout << "hello\n";
    return 0;
  }
  ```
]

#laas-slide(title: "Hello world: C++, compilation")[
  ```
  $ g++ hello.cpp && ./a.out
  hello
  ```
]

#laas-slide(title: "Hello world: Python")[
  ```python
  #!/usr/bin/env python

  if __name__ == "__main__":
      print("hello")
  ```
]

#laas-slide(title: "Hello world: Python, execution")[
  ```
  $ chmod +x hello.py && ./hello.py
  hello
  ```
]

#laas-slide(title: "Types de données, C++")[
  ```cpp
  auto ga{3};                  // int
  auto bu{3.14};               // double
  const auto *const zo{"tau"}; // const char *const
  std::string meu{"pi"};
  ```
]

#laas-slide(title: "Types de données, Python")[
  ```python
  ga: int = 3
  bu: float = 3.14
  zo: str = "pi"
  ```
]

#section-slide("Contrôle du flot")

#laas-slide(title: "Functions, C++")[
  ```cpp
  auto add(int first, int second) -> int {
    return first + second;
  }
  ```
]

#laas-slide(title: "Functions, Python")[
  ```python
  def add(first: int, second: int) -> int:
      return first + second
  ```
]


#laas-slide(title: "Conditions: C++")[
  ```cpp
  if (temperature > 26) {
    std::cout << "Too hot\n";
    turn_cooler_on();
  } else if (temperature < 16) {
    std::cout << "Too cold\n";
    turn_heater_on();
  } else {
    std::cout << "Lucky people !\n";
  }
  ```
]

#laas-slide(title: "Conditions: Python")[
  ```python
  if temperature > 26:
      print("Too hot")
      turn_cooler_on()
  elif temperature < 16:
      print("Too cold")
      turn_heater_on()
  else:
      print("Lucky people !")
  ```
]

#laas-slide(title: "Boucles: while, C++")[
  ```cpp
  auto user_input{0};
  while (user_input != 42) {
    std::cout << "guess: ";
    std::cin >> user_input;
  }
  ```
]

#laas-slide(title: "Boucles: while, Python")[
  ```python
  user_input: int = 0
  while user_input != 42:
      user_input = int(input("guess: "))
  ```
]

#laas-slide(title: "Boucles: while, Python, :=")[
  ```python
  while (user_input := int(input("guess: "))) != 42:
      print("it's not", user_input)
  ```
]

#laas-slide(title: "Boucles: break - C++")[
  ```cpp
  auto user_input{0};
  while (true) {
    std::cout << "guess: ";
    std::cin >> user_input;
    if (user_input == 42) {
      std::cout << "Yes !" << "\n";
      break;
    }
    std::cout << "I's not " << user_input << "\n";
  }
  ```
]

#laas-slide(title: "Boucles: break - Python")[
  ```python
  user_input: int = 0
  while True:
      user_input = int(input("guess: "))
      if user_input == 42:
          print("Yes !")
          break
      print("It's not", user_input)
  ```
]

#laas-slide(title: "Boucles: for / break - C++")[
  ```cpp
  #include <cstdlib>

  for (auto i{0}; i < 10000; i++) {
    std::cout << "iteration " << i << "\n";
    auto rand = static_cast<double>(std::rand());
    if (rand / RAND_MAX > 0.95) {
      break;
    }
  }
  ```
]

#laas-slide(title: "Boucles: for / break - Python")[
  ```python
  from random import random

  for i in range(10000):
      print("iteration", i)
      if random() > 0.95:
          break
  ```
]

#laas-slide(title: "Boucles: continue, C++")[
  ```cpp
  for (auto i{0}; i < 10; i++) {
    if (i % 2 == 0) {
      continue;
    }
    std::cout << "iteration " << i << "\n";
  }
  ```
]

#laas-slide(title: "Boucles: continue, Python")[
  ```python
  for i in range(10):
      if i % 2 == 0:
          continue
      print("iteration", i)
  ```
]

#laas-slide(title: "Boucles: conteneurs, C++")[
  ```cpp
  using Colors = std::vector<std::string>;
  Colors colors{"orange", "blue", "pink"};
  for (const auto &color: colors) {
    std::cout << color << "\n";
  }
  ```
]

#laas-slide(title: "Boucles: conteneurs, Python")[
  ```python
  colors = ["orange", "blue", "pink"]
  for color in colors:
      print(color)
  ```
]

#section-slide("Objets")

#laas-slide(title: "C++")[
  #set text(size: 20pt)
  ```cpp
  class Robot {
  public:
    auto work() { battery -= 5; }
    auto get_battery() const -> int { return battery; }

  protected:
    int battery{100};
  };

  auto main() -> int {
    auto robot = Robot{};
    std::cout << robot.get_battery() << "% remaining\n";
    robot.work();
    std::cout << robot.get_battery() << "% remaining\n";
    return 0;
  }
  ```
]

#laas-slide(title: "Python")[
  #set text(size: 20pt)
  ```python
  class Robot:
      battery = 100

      def work(self):
          self.battery -= 5

      def get_battery(self) -> int:
          return self.battery


  if __name__ == "__main__":
      robot = Robot()
      print(robot.get_battery(), "% remaining")
      robot.work()
      print(robot.get_battery(), "% remaining")
  ```
]

#laas-slide(title: "Héritage: C++")[
  #set text(size: 20pt)
  ```cpp
  class LeggedRobot : public Robot {
  public:
    auto walk() { battery -= 10; }
  };

  auto main() -> int {
    auto robot = LeggedRobot{};
    std::cout << robot.get_battery() << "% remaining\n";
    robot.work();
    robot.walk();
    std::cout << robot.get_battery() << "% remaining\n";
    return 0;
  }
  ```
]

#laas-slide(title: "Héritage: Python")[
  #set text(size: 20pt)
  ```python
  class LeggedRobot(Robot):
      def walk(self):
          self.battery -= 10

  if __name__ == "__main__":
      robot = LeggedRobot()
      print(robot.get_battery(), "% remaining")
      robot.work()
      robot.walk()
      print(robot.get_battery(), "% remaining")
  ```
]

#laas-slide(title: "Constructeurs: C++")[
  #set text(size: 20pt)
  ```cpp
  class Robot {
  public:
    Robot() {}
    Robot(int bat) : battery{bat} {}
    auto work() { battery -= 5; }
    auto get_battery() const -> int { return battery; }

  protected:
    int battery{100};
  };

  auto main() -> int {
    auto robot = Robot{};
    auto bigRobot = Robot{350};
    return 0;
  ```
]

#laas-slide(title: "Constructeurs: Python")[
  #set text(size: 20pt)
  ```python
  class Robot:
      battery = 100

      def __init__(self, bat=100):
          self.battery = bat

      def work(self):
          self.battery -= 5

      def get_battery(self) -> int:
          return self.battery


  if __name__ == "__main__":
      robot = Robot()
      big_robot = Robot(350)
  ```
]

#laas-slide(title: "Destructeurs: C++")[
  ```cpp
  class Robot {
  public:
    Robot(int bat) : battery{bat} {}
    ~Robot() { std::cout << "Destruction at " << battery << "\n"; }
    auto work() { battery -= 5; }
    auto get_battery() const -> int { return battery; }

  protected:
    int battery{100};
  };
  ```
]

#laas-slide(title: "Destructeurs: Python")[
  Garbage collector
  ```
  __del__
  ```
]
