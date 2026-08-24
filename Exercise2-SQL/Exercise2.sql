--easy
--1
SELECT CONCAT(first_name,' ',last_name) as "name", email from customer ORDER BY last_name;
--2
SELECT "name", unit_price as "price" FROM track WHERE unit_price > 0.99 ORDER BY unit_price DESC;
--3
SELECT COUNT(track_id) as "track-number" FROM track;
--medium
--4
SELECT CONCAT(c.first_name,' ',c.last_name) as "name", 
COUNT(i.invoice_id) as "invoice number" FROM customer as c
RIGHT JOIN invoice as i ON i.customer_id = c.customer_id 
WHERE i.invoice_id > 3 GROUP BY c.customer_id;
--5
SELECT t.name, sum(i.quantity) as "sold" FROM track as t
JOIN invoice_line as i ON t.track_id = i.track_id GROUP BY t.track_id ORDER BY sold DESC LIMIT 5;
--6
SELECT al.title as "Album-Name", ar.name, COUNT(t.track_id) as "tracks-in-album" FROM track as t
LEFT JOIN album as al on t.album_id = al.album_id
LEFT JOIN artist as ar on al.artist_id = ar.artist_id 
GROUP BY al.title,ar.name ORDER BY "tracks-in-album" DESC;
--7
SELECT CONCAT(c.first_name,' ', c.last_name) as "customer", CONCAT(e.first_name,' ', e.last_name) as "sales-rep", c.country as "country"  FROM customer as c
RIGHT JOIN employee as e ON c.support_rep_id = e.employee_id WHERE c.country = e.country;
--8
SELECT g.name as "genre" ,  COALESCE(SUM(i.unit_price),0) as "total-revenue" FROM genre as g 
RIGHT JOIN track as t ON g.genre_id = t.genre_id
LEFT JOIN invoice_line as i ON i.track_id = t.track_id
GROUP BY g.name ORDER BY "total-revenue" DESC
--hard
--9
SELECT EXTRACT(MONTH FROM i.invoice_date) as "month", 
TO_CHAR(TO_DATE (EXTRACT(MONTH FROM i.invoice_date)::text, 'MM'), 'Month') AS "Month Name",
SUM(il.unit_price)as "total-revenue-2021"
FROM invoice as i
LEFT JOIN invoice_line as il ON il.invoice_id = i.invoice_id
GROUP BY "month" ORDER BY "month";
--10
SELECT CONCAT(c.first_name,' ', c.last_name) as "customer", c.email FROM customer as c 
LEFT JOIN invoice as i ON i.customer_id = c.customer_id
LEFT JOIN invoice_line as il ON il.invoice_id = i.invoice_id
LEFT JOIN track as t ON t.track_id = il.track_id
LEFT JOIN genre as g ON g.genre_id = t.genre_id AND g.genre_id = 1 WHERE g.genre_id IS NULL GROUP BY "customer",c.email ORDER BY "customer"
--11
SELECT country, "customer", "spending"
FROM (
SELECT c.country , CONCAT(c.first_name,' ', c.last_name) as "customer", SUM(il.unit_price) as "spending",RANK() OVER (PARTITION BY c.country ORDER BY SUM(il.unit_price) DESC) as "rank"  
FROM customer as c 
LEFT JOIN invoice as i ON i.customer_id = c.customer_id
LEFT JOIN invoice_line as il ON il.invoice_id = i.invoice_id
GROUP BY c.country, "customer"
)
WHERE "rank" = 1;
--12
SELECT t.name as "track", al.title as "album", ar.name as "artist" FROM track as t
LEFT JOIN album as al ON al.album_id = t.album_id
LEFT JOIN artist as ar ON ar.artist_id = al.artist_id
LEFT JOIN invoice_line as il ON il.track_id = t.track_id
WHERE il.invoice_id IS NULL













