# Protfolio_Project1

This portfolio project focuses on analyzing COVID-19 data using SQL queries.
The dataset used contains information about COVID-19 cases, deaths, and vaccinations across different countries and regions.

PROJECT OVERVIEW:
This project aims to extract insights from the COVID-19 dataset through SQL queries.
It includes a variety of queries covering aspects such as:

- Tracking the spread of the virus over time
- Analyzing trends in new cases, deaths, and vaccinations
- Comparing the impact of the pandemic across countries and continents

QUERIES:
The project includes a set of SQL queries designed to answer specific questions about the COVID-19 data. 
Some of the key queries include:

- Calculating death percentages and infection rates
- Identifying countries with the highest infection rates and death counts per population
- Analyzing vaccination trends and their impact on population immunity

 -- REPORT OF PORTFOLIO_PROJECT1 -- 
This concise report outlines the challenges I encountered during the project and the solutions I implemented to address them.

IMPORTING PROCESS:
Incorrect Integer Value Error: Encounter an error while importing the dataset to MySQL via the import wizard due to incorrect integer values.
Solution: Utilized the command-line and local infile method, successfully importing the dataset into MySQL.

Reason for Error: Dataset required adjustments, which were made using Excel. Later on I tried Saving the file with the "csv utf8" option instead of "csv" resolved the import issue.

CALCULATION ERROR:
Mis-Calculation Error: Empty rows in the dataset were not automatically filled with null values by MySQL, causing incorrect calculations.
Solution: Addressed the issue by filling missing rows with "Null" using a query.

Data-Type Error: Sorting countries by infection rate compared to population revealed incorrect results due to the total_case column being stored as text instead of an integer.
Solution: Modified the data type of the total_case column to integer to resolve the sorting issue.
