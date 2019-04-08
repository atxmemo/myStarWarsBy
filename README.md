# myStarWarsBy

This project is a API only ruby on rails application that replicates the /films and /films/:id endpoint from the [Star Wars API](https://swapi.co/)

## Ruby version
This project uses ruby 2.5.5

## How to run the test suite
Execute the `rails test` command from the top level directory to run the application tests

## Running the docker image
The latest code on master for this project has been Dockerized and the image can be found on my personal Docker Hub profile

To pull this image and spin up a container on your local machine running docker you can run the following command:

> docker run -p 80:3000 gterra023/take-home:master

This command will pull the image tagged `master` from my `take-home` repository within my `gterra023` profile

## Pinging AWS EC2 

I have configured and booted a Linux AMI instance on AWS EC2 to run this image on a container. 
You can ping the application using the following endpoints:

* http://ec2-18-224-17-73.us-east-2.compute.amazonaws.com/films
* http://ec2-18-224-17-73.us-east-2.compute.amazonaws.com/films/:id

> NOTE: valid :id parameters are 1 - 7 inclusive
