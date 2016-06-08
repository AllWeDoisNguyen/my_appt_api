

# Appointment API

This is an API for managing appointments and efficiently filtering through a large database. 
It can display a list of all appointments in the last decade until a set future date.
It can display a list of all appointments that pass the filtered list of appointments:
(`full_name`, `start_time`, `end_time`, `first_name`, `last_name`, `day`, `hour`, `year`, `month`).
When adding new appointments, the app checks that appointments are in the future and don't overlap existing appointments.
When updating an appointment, it only allows appointments in the future to be edited. The user cannot update an appointment that has already passed.
All appointments must have a start and end date.

### Technology Choices
This API was developed in rails 4
Testing
  This API was developed using TDD. 
  RSPEC testing was done to ensure API functionality
  Faster, and easier than testing through CURL commands in the terminal
Heroku
  Heroku is hosting the API
  Postgres was selected as the database as a result
```
#### Search Filters Examples
|                             |      Copy and Paste URL to Try                                            |
|---------------------------------------------------------------------------------------------------------|
| full name  | bayley keller  | 'https://carecloudapi.herokuapp.com/appointments?full_name=bayley keller' |
| first name | bayley         | 'https://carecloudapi.herokuapp.com/appointments?first_name=bayley'       |
| last name  | keller         | 'https://carecloudapi.herokuapp.com/appointments?last_name=keller'        |
| start time | '11/1/13 9:30' | 'https://carecloudapi.herokuapp.com/appointments?start_time=11/1/13 9:30' |
| end time   | '11/1/13 9:30' | 'https://carecloudapi.herokuapp.com/appointments?end_time=11/1/13 9:35'   |
| day        | '11/1/13'      | 'https://carecloudapi.herokuapp.com/appointments?day=11/1/13'             |
|            |                |                                                                           |
```
###GET Request

Get request can be done with criteria or without.

####Simple request for all appointments:

GET `https://carecloudapi.herokuapp.com/appointments`

or 

GET `https://carecloudapi.herokuapp.com/`

`/appointments` is optional.

####Request for appointments with one criteria:

GET `https://carecloudapi.herokuapp.com/appointments/`, `?start_time=11/1/13 9:30`

This will give you a filtered list of appointments.

####Request with mutliple criteria:

GET `https://carecloudapi.herokuapp.com/appointments/`, `?first_name=brenda&end_time=11/1/13 11:05`

This will give you a filtered list of appointments that match both criteria.

###POST Request as Rspec test

```it "creates an appointment" do
   
    post "/appointments", {:appointment => {:start_time => "11/1/17 9:30",
                                             :end_time => "11/1/17 9:35",
                                             :first_name => "Jude",
                                             :last_name => "Blome"} }

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to have_http_status(:created)
    expect(Appointment.find_by(first_name: "Jude")).to be_a(Appointment)```


###PATCH Request as Rspec test
  
  Patch requests are validated just like post requests. They do not create a new entity they alter an existing. An appointment ID number is required to do a patch request.

```
  it "updates an appointment time" do
    @appointment = Appointment.create(start_time: "12/3/19 10:30", end_time: "12/3/19 10:35", first_name: "Jo", last_name: "Be", day:"Sun, 01 Dec 2019 10:30:00 +0000")
   
    patch "/appointments/#{@appointment.id}", {:appointment => {:start_time => "11/02/17 7:30",
                                                              :end_time => "11/02/17 7:35"} }

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to have_http_status(200)
    expect(@appointment.reload.start_time).to eq("11/02/17 7:30")
  end
```

###DELETE Request as Rspec Test
 \#\#\#WARNING\#\#\#  
\#This is distructive\#

  Delete requires an appointment ID.
  DELETE "https://carecloudapi.herokuapp.com/appointments/1"

```
  before do 
  @appointment = Appointment.create(start_time: "01/1/17 7:30", end_time: "01/1/17 7:35", first_name: "Judy", last_name: "Blume")
  end
  it "deletes an appointment" do
   
    delete "/appointments/#{@appointment.id}"
    expect(response).to have_http_status(204)
  end
```

### Create
  first_name, last_name, start_time, end_time are required.
  comments is an optional string field

  Example:
  post 'https://carecloudapi.herokuapp.com/',
    `{ appointment: { first_name: 'Joe', last_name: 'Yeung', start_time: '05/05/16 9:00', end_time: '05/05/16 9:05' } }`

### Update
  By appointment id
  patch first name https://carecloudapi.herokuapp.com
         patch "/appointments/#{@appointment.id}", {:appointment => {:last_name => "Bobby"} }
     
### Delete
  By appointment id
  delete https://carecloudapi.herokuapp.com'appointment_id'

For further information, please refer to the RSPEC tests
Currently working on being able to update and delete appointments by finding appointment without having to know the id
