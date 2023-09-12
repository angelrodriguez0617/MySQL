-- Report of all specifics related to the machine learning results
-- Join all the tables
select MLName, DamageDesc, TurbineSectionDesc, ImageName, latitude, longitude, DroneName, FlightDate
from damageinspection
join MLModel on MLModel.MLModelID = damageinspection.MLModelID
join damage on damage.damageid = damageinspection.damageid
join image on image.imageid = damageinspection.imageid
join turbinesection on turbinesection.turbinesectionid = image.turbinesectionid
join windturbine on windturbine.windturbineid = image.windturbineid
join flight on flight.flightid = image.flightid
join drone on drone.droneid = flight.droneid
order by damagedesc;

-- Which turbine(s) should be repaired immediately due to major damage?
select distinct windturbineid from damageinspection 
natural join image
natural join windturbine
where damageid = 3;
 
-- What are the varying total heights and hub heights of the wind turbines?
select windturbineid, hubheight, totalheight
from windturbine;

-- Select all drone flights earlier than 2023
select flightid, flightdate
from flight
where flightdate < '2023-01-01 00:00:00';

-- Which drones were flown in 2023
select dronename 
from flight natural join drone
where flightdate > '2023-01-01 00:00:00';

-- Which drone took the picture relating to damageInspectionID = 1?
select dronename
from damageinspection natural join image natural join flight natural join drone
where damageinspectionid = 1;

