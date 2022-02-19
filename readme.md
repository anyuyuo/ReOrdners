

## linux install
gem 'sinatra'
gem 'sqlite3'
gem 'webrick'


## roadmap

- Edit
    - [ ] Design page
    - [ ] Frontent implementation
    - [ ] Function: Change name
    - [ ] Function: Add description
    - [ ] Function: Add child documents 
    - [ ] Set other document as parent document
- Search
    - [ ] Information should be sticky to the bottom of the document preview item link
    - [ ] Search by id
    - [ ] Search by name
    - [ ] Search by desc
    - [ ] Search by date
        - [ ] by date
        - [ ] by date range
    - [ ] Search by Type/Tags
    - [ ] Fuzzy search (all included, first is one by one like in advanced search)

## design

### search
Either everything in own box or use text syle: "tag:something some fuzzy search"

I tend to own box for everything, since the one aimed at are not programmers who like to write text
