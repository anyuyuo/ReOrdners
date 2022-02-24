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
- Backend
    - [ ] Add tesseract to extract content from letters and save the content in db to be searchable
- Optimization
    - [ ] Add prod flag to serve statics from nginx


## Database structure
2022-24-02 - Currently bein restructured into:
```
Document
================
INT     id
TEXT    name
INT     creation Date

Document_Image
================
INT     document_id
INT     image_id
BOOL    parent

Image
================
INT     id
TEXT    content
TEXT    filename
TEXT    mimetype

```