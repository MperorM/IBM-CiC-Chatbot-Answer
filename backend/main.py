from flask import jsonify
from fuzzywuzzy import process
import weather_forecast
import storage
import ast

BUCKETNAME = 'bewhaos.appspot.com'
KEYWORDSFILE = 'keywords.txt'

def receive_message(request):
    """Responds to any HTTP request.
    Args:
        request (flask.Request): HTTP request object.
    Returns:
        The response text in json format
    """

    # # list of keywords chatbot picks up and responds to
    # keywords = ['hammer', 'screwdriver', 'weather', 'goodbye', 'hello', 'hi', 'help']
        
    def check_for_keywords(message, keywords):
        """Checks for keywords
        Args:
            message: String
        Returns:
            closest keyword if one exists else None
        """

        # fuzzywuzzy uses Levenshtein distance to check for keywords in a string
        closest_match = process.extractOne(message, keywords, score_cutoff=80)
        if closest_match:
            return closest_match[0]
        else:
            return None

    def retrieve_keywords():
        """
        Queries google cloud storage for keyword/answer pairs
        Returns:
            list of (String, String) tuples with keyword/answer pairs for chatbot to use
        """
        keywordpair_string = storage.download_blob(BUCKETNAME, KEYWORDSFILE)
        keywordpair_list = ast.literal_eval(keywordpair_string)
        return keywordpair_list
    
    keywordpairs: str = retrieve_keywords()
    keywords = [i[0] for i in keywordpairs]
    
    if request.args and 'message' in request.args:
        message = request.args.get('message')

        keyword = check_for_keywords(message, keywords)
        if keyword:
            # find index of matched keyword and return corresponding message
            response = keywordpairs[keywords.index(keyword)][1]

            # special cases
            # TODO: find better way to get special case business logic out of this file
            if keyword == 'weather':
                # BUG: uuid: 6dde835c-75cc-11ea-af35-acde48001122
                # description: Weather is currently hardcoded to be returned for the night. Have it return the day/night depending on time of day
                response = f'the weather at our nearest store tonight is {weather_forecast.forecast(place="Copenhagen")["night"]["narrative"]}'
            elif keyword == 'help':
                response = f'I currently am trained to respond to the following keywords: {keywords}'
        else:
            response = 'I don\'t know how to answer that :('

        response = jsonify(response)

        # allow CORS for GET and POST requests
        response.headers.set('Access-Control-Allow-Origin', '*')
        response.headers.set('Access-Control-Allow-Methods', 'GET, POST')
        return response

def update_keywords(request):
    """Responds to any HTTP request.
    Args:
        request (flask.Request): HTTP request object.
    Returns:
        The response text in json format
    """
    if request.args and 'keyword' and 'message' in request.args:
        keyword = request.args.get('keyword')
        message = request.args.get('message')

        # download the current keyword list, or create one it if doesn't exist
        keywords_string = '[]'
        if storage.check_if_exists(BUCKETNAME, KEYWORDSFILE):
            keywords_string = storage.download_blob(BUCKETNAME, KEYWORDSFILE)

        # turn string into array and append the new keyword/message pair
        keywords_list = ast.literal_eval(keywords_string)
        keywords_list.append((keyword, message))

        # upload new array to storage
        storage.upload_blob(BUCKETNAME, str(keywords_list), KEYWORDSFILE)

        retval = jsonify('success')

        # allow CORS for GET and POST requests
        retval.headers.set('Access-Control-Allow-Origin', '*')
        retval.headers.set('Access-Control-Allow-Methods', 'GET, POST')

        return retval

    else:
        return 'failure - wrong arguments'