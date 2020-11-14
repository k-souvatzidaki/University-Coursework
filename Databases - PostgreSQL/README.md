# Databases: PostgreSQL - Amazon AWS database

For the Databases course we created a database with rental listings data (at first from AirBnb ,later on from Zillow too) on the **Amazon AWS cloud** platform and connected to it via a **PostgreSQL** desktop client (pgAdmin) , to be able to execute SQL queries. We then did several exercises, including **applying changes to the schema, writing queries, creating indexes etc**.
We also did a bigger project in both **SQL and Python**. We used Python modules to manipulate .CSV files and connect to the database to make changes. 
    
This was our first time writing SQL and creating a database schema from scratch.

## Datasets
The datasets we used for this project were .CSV files with AirBnB and Zillow listings information. Unfortunately, I couldn't find the files and upload them here.. (it's been a while).

## 1. Creating the AirBnb database schema

## 2. Writing queries

## 3. Altering the database schema

## 4. Splitting columns and creating new tables

## 5. Writing GROUP BY queries (aggregations)

## 6. Creating indexes and triggers

## Project
This project consisted of 2 parts: **First**, in the **Python** files **fix_airbnb_1.py**, **fix_airbnb_2.py** and **zillow.py**, we used the **psycopg2** module and connected to the AWS database to fetch tables and apply changes, while we also used the **csv** module to manipulate some additional .CSV file datasets. **Second**, we used pure **SQL** to insert the data from the CSV files to the database(**upload_data.sql**), and then to create some **views** (**RCP.sql**).

## Group
I did this project with [Themelina Kouzoumpasi](https://github.com/themelinaKz)
    
*Spring 2018-19*
