import sys
import os
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))

import unittest
from nested_lookup import get_nested_value

class TestNestedLookup(unittest.TestCase):

    def test_valid_path(self):
        data = {"a": {"b": {"c": "d"}}}
        self.assertEqual(get_nested_value(data, "a/b/c"), "d")
        
    def test_valid_path(self):
        data = {"x": {"y": {"z": "a"}}}
        self.assertEqual(get_nested_value(data, "x/y/z"), "a")

    def test_missing_key(self):
        data = {"a": {"b": {"c": "value"}}}
        self.assertIsNone(get_nested_value(data, "a/b/x"))

    def test_non_dict_midway(self):
        data = {"a": {"b": "leaf"}}
        self.assertIsNone(get_nested_value(data, "a/b/c"))

    def test_empty_path(self):
        data = {"a": {"b": {"c": "value"}}}
        self.assertIsNone(get_nested_value(data, ""))

    def test_root_level_key(self):
        data = {"root": "base"}
        self.assertEqual(get_nested_value(data, "root"), "base")

    def test_invalid_root_type(self):
        data = ["not", "a", "dict"]
        self.assertIsNone(get_nested_value(data, "a/b"))

    def test_custom_separator(self):
        data = {"a": {"b": {"c": "x"}}}
        self.assertEqual(get_nested_value(data, "a|b|c", separator="|"), "x")

if __name__ == "__main__":
    unittest.main()
