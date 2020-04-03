# IBM-CiC-Chatbot-Answer
Solution to the IBM Client innovation center interview question #3

Chatbot user frontend: https://bewhaos.web.app

Chatbot admin frontend: https://bewhaos-admin.web.app

If you have any questions, I can be reached any time at:
+45 93 93 42 43

# Technology stack
## Frontend
Front-end is built using Flutter. I have previously done mobile development using the Flutter framework. They recently released a beta with support for building web-apps using flutter. I figured this exercise would be a good excuse to test it out. For a real project, React would be the better choice.
## Backend
The backend runs in Google Cloud. I am used to IBM Cloud, but Flutter has great libraries for Google cloud due to being developed by Google. As such google cloud is the best tool for the job.

It is written in python using Google Cloud Functions, which s more or less a glorified flask-api.
## Database
For now the database is a set of .txt files in cloud storage. Going forward a proper nosql or sql database would be the clear choice. I tried implementing a cloud mysql db but ran into issues with not wanting to store cloud credentials on a public github page. This can probably be solved with a cloud key management service, but time is of the essence.
For what it's worth, this was my SQL table:
```
+---------+---------------+------+-----+---------+-------+
| Field   | Type          | Null | Key | Default | Extra |
+---------+---------------+------+-----+---------+-------+
| keyword | varchar(256)  | NO   | PRI | NULL    |       |
| message | varchar(1000) | NO   |     | NULL    |       |
+---------+---------------+------+-----+---------+-------+
```
## Bad-hacks FAQ
### Q: Why not use a pre-made chatbot?
Using a prebuilt chatbot such as IBM Watson would get better results faster. My reasoning for building my own from scratch is to showcase my 1337 skills.
### Q: Why are there two flutter apps?
I had hosting a single page app across multiple pages (I wonder why that could be). My hack-solution was to host two single page apps on two very similar domains!