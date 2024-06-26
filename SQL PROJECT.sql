use sakila;
#TASK 1
select * from actor;
select concat(first_name,"  " ,last_name) as "Full name" from actor;
#TASK 2.i
select first_name,count(first_name) as "count of first names" from actor group by first_name;
#TASK 2.ii
select distinct(first_name),count(actor_id) as "count of actors" from actor group by first_name;
#TASK 3.i
select last_name,count(last_name) as "count of last names" from actor group by last_name;
select distinct(last_name),count(actor_id) as "count of actors" from actor group by last_name;
#TASK 4.i(movies with rating:'R')
select * from film;
select distinct(title),rating from film where rating="R";
#TASK 4.ii(movies that not R rated)
select distinct(title),rating from film where rating!="R";
#TASK 4.iii(movies that are suitable audience less than 13 years of age)
select distinct(rating) from film;
#G rating more preferable children less than 13 years of age
select distinct(title),rating from film where rating="G";    # total 178/1000 movies all age groups are allowed and it also suitable for children.
#TASK 5.i(movies replacement cost upto $11)
select * from film where replacement_cost = 10.99;      #49 movies have replacement cost upto $11
#TASK 5.ii(replacement cost between 10.99 and 19.99
select * from film where replacement_cost between 10.99 and 20;      #total 473 movies
#TASK 5.iii(descending order of the replacement costs)
select title,replacement_cost from film order by replacement_cost desc;     #29.99 is high replacement cost
select title,replacement_cost from film where replacement_cost=29.99;       #There are 53 movies with high replacement cost
#TASK 6(top 3 movies with greatest number of actors)
#the tables film and film actor should be joined on the column film_id
select title,count(actor_id) as 'number of actors' from film inner join film_actor on film.film_id=film_actor.film_id group by title order by 'number of actors' desc limit 3;  #top 3 movies having more actors
#TASK 7(movies starting with k and Q)
#like operator
select title from film where title like 'K%';     #12 movies starting with K
select title from film where title like 'Q%';      #3 movies starting with Q
#TASK 8(actor names of the film agent truman)
select title,concat(first_name,"  ",last_name) as 'actors' from film inner join film_actor on film.film_id=film_actor.film_id inner join actor on film_actor.actor_id=actor.actor_id where title='Agent Truman';
#TASK 9(movies suitable for families)  #69 movies are family category
select title,name from film inner join film_category on film.film_id=film_category.film_id inner join category on film_category.category_id=category.category_id where name='Family';
#TASK 10(RENTAL RATES,COUNT OF RENTED DISC)
#TASK 10.i(max,min,average rental rates based on ratings sorted in descending order)
select rating,max(rental_rate) as 'Maximum rental rate',min(rental_rate) as 'Minimum rental rate',Avg(rental_rate) as 'average rental rate' from film group by rating order by 'average rental rate' desc;
#TASK 10.ii(rental frequencies(count of rental movies)
select distinct(title),count(rental_id) as 'count of rental movies'  from film inner join Inventory on film.film_id=Inventory.film_id inner join rental on Inventory.inventory_id=rental.inventory_id group by title order by 'count of rental movies' desc;
#bucket brother hood having high rental frequency so it should be more copies.
#TASK 11

select name,avg(replacement_cost),avg(rental_rate), (avg(replacement_cost)-avg(rental_rate)>15) as 'difference between replacement cost and rental cost >15' from film  inner join film_category on film.film_id=film_category.film_id inner join category on film_category.category_id=category.category_id group by name;
#TASK 12
select name as 'category',count(film.film_id) as 'number of movies' from film inner join film_category on film.film_id=film_category.film_id inner join category on film_category.category_id=category.category_id group by name having name in ('foreign','sports');
select name as 'category',count(film.film_id) as 'number of movies' from film inner join film_category on film.film_id=film_category.film_id inner join category on film_category.category_id=category.category_id group by name ;
#music category has low films