require 'rest-client'
require 'json'
require 'csv'

class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:home]

  def home
Hubspot.configure(
    client_id: "56ee8576-5661-42f3-8281-db8d417d4f05",
    client_secret: "db4c4403-ea58-4e89-87ce-c6fc3a1c1a99",
    redirect_uri: "https://omnicon.herokuapp.com/",
    access_token: @access_token)
@access_token = Hubspot::OAuth.create(params[:code])
Hubspot::OAuth.authorize_url(["contacts", "tickets"])


Hubspot.configure(hapikey: "953be023-b5be-4f99-ac65-d9c2da581fb1")
@a = Hubspot::Contact.find_by_email("frederic.curier@gmail.com")
@d = Hubspot::Contact.all

url_user =  'https://api.hubapi.com/extensions/sales-objects/v1/object-types?hapikey=f973fe7d-b24e-4ee2-aec6-40af9c6dbc2c'
response = RestClient.post url_user,
    {
  "applicationId": 197936,
  "baseUris": [
    "https://omnicon.herokuapp.com/"
  ],
  "dataFetchUri": "https://omnicon.herokuapp.com/",
  "title": "DemoTickets",
  "propertyDefinitions": [
    {
      "name": "ticket_type",
      "label": "Ticket type",
      "dataType": "STRING"
    },
    {
      "options": [
        {
          "type": "SUCCESS",
          "label": "In Progress",
          "name": "inprogress"
        },
        {
          "type": "DEFAULT",
          "label": "Resolved",
          "name": "resolved"
        }
      ],
      "name": "status",
      "label": "Status",
      "dataType": "STATUS"
    },
    {
      "name": "priority",
      "label": "Priority",
      "dataType": "STRING"
    },
    {
      "name": "project",
      "label": "Project",
      "dataType": "STRING"
    }
  ],
  "associatedHubSpotObjectTypes": [
    "contacts"
  ],
  "associatedHubSpotObjectTypeProperties": {
    "contacts": [
      "domain"
    ]
  }
}.to_json, {content_type: :json, accept: :json}
end
end
