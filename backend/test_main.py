from unittest.mock import Mock
import main
import flask

#TODO: getting weird error when running testsuite, something to do with not mocking flask correctly causing flask.jsonify to fail.
def test_hammer():
    message = 'hammer'
    data = {'message': message}
    req = Mock(get_json=Mock(return_value=data), args=data)

    # Call tested function
    assert main.receive_message(req) == "Her kan du finde vores konkurrents bedste hamre: https://www.bauhaus.dk/catalogsearch/result/?q=hammer"