----SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage FROM CovidDeaths
----WHERE location like '%India%'
----Order By 1,2


------ Looking at Total case Vs TotalPopulation

----SELECT location,date,population,total_cases,(total_cases/population)/100 as TotalcasePer FROM CovidDeaths
------WHERE location Like '%States'
----Order BY 1,2

----Looking at Countries with highest Infection rate Compared To Population

--SELECT location,population,MAX(total_cases) AS HighestInfectionRAte, MAX((total_cases/population)) as PerInfectionRate FROM CovidDeaths
--WHERE location Like '%U%'
--GROUP BY location,population 
--ORDER BY PerInfectionRate Desc

--Showing Countries with Highest Death Count per Population

SELECT location,MAX(cast(total_deaths as int))AS MaximumDeath 
FROM CovidDeaths
WHERE continent IS Not Null
GROUP BY location,population
ORDER BY MaximumDeath Desc

-- Lets BREAK DOWN Things Down BY Continent

SELECT Continent, Max(cast(total_deaths as int)) as MaximumDeaths From CovidDeaths
WHERE continent Is Null
GROUP BY continent
ORDER BY MaximumDeaths Desc

-- GLOBAL NUMBER 

SELECT date,SUM(new_cases),SUM(cast(new_deaths as int)) FROM CovidDeaths
WHERE continent is Not Null
GROUP BY date
ORDER BY 1,2


--From Table Covid Vaccination 
SELECT * FROM CovidVaccinations

--Join On Table CovidDeath and CovidVaccination

SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations  FROM CovidDeaths dea
JOIN CovidVaccinations vac ON dea.location = vac.location 
AND dea.date = vac.date
WHERE dea.continent is Not Null
ORDER BY 2,3

-- Looking At TotalPopulation VS Vaccination 

SELECT dea.continent,dea.location,
dea.date,dea.population,vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) 
OVER (Partition by dea.location Order BY dea.location,
dea.Date) as RollingPepleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location
AND dea.date=vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3

-- USE CTE 

WITH popvsvac (Continent,Loaction,Date,Population,RollingPepleVaccinated,NewVaccination)as
(
SELECT dea.continent,dea.location,
dea.date,dea.population,vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) 
OVER (Partition by dea.location Order BY vac.new_vaccinations,
dea.Date) as RollingPepleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location
AND dea.date=vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3
)
SELECT  *,(RollingPepleVaccinated/Population)/100 FROM popvsvac
ORDER BY 2,3


-- Creat Tem Table
DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
( Continent nvarchar(50),
 location nvarchar(255),
 Date datetime,
 Population numeric,
 New_vaccination numeric,
 RollingPepleVaccinated numeric

)
INSERT into #PercentPopulationVaccinated

SELECT dea.continent,dea.location,
dea.date,dea.population,vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) 
OVER (Partition by dea.location Order BY vac.new_vaccinations,
dea.Date) as RollingPepleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location
AND dea.date=vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3

SELECT  *,(RollingPepleVaccinated/Population)/100 FROM #PercentPopulationVaccinated

-- Creating View To store the data for later visualisation

CREATE VIEW  PercentPopulationVaccinated as
SELECT dea.continent,dea.location,
dea.date,dea.population,vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) 
OVER (Partition by dea.location Order BY dea.location,
dea.Date) as RollingPepleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location
AND dea.date=vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3

