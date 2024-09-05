/* Provide a table that shows the region for each sales rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) by account name. */
SELECT r.name AS region_name,
s.name AS sales_rep_name, 
a.name AS account_name 
FROM region r
JOIN sales_reps s ON r.id = s.id
JOIN accounts a ON s.id = a.sales_rep_id
ORDER BY a.name ASC;