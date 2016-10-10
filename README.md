# Wedding

## RSVP
`GET /rsvp`
<b>params</b>: none
serve page with input for group code

### View RSVP
`GET /rsvp/:group_code`
<b>params</b>: none

<b>returns</b>:
```javascript
{
  "user_group": {
    "code": string,
    "address_line1": string,
    "address_line2": string,
    "city": string,
    "state": string,
    "zipcode": string
    "notes": text
  },
  "users": {
    [
      {
        "id": int,
        "first_name": string,
        "last_name": string,
        "email": string,
        "is_attending": boolean,
        "diet": string
      },
      ...
    ]
  }
}
```


### Edit RSVP
RSVP form will contain elements to modify both the User and User Group values

1. edit User
`PUT /user/:id`
<b>params</b>:
```javascript
{
  "user": {
    "id": int,
    "email": string,
    "is_attending": boolean,
    "diet": "vegetarian" // or null
  }
}
```


2. edit User Group
`PUT /user_group/:id`
<b>params</b>:
```javascript
{
  "user_group": {
    "code": string,
    "address_line1": string,
    "address_line2": string,
    "city": string,
    "state": string,
    "zipcode": string,
    "notes": text
  }
}
```

## Admin authentication and access
### Login
`POST /sessions`
<b>params</b>:
```javascript
{
  "session": { "email": string }
}
```

### Logout
`DELETE /sessions`

### View RSVPs
TODO: aggregated quick stats, sliceable

