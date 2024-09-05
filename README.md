# CoreDataEngineers ETL Process & SQL Tasks

# The Architectural Diagram for the ETL process is as shown below

   ![alt text](data-flow-image.png)

This repository provides the complete solution for the ETL (Extract, Transform, Load) process and SQL tasks assigned to a data engineer at CoreDataEngineers. It includes detailed Bash scripts to handle the ETL process and SQL queries for analyzing the dataset.


### Project Overview

CoreDataEngineers uses a Linux-based infrastructure. The task involves automating data operations using Bash scripts and PostgreSQL for database management. The ETL process includes downloading a CSV file, transforming it, and loading the data into a PostgreSQL database for further analysis.


### Folder Structure

```
├── README.md               # Project documentation
├── Scripts                 # Main folder containing Bash and SQL scripts
│   ├── Bash                # Bash scripts for ETL and file management
│   │   ├── etl_script.sh       # Bash script for the ETL process
│   │   ├── move_files.sh       # Script for moving CSV/JSON files
│   └── SQL                 # SQL scripts for data analysis
│       ├── query_1.pgsql         # SQL Query 1 (Orders over 4000)
│       ├── query_2.pgsql         # SQL Query 2 (Standard_qty = 0)
│       ├── query_3.pgsql         # SQL Query 3 (Company names)
│       └── query_4.pgsql         # SQL Query 4 (Sales rep and regions)
├── .pgpass                 # PostgreSQL password file for secure access
└── cron.txt                # Cron job scheduling file
```


### 1. Bash Scripts

#### ETL Script: etl_script.sh

Description:
This script automates the ETL process, performing the following steps:

    Extract: Downloads the source CSV file into a raw folder.
    Transform: Renames the Variable_code column and selects relevant columns (Year, Value, Units, variable_code) to create a new CSV file in the transformed folder.
    Load: Moves the transformed CSV file into the gold folder.

How to Run:

Make sure the script has executable permissions by running the command below:

chmod +x etl_script.sh

Run the ETL script using the command below:

./etl_script.sh

Extract Process:

The script copies the CSV file from the given source directory to the raw folder and confirms successful extraction

Transform Process:

The script transforms the file by renaming a specific column which is Variable_code by replacing 'V' with 'v' and saving only the relevant columns (Year, Value, Units, variable_code) into a new CSV file in the transformed folder.

Load Process:

The transformed file is moved to the gold folder to complete the ETL pipeline.


#### File Moving Script:  move_files.sh

Description:

This script transfers all .csv and .json files from a source directory to a target directory.

Run the scripts using the commands below one after the other:

chmod +x move_files.sh
./move_files.sh

Script functionality:

- It checks if the destination directory exists and creates it if necessary.

- It moves all CSV and JSON files from the source directory to the json_and_CSV folder.



#### PostgreSQL Data Load Script: data_to_postgres.sh

Description:

This script iterates over each CSV file in the specified directory and loads the data into the PostgreSQL orders, accounts, web_events, sales_rep and region tables one after the other.

Ensure the script is executable by running the below command:

chmod +x load_to_postgres.sh

Run the below per each table load:

./data_to_postgres.sh


### 2. SQL Queries

#### Query 1: Orders over 4000 units 

File: Query_1.pgsql

Finds a list of order IDs where either gloss_qty or poster_qty is greater than 4000. Only include the id field in the resulting table.


#### Query 2: Orders with Standard_qty = 0 and gloss_qty or poster_qty over 1000

File: Query_2.pgsql

Finds orders where standard_qty is zero, and either gloss_qty or poster_qty is over 1000.


#### Query 3: Company Names Starting with 'C' or 'W' and containing 'ana' but not 'eana' 

File: Query_3.pgsql 

Finds all the company names that start with a 'C' or 'W', and where the primary contact contains 'ana' or 'Ana', but does not contain 'eana'.

#### Query 4: Region, Sales Rep, and Account Names

File: Query_4.pgsql

Provides a table showing the region for each sales rep along with their associated accounts. The table should have columns for region name, sales rep name, and account name. The accounts should be sorted alphabetically.


### 3. Secure PostgreSQL Password Management

The .pgpass file is used to securely store PostgreSQL credentials, preventing password exposure in the script.

- Created a .pgpass file in the project working directory and secure store my database password in it.

- Added the the posey database password content to the file

- Ensured correct permissions for the .pgpass file by running the command below:

  chmod 600 .pgpass

- Modified the Bash script to remove the password from the command and automatically pull from .pgpass.


### 4. Cron Job Scheduling

To run the ETL process automatically every day at 12:00 AM, I scheduled a cron job.

#### Steps:

Open the crontab editor by running the command below:

crontab -e

Add the following line to schedule the script:

0 0 * * * /path/to/etl_script.sh


Note: represent the path to the ETL script, as this was replaced by the path to directory where I have my etl script

Save and exit. The ETL script will now run daily at midnight.



## Conclusion

This project demonstrates a simple yet effective ETL pipeline using Bash scripts, along with SQL queries for data analysis. The solution ensures password security for database access and allows automation through cron jobs.



