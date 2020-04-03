from flask import jsonify
from fuzzywuzzy import process

def receive_message(request):
    """Responds to any HTTP request.
    Args:
        request (flask.Request): HTTP request object.
    Returns:
        The response text in json format
    """

    def check_for_keywords(message):
        """Checks for keywords
        Args:
            message: String
        Returns:
            closest keyword if one exists else None
        """

        keywords = ['hammer', 'motorsav']
        
        # fuzzywuzzy uses Levenshtein distance to check for keywords in a string
        closest_match = process.extractOne(message, keywords, score_cutoff=70)
        if closest_match:
            return closest_match[0]
        else:
            return None

    
    if request.args and 'message' in request.args:
        message = request.args.get('message')
        keyword = check_for_keywords(message)
        if keyword:
            #TODO: this business logic should reside elsewhere
            if keyword == 'hammer':
                response = "Her kan du finde vores konkurrents bedste hamre: https://www.bauhaus.dk/catalogsearch/result/?q=hammer"
            elif keyword == 'motorsav':
                response = "vi har desværre ingen motorsave til salg :("
        else:
            response = "Det kan jeg desværre ikke svare på :("

        response = jsonify(response)

        # allow CORS for GET and POST requests
        response.headers.set('Access-Control-Allow-Origin', '*')
        response.headers.set('Access-Control-Allow-Methods', 'GET, POST')
        return response