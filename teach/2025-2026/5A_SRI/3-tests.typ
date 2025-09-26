#import "../../../my-slides.typ": *

#set text(lang: "fr")

#show: doc => my-slides(
  doc,
  presentation_title: "Tests",
  presentation_subtitle: "UPSSITECH - KUPR9BC3",
  date: "2025-09-26",
)

#section-slide("Tests unitaires")

#laas-slide(title: "unittest: usage")[
```python
import unittest

class TestAddition(unittest.TestCase):
    def test_addition(self):
        self.assertEqual(1 + 1, 3)

if __name__ == '__main__':
    unittest.main()
```
]

#laas-slide(title: "unittest: test your code")[
```python
import unittest

from my_lib import my_add

class TestMyAddition(unittest.TestCase):
    def test_my_addition(self):
        self.assertEqual(my_add(1, 1), 2)

if __name__ == '__main__':
    unittest.main()
```
]

#laas-slide(title: "unittest: autodiscovery")[
```
$ python -m unittest -v
test_addition (test_add.TestAddition.test_addition) \
    ... ok
test_my_addition (test_my_add.TestMyAddition \
    .test_my_addition) ... ok

-----------------------------------------------
Ran 2 tests in 0.000s

OK
```
]

#section-slide("Tests des examples")

#laas-slide(title: "doctest: syntax")[
```python
def my_add(a: int, b: int) -> int:
    """Performs addition on integers.
    >>> my_add(3, 4)
    7
    """
    return a + b
```
]

#laas-slide(title: "doctest: usage")[
```
$ python -m doctest my_lib.py -v
Trying:
    my_add(3, 4)
Expecting:
    7
ok
1 items had no tests:
    my_lib
1 items passed all tests:
   1 tests in my_lib.my_add
1 tests in 2 items.
1 passed and 0 failed.
Test passed.
```
]

#section-slide("Tests intégratifs")

#laas-slide(title: "Concept")[
```python
import unittest

from my_robot import QuadrupedRobot

class TestMove(unittest.TestCase):
    def test_move(self):
        robot = QuadrupedRobot()
        robot.set_speed(1)  # m/s
        robot.simulate(10)  # s
        self.assertGreater(robot.get_z(), 0.1)
        self.assertGreater(robot.get_x(), 9)
```
]

#section-slide("Tierces parties")

#laas-slide(title: "Python")[
- pytest
- tox
- nose
]

#laas-slide(title: "C++")[
- Boost unit test framework
- Gtest
- catch2
- doctest
]

#section-slide("Intégration continue")

#laas-slide(title: "Github: .github/workflows/test.yml")[
```yaml
name: run unittests & doctests
on: ["push"]
jobs:
  test:
    runs-on: "ubuntu-latest"
    steps:
      - uses: actions/checkout@v5
      - uses: actions/setup-python@v6
        with:
          python-version: 3.13
      - run: python -m unittest
      - run: python -m doctest my_lib.py
```
]

#laas-slide(title: "Gitlab: .gitlab-ci.yml")[
```yaml
test:
  image: ubuntu:24.04
  script:
    - apt update && apt install -qy python3
    - python -m unittest
    - python -m doctest my_lib.py
```
]
