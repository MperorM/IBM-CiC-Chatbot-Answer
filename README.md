# IBM-CiC-Chatbot-Answer
Solution to the IBM Client innovation center interview question #3. It is written from scratch in < 24 hours, solely by me.

Chatbot user frontend: https://bewhaos.web.app

Chatbot admin frontend: https://bewhaos-admin.web.app

If you have any questions, I can be reached any time at:
+45 93 93 42 43

# Features
Ask Archibald's notable features are:
1. Picking up on sentiments through Levenshtein distance
2. The ability for an admin to add new sentiments, along with Archibald's response.
3. The ability to monitor from the backend page user queries that Archibald was unable to answer.
4. (expensively) scales to potentially millions of users

# Technology stack
## Frontend
Front-end is built using Flutter. I have previously done mobile development using the Flutter framework. They recently released a beta with support for building web-apps using flutter. I figured this exercise would be a good excuse to test it out. For a real project, React would be the better choice.
## Backend
The backend runs in Google Cloud. I am used to IBM Cloud, but Flutter has great libraries for Google cloud due to being developed by Google as well. As such google cloud seemed the best tool for the job.

It is written in python 3.7 using Google Cloud Functions, which more or less is a glorified flask-api. The great part about Cloud Functions is that it scales automatically. While I have placed limits on how far it can scale to spare my wallet. The current implementation automatically scales up and down depending on usage, with the potential to scale up very fast.
## Database
The database is two .txt files in Gcloud storage. Going forward a proper nosql or sql database would be a vast improvement. The current implementation will run into a myriad of scaling and concurrency issues. It has no upsides except ease of development.
## Bad-hacks FAQ

### Q: Why are there two flutter apps?
**A:** I had ran into issues with hosting a single-page app across multiple pages (I wonder why that could be). My hack-solution was to host two single-page apps on two very similar domains, communicating through a single backend!

### Q: Why not use proper database?
**A:** I tried implementing a cloud mysql db but ran into issues with not wanting to store cloud credentials on a public github page. This can probably be solved with a cloud key management service, but time was of the essence.
For what it's worth, this was my SQL table:
```
+---------+---------------+------+-----+---------+-------+
| Field   | Type          | Null | Key | Default | Extra |
+---------+---------------+------+-----+---------+-------+
| keyword | varchar(256)  | NO   | PRI | NULL    |       |
| message | varchar(1000) | NO   |     | NULL    |       |
+---------+---------------+------+-----+---------+-------+
```
### Q: Where are the unit tests?
Great question!
