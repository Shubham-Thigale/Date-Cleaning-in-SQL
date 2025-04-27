
# 🏡 Housing Data Cleaning Project (SQL)

## 📋 Project Overview
This project focuses on cleaning and preparing a raw real estate dataset for further analysis.  
The dataset contains housing sales data from Nashville, USA, with inconsistencies, missing values, duplicates, and unstructured text fields.

The goal was to transform messy, real-world data into a reliable, analysis-ready table using advanced SQL techniques.

---

## 🛠️ Skills and Tools
- Microsoft SQL Server (SSMS)
- SQL Data Cleaning Techniques
- CTEs (Common Table Expressions)
- Window Functions
- String Functions (TRIM, REPLACE, SUBSTRING)
- Date Manipulation
- Handling NULL Values
- Removing Duplicates

---

## 🧹 Cleaning Steps Performed

1. **Standardized Date Formats**  
   - Converted inconsistent sale dates to a uniform `DATE` format.

2. **Populated Missing Property Addresses**  
   - Filled missing property address records by matching parcel IDs.

3. **Separated Address Components**  
   - Split full addresses into Street Address, City, and State for better structure.

4. **Fixed Inconsistencies in Text Data**  
   - Standardized and trimmed owner names and other string fields.

5. **Removed Duplicate Records**  
   - Identified and deleted duplicate entries using `ROW_NUMBER()` window function.

6. **Dropped Unnecessary Columns**  
   - Removed unused columns to make the dataset lighter and more meaningful.

---

## 📈 Final Outcome
- A cleaned and structured housing dataset ready for analysis or dashboard visualization.
- Improved data quality, consistency, and reliability.
- Demonstrated ability to handle real-world messy data.

---

