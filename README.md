#Parking Test


## Environment

* Ruby 2.1.1p76
* sqlite

## Setup

Install bundler and run `bundle install`

production: *development
```
Run `rake db:create db:migrate`.

```

## Header Links

```
Parking Lot link for listing parking lot details.
In same page `+ New Parking Lot` link present to create new parking lot.

```
Current parking lot creation code is written fixed floor_level. 
We can modify the same code for multiple floor level.
Only Basic validations are added to create parking lot.

```
Parking Booking link for book new parking.
On same page `Back` link is present for list Booking histroy.
On Booking history page `Click to Return Ticket` link is present. 
This link is for return ticket to release the slot.


