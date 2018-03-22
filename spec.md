# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database
Database stores Users, Plants, Care Instructions, and Plant Statuses
Note: Only one set of care instructions will ever be displayed but each change is stored as a seperate record for future more complex features.
- [x] Include more than one model class (list of model class names e.g. User, Post, Category)
Models: User, Plant, Instruction, Status
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts)
Users own and has many Plants. Plants have many Care Instructions. Plants have many Statuses.
- [x] Include user accounts
Users can create accounts, login, and logout
- [x] Ensure that users can't modify content created by other users
This is handeled in the controller and within the design users can ONLY duplicate other user's plants.
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying

PLANT
Create '/plants/new'
Read '/plants' & '/greenhouse' routes
Destroy '/plants', '/greenhouse', '/plants/new', & '/plants/:id/edit' routes
Edit '/plants/:id/edit'

STATUS
Create '/plants/new', '/plants', '/greenhouse', & '/plants/:id'
Read '/plants/:id'
Destroy '/plants/:id'
Edit (Not Available)

CARE INSTRUCTIONS
Create '/plants/new' & '/plants/:id/edit' 
  *On the plant's edit page if changes are made to the instructions it will create a new entry rather than updating the existing one in order to preserve historical changes for future use.
Read '/plants' & '/greenhouse'
Destroy (Cannot Destroy Instructions for above reason)
Edit (Not Available for above reason)

- [x] Include user input validations
User input validations on all input fields except any form posting to the statuses table.
Passwords have password validations, emails have email, etc.
- [x] Display validation failures to user with error message (example form URL e.g. /posts/new)
All required input fields have errors messages on the client side to prevent the user from submiting incomplete data
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
