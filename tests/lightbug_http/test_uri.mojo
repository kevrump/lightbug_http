from utils import StringSlice
import testing
from lightbug_http.uri import URI
from lightbug_http.strings import empty_string, to_string
from lightbug_http.io.bytes import Bytes


def test_uri_no_parse_defaults():
    var uri = URI.parse("http://example.com")
    testing.assert_equal(uri.full_uri, "http://example.com")
    testing.assert_equal(uri.scheme, "http")
    testing.assert_equal(uri.path, "/")


def test_uri_parse_http_with_port():
    var uri = URI.parse("http://example.com:8080/index.html")
    testing.assert_equal(uri.scheme, "http")
    testing.assert_equal(uri.host, "example.com")
    testing.assert_equal(uri.port.value(), 8080)
    testing.assert_equal(uri.path, "/index.html")
    testing.assert_equal(uri._original_path, "/index.html")
    testing.assert_equal(uri.request_uri, "/index.html")
    testing.assert_equal(uri.is_https(), False)
    testing.assert_equal(uri.is_http(), True)
    testing.assert_equal(uri.query_string, empty_string)


def test_uri_parse_https_with_port():
    var uri = URI.parse("https://example.com:8080/index.html")
    testing.assert_equal(uri.scheme, "https")
    testing.assert_equal(uri.host, "example.com")
    testing.assert_equal(uri.port.value(), 8080)
    testing.assert_equal(uri.path, "/index.html")
    testing.assert_equal(uri._original_path, "/index.html")
    testing.assert_equal(uri.request_uri, "/index.html")
    testing.assert_equal(uri.is_https(), True)
    testing.assert_equal(uri.is_http(), False)
    testing.assert_equal(uri.query_string, empty_string)


def test_uri_parse_http_with_path():
    var uri = URI.parse("http://example.com/index.html")
    testing.assert_equal(uri.scheme, "http")
    testing.assert_equal(uri.host, "example.com")
    testing.assert_equal(uri.path, "/index.html")
    testing.assert_equal(uri._original_path, "/index.html")
    testing.assert_equal(uri.request_uri, "/index.html")
    testing.assert_equal(uri.is_https(), False)
    testing.assert_equal(uri.is_http(), True)
    testing.assert_equal(uri.query_string, empty_string)


def test_uri_parse_https_with_path():
    var uri = URI.parse("https://example.com/index.html")
    testing.assert_equal(uri.scheme, "https")
    testing.assert_equal(uri.host, "example.com")
    testing.assert_equal(uri.path, "/index.html")
    testing.assert_equal(uri._original_path, "/index.html")
    testing.assert_equal(uri.request_uri, "/index.html")
    testing.assert_equal(uri.is_https(), True)
    testing.assert_equal(uri.is_http(), False)
    testing.assert_equal(uri.query_string, empty_string)


def test_uri_parse_http_basic():
    var uri = URI.parse("http://example.com")
    testing.assert_equal(uri.scheme, "http")
    testing.assert_equal(uri.host, "example.com")
    testing.assert_equal(uri.path, "/")
    testing.assert_equal(uri._original_path, "/")
    testing.assert_equal(uri.request_uri, "/")
    testing.assert_equal(uri.query_string, empty_string)


def test_uri_parse_http_basic_www():
    var uri = URI.parse("http://www.example.com")
    testing.assert_equal(uri.scheme, "http")
    testing.assert_equal(uri.host, "www.example.com")
    testing.assert_equal(uri.path, "/")
    testing.assert_equal(uri._original_path, "/")
    testing.assert_equal(uri.request_uri, "/")
    testing.assert_equal(uri.query_string, empty_string)


def test_uri_parse_http_with_query_string():
    var uri = URI.parse("http://www.example.com/job?title=engineer")
    testing.assert_equal(uri.scheme, "http")
    testing.assert_equal(uri.host, "www.example.com")
    testing.assert_equal(uri.path, "/job")
    testing.assert_equal(uri._original_path, "/job")
    testing.assert_equal(uri.request_uri, "/job?title=engineer")
    testing.assert_equal(uri.query_string, "title=engineer")


def test_uri_parse_no_scheme():
    var uri = URI.parse("www.example.com")
    testing.assert_equal(uri.scheme, "http")
    testing.assert_equal(uri.host, "www.example.com")


def test_uri_ip_address_no_scheme():
    var uri = URI.parse("168.22.0.1/path/to/favicon.ico")
    testing.assert_equal(uri.scheme, "http")
    testing.assert_equal(uri.host, "168.22.0.1")
    testing.assert_equal(uri.path, "/path/to/favicon.ico")


def test_uri_ip_address():
    var uri = URI.parse("http://168.22.0.1:8080/path/to/favicon.ico")
    testing.assert_equal(uri.scheme, "http")
    testing.assert_equal(uri.host, "168.22.0.1")
    testing.assert_equal(uri.path, "/path/to/favicon.ico")
    testing.assert_equal(uri.port.value(), 8080)


# def test_uri_parse_http_with_hash():
#     ...
