Rails.application.routes.draw do

  get 'get_courses_by_location/:location_id', to: 'courses#get_courses_by_location'  
  get '/course_search' => 'courses#course_search'

 end

# Rocket Elevators: Ruby on Rails <!-- omit in toc -->

## Table of Contents <!-- omit in toc -->

- [Project Description](#project-description)
- [Application Requirements](#application-requirements)
- [Using API to improve website features](#using-api-to-improve-website-features)
- [Credits](#credits)

## Project Description
The main purpose of adding API to a website is to enriched the experience 

## Application Requirements

-   [Ruby](https://www.ruby-lang.org/en/downloads/) (v2.7.5)
-   [Rails](https://rubyonrails.org/) (v5.2.6)

## Using API to improve website features

### 1. Google Maps
Google Maps API helps you to bring the power of Google Maps directly on your website. In our case, we use it in our backoffice to show all building location.

To try it, log in and in the administration and click on Map.

### 2. Twilio
Twilio supports all forms of communication and can be integreted as an API into your plateform. In our case, we use it to warn the technician we he has to intervene. When the status of an elevator is changed to "Intervention".

To try it, log in and change the status of an elevator to "Intervention".

### 3. Slack
Slack API is able to give record of different activities that occur in the backoffice and inform the right people through the right channel. In our case, we use it to inform operators when an elevator status has changed. It tells the previous and new status of a the specific elevator (ID and serial number). 

To try it, log in and change the status of an elevator.

### 4. DropBox
DropBox API is able to automated the upload of certains files directly in a file in your cloud account. In our case, we use it to update to the server the file uploaded in the lead form once the contact becomes a customer.

### 5. FreshDesk
FreshDesk is a usefull tool to make sure to follow up on every contact, no matter the source of this incomming message. In our case, we use it to send a ticket request if you fill the lead form or the quote form.

### 6. Amazon Polly
Amazon Polly is a service that turns text into realistic speech. In our case, we use that API to add to the Admin dashboard the possibility to start a vocal brifing.

To try it, log in and click on briefing in the administration dashboard.

### 7. Notify
Notify API connects existing messaging services to make sure to be inform. In our case, an e-mail is send to the relevant person when a form contact is submit

To try it, fill the lead form with your valid e-mail adress. Then, take a look at your mailbox.

### 8. reCAPTCHA
reCAPTCHA API helps to protect your website form to get spammed or abuse. In our case, we use it to secure the lead form and the quote form. 

You can see it in the lower right corner of the homepage and of the quote page.

### 3. Access to Back Office (Restricted)
Access to back-end office is restricted to users that were assigned as [employees](https://docs.google.com/spreadsheets/d/1-S0updscUGOpBpFE-2plFBJlVkCseOUuUpp7nu5e-fY/edit#gid=1786076246). Email and password are also required to access the back-end office. To login, simply use the employee's email and using the password that follows the logic of: first letter of first name + first letter of last names + 1234. For example:
  * User example: Francis Patry-Jessop
    * Email: francis.patry-jessop@codeboxx.biz
    * Password: fpj1234
  * User example: Patrick Thibault
    * Email: patrick.thibault@codeboxx.biz
    * Password: pt1234

## Credits

This project was made possible through the support of:

-   Perry Sawatzky
-   Mathieu	Houde
-   Patrick Thibault
-   Francis Patry-Jessop
-   CodeBoxx School of Technology Community

