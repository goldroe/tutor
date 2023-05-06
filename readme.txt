Run 'npm install' while in the main directory to install the dependencies.

Import tutor.sql into a mysql client like Xaamp or MySQL Workbench.
Importing the sql file into XAAMP works certainly, MySQL Workbench may not work based on the version used.

Run your choice of MySQL client and make sure the connection is up.

Run 'npm run start' to start the application.

Go to http://localhost:5000/ in the browser and the site should appear.


Directories:

Public contains images, css, and client scripts.
(images is also where uploads of profile pictures go).

Services contains mysql database object.

Server contains all the nodejs application code and routing.

Views is where all the pages live. Handlebars (hbs) is just templated HTML.
  Layouts is where the main layout of all pages.
  Partials is small hbs files that can be used by other hbs files.
  
tutor.sql contains all the mysql tables and rows.
