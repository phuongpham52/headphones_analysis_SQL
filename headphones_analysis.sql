--Top 10 highest rated headphones
SELECT Brand, 
Model, 
"Battery (hrs)",
"Avg Rating"
FROM headphones
ORDER BY "Avg Rating" DESC
LIMIT 10;