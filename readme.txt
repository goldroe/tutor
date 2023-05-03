npm install

import tutor.sql to mysql workbench or xaamp, etc

npm run start

go to http://localhost:5000/


Directories:

Public contains images, css, and client scripts.
(images is also where uploads of profile pictures go).

Services contains mysql database object.

Server contains all the nodejs application code and routing.

Views is where all the pages live. Handlebars (hbs) is just templated HTML.
  Layouts is where the main layout of all pages.
  Partials is small hbs files that can be used by other hbs files.
  
tutor.sql contains all the mysql tables and rows.
