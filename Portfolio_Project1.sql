SELECT 
    *
FROM
    covid_deaths
ORDER BY 3 , 4;

SET SQL_SAFE_UPDATES = 0;

-- update "date" column to mysql date format:
UPDATE covid_deaths
SET 
    date = STR_TO_DATE(date, '%d.%m.%Y');


 -- deleting rows which are out of specified dates
DELETE FROM covid_deaths 
WHERE
    date < '2020-01-20'
    OR date > '2021-04-30';

-- checking whether there are any data which is out of specified dates
 select * from covid_deaths
 where date like "2023%";



select location, date, total_cases, new_cases, total_deaths, population
from covid_deaths
order by 1,2;
 
--  update the columns total_case and total_deaths which have empty rows as Null in 'covid_deaths' table

UPDATE covid_deaths 
SET 
    total_cases = NULLIF(total_cases, ''),
    total_deaths = NULLIF(total_deaths, '');

 
 -- looking at total cases and deaths
 -- showing possibility of dying from covid in selected country.
SELECT 
    location,
    date,
    total_cases,
    total_deaths,
    (total_deaths / total_cases)*100 as Death_percentage
FROM
    covid_deaths
    where location like "Turkey"

ORDER BY 1,2 ;

-- total case vs population
-- shows what percentage of population got covid
SELECT 
    location,
    date,
    population,
    total_cases,
    
    (total_cases/population )*100 as infection_rate
FROM
    covid_deaths
    where location like "Turkey"

ORDER BY 1,2 ;

-- looking at countries with highest infection rate compared to population

select location,population , max(total_cases) as highes_infection_count, max((total_cases/population)*100) as infection_rate
from covid_deaths  
group by location,population
order by infection_rate desc;

-- showing countries with highest death count per population 

select location, max(total_deaths) as total_death_counts
from covid_deaths
 where continent is not null
group by location
order by total_death_counts desc;

-- stats according to continents
-- showing continents with highest death counts per population

select continent, max(total_deaths) as total_death_counts
from covid_deaths
 where continent is not null
group by continent
order by total_death_counts desc;

-- Global Numbers
select  sum(new_cases) as total_cases,
sum(new_deaths) as total_deaths,
sum(new_deaths)/sum(new_cases)*100 as Gdeath_percentage
FROM covid_deaths
where continent is not null
-- group by date
order by 1,2;

-- Looking at Total Population vs  Vaccination
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(vac.new_vaccinations)over (partition by dea.location order by dea.location, dea.date) as rolling_people_vaccinated
from covid_deaths as dea
	join covid_vaccinations as vac
	on dea.location= vac.location
		and dea.date=vac.date 
where dea.continent is not null
order by 2,3;


-- Use CTE
WITH popVSvac AS (
    SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
           SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
    FROM covid_deaths AS dea
    JOIN covid_vaccinations AS vac
    ON dea.location = vac.location
    AND dea.date = vac.date 
    WHERE dea.continent IS NOT NULL
)
SELECT *,(rolling_people_vaccinated/population)*100
 FROM popVSvac;


-- Temp Table

drop table if exists PercentPopulationVaccinated;

CREATE TEMPORARY TABLE PercentPopulationVaccinated (
    Continent VARCHAR(255),
    Location VARCHAR(255),
    Date DATE,
    Population NUMERIC,
    New_Vaccinations NUMERIC,
    Rolling_People_Vaccinated NUMERIC
);

INSERT INTO PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, NULLIF(vac.new_vaccinations, ''),
       SUM(NULLIF(vac.new_vaccinations, '')) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM covid_deaths AS dea
JOIN covid_vaccinations AS vac
ON dea.location = vac.location
AND dea.date = vac.date 
WHERE dea.continent IS NOT NULL;


SELECT *, (Rolling_People_Vaccinated / Population) * 100
FROM PercentPopulationVaccinated;


-- creating view to store data for later visiluation
create view PercentPopulationVaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, NULLIF(vac.new_vaccinations, ''),
       SUM(NULLIF(vac.new_vaccinations, '')) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM covid_deaths AS dea
JOIN covid_vaccinations AS vac
ON dea.location = vac.location
AND dea.date = vac.date 
WHERE dea.continent IS NOT NULL;




 

 
 