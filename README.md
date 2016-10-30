# Wedding

## RSVP
`GET /rsvp`

<b>params</b>: none
serve page with input for group code

### View RSVP
`GET /rsvp/show/:group_code`

<b>params</b>: none

<b>curl</b>: `curl http://0.0.0.0:3000/rsvp/show/TEST.json`

<b>returns</b>:
```javascript
{
  "user_group": {
    "code": string,
    "address_line1": string,
    "address_line2": string,
    "city": string,
    "state": string,
    "zipcode": string,
    "notes": text,
    "lodging_friday": string (null | 'REQUESTED' | 'CONFIRMED'),
    "lodging_saturday": string (null | 'REQUESTED' | 'CONFIRMED'),
    "lodging_sunday": string (null | 'REQUESTED' | 'CONFIRMED')
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

Edit User Group with Users
Notes: first and last name are not editable, payload excludes updating or returning `relationship`

`POST /user_group/:id`

<b>params</b>:
```javascript
{
  "user_group": {
    "id": int
    "code": string,
    "address_line1": string,
    "address_line2": string,
    "city": string,
    "state": string,
    "zipcode": string,
    "notes": text,
    "lodging_friday": string (null | 'REQUESTED' | 'CONFIRMED'),
    "lodging_saturday": string (null | 'REQUESTED' | 'CONFIRMED'),
    "lodging_sunday": string (null | 'REQUESTED' | 'CONFIRMED')
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

<b>curl</b>:

```
curl -H "Content-Type: application/json" -X PUT -d '{
  "user_group": {
    "address_line1": "1 Mansion Drive",
    "address_line2": "",
    "city": "Baoville",
    "state": "CA",
    "zipcode": "12345",
    "code": "TEST",
    "notes": "test notes",
    "lodging_friday": null,
    "lodging_saturday":'REQUESTED',
    "lodging_sunday": 'REQUESTED'
  },
  "users": {
    "1": {
      "email": "test@gmail.com",
      "is_attending": "1",
      "diet": "1",
      "id": "1"
    },
    "2": {
      "email": "newemail",
      "is_attending": "0",
      "diet": "0",
      "id": "2"
    }
  },
  "id": "1"
  }' http://0.0.0.0:3000/user_groups/1.json
  ```

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
      "notes": text,
      "tier": integer,
      "lodging_friday": string (null | 'REQUESTED' | 'CONFIRMED'),
      "lodging_saturday": string (null | 'REQUESTED' | 'CONFIRMED'),
      "lodging_sunday": string (null | 'REQUESTED' | 'CONFIRMED')
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

## Admin authentication and access
### Login
`POST /sessions`

<b>curl</b>: `curl -d 'session[email]=c' http://0.0.0.0:3000/sessions`

<b>params</b>:
```javascript
{
  "session": { "email": string }
}
```

<b>returns</b>:
Success
```javascript
{ user_id: 1 }
```

Error
```javascript
{ errors: "Invalid wedding party email" }
```

### Logout
`DELETE /sessions`

### Create User
Only admins can create new guests

`POST /user/:id`

<b>params</b>:
```javascript
{
}
```

### View user groups' RSVPs
`GET /user_groups`

TODO: aggregated quick stats, sliceable

