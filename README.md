# Greenworks
A small app to display and organize projects, ideas or actions in a local community.

## Features
* Each item can be displayed as
	* A card (title, body, tags)
	* A detailed page
	* With pictures
		* upload new images
		* remove images
		* display card in list view to allow for multiple images
		* Ability to upload images (active storage) https://guides.rubyonrails.org/active_storage_overview.html
		https://bhserna.com/simple-image-manager-with-active-storage
* Classification by :
	* Place
	* Status (idea, project, planned, in progress, done)
	* Tags (2 levels of tags)
* Items can be liked
	* set cookie to prevent multiple likes on the same item
* import items from spreadsheet
https://medium.com/@schmidlinicole/how-to-import-data-from-an-excel-file-in-rails-7ac9a628137f
rake import:card_data

* Create simple user and login system as well as backend with devise
	* https://www.digitalocean.com/community/tutorials/how-to-set-up-user-authentication-with-devise-in-a-rails-7-application
	* 1hr
* Create class and views for cards 
	* 1hr
	
* Create tags and views for tagged cards (taggable)
* Multifactored combinations of tags (e.g. idea + mobility + lustin)
* Like buttons with cookies :  3 hrs
	* needs debugging (turbo)
* switch to pg to deploy on heroku
* import items from spreadsheet
https://medium.com/@schmidlinicole/how-to-import-data-from-an-excel-file-in-rails-7ac9a628137f

	
## TO DO

* Share buttons
* candidates list
* fil-rouge pages
* feedback form
* bugfix likes not updated
* bugfix likes unset upon creation
* bugfix associated cards


## Timesheet
| date			 | duration |
|----------------|----------|
| 20240213 19.00 | 0.5      |
| 20240601 21.00 | 3.5      | 
