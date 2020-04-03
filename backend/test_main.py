from unittest.mock import Mock
import main
import flask

#     BUG: uuid: 7ec99102-75cc-11ea-af35-acde48001122
#     description: getting weird error when running testsuite, something to do with not mocking flask correctly causing flask.jsonify to fail.
def test_hammer():
    message = 'hammer'
    data = {'message': message}
    req = Mock(get_json=Mock(return_value=data), args=data)

    # Call tested function
    assert main.receive_message(req) == "this is not the expected output test should fail"