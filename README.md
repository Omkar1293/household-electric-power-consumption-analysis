# household-electric-power-consumption-analysis
Household Electric Power Consumption Analysis
This project analyzes household electric power consumption data, focusing on trends in global active power, voltage, and energy sub-metering. The dataset is sourced from the UCI Machine Learning Repository. The analysis includes downloading, preprocessing, filtering, summarizing, and visualizing the data.

Features
Automatic Dataset Handling:
Downloads and extracts the dataset directly from the UCI repository.
Handles missing data and validates filtered subsets.
Data Analysis:
Generates summary statistics for household power consumption.
Filters data for a specific date range (e.g., 1st to 2nd February 2007).
Visualizations:
Time series plots for:
Global active power.
Voltage.
Energy sub-metering.
Prerequisites
Software
R: Ensure R is installed on your system.
RStudio (optional): Recommended for an interactive environment.
R Libraries
Install the required libraries before running the script:

R
Copy code
install.packages(c("tidyverse", "lubridate"))
Dataset
The dataset is automatically downloaded from the UCI repository:

Dataset URL: https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
If the automatic download fails, you can manually download and extract the file:

Download the ZIP file from the dataset URL.
Extract household_power_consumption.txt to your desired location.
Update the file_path variable in the script to point to the extracted file.
How to Run
Clone the Repository:

bash
Copy code
git clone https://github.com/your-username/household-power-analysis.git
Run the Script:

Open household_power_consumption_analysis.R in R or RStudio.
Execute the script step-by-step or all at once.
Outputs:

Filtered dataset: filtered_household_power_consumption.csv.
Summary statistics: household_power_consumption_summary.csv.
Visualizations: Displayed in the RStudio Plots pane.
Visualizations
1. Global Active Power Over Time
A line graph showing the trend of global active power usage over time for the filtered date range.

2. Voltage Over Time
A line graph displaying voltage trends over time.

3. Energy Sub-Metering
A multi-line graph comparing sub-metering energy usage over time for different areas of the household.

Example Outputs
Summary Statistics:

Metric	Value
Average Global Power	1.234 kW
Maximum Voltage	246.7 V
Average Reactive Power	0.198 kW
Total Sub-Metering 1	12345 Wh
Total Sub-Metering 2	67890 Wh
Total Sub-Metering 3	54321 Wh
Known Issues
If the automatic download fails, ensure a stable internet connection or download the dataset manually.
Filtering dates outside the dataset's range will result in an error.
Contribution
Contributions are welcome! Please submit pull requests or issues for any improvements.

License
This project is licensed under the MIT License.

