# Load necessary libraries
library(tidyverse)
library(lubridate)

# Step 1: Download and Handle Dataset
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
temp_zip <- tempfile()
temp_dir <- tempdir()

# Attempt to download and unzip the dataset
tryCatch({
  message("Downloading dataset...")
  download.file(url, temp_zip, mode = "wb", timeout = 60)
  message("Unzipping dataset...")
  unzip(temp_zip, files = "household_power_consumption.txt", exdir = temp_dir)
}, error = function(e) {
  stop("Error downloading or unzipping the file. Ensure internet connectivity or download the file manually.")
})

# Define file path
file_path <- file.path(temp_dir, "household_power_consumption.txt")

# Check if the file exists
if (!file.exists(file_path)) {
  stop("File not found! Download or extraction may have failed.")
}

message("Dataset successfully downloaded and extracted.")

# Step 2: Load the Dataset
message("Loading dataset...")
data <- read.table(file_path, header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)

# Step 3: Data Preprocessing
message("Preprocessing data...")
data <- data %>%
  mutate(
    Datetime = dmy_hms(paste(Date, Time)),
    Global_active_power = as.numeric(Global_active_power),
    Global_reactive_power = as.numeric(Global_reactive_power),
    Voltage = as.numeric(Voltage),
    Sub_metering_1 = as.numeric(Sub_metering_1),
    Sub_metering_2 = as.numeric(Sub_metering_2),
    Sub_metering_3 = as.numeric(Sub_metering_3)
  ) %>%
  select(Datetime, Global_active_power, Global_reactive_power, Voltage, Sub_metering_1, Sub_metering_2, Sub_metering_3)

# Remove rows with missing values
data <- na.omit(data)

# Step 4: Filter Data for Specific Dates
message("Filtering data for specific dates (2007-02-01 to 2007-02-02)...")
data_filtered <- data %>%
  filter(Datetime >= "2007-02-01" & Datetime < "2007-02-03")

# Check if data is available for the specified dates
if (nrow(data_filtered) == 0) {
  stop("No data available for the specified date range. Please adjust the date range or check the dataset.")
}

# Step 5: Summary Statistics
message("Calculating summary statistics...")
summary_stats <- data_filtered %>%
  summarise(
    AvgGlobalActivePower = mean(Global_active_power, na.rm = TRUE),
    MaxVoltage = max(Voltage, na.rm = TRUE),
    AvgGlobalReactivePower = mean(Global_reactive_power, na.rm = TRUE),
    TotalSubMetering1 = sum(Sub_metering_1, na.rm = TRUE),
    TotalSubMetering2 = sum(Sub_metering_2, na.rm = TRUE),
    TotalSubMetering3 = sum(Sub_metering_3, na.rm = TRUE)
  )

print("Summary Statistics:")
print(summary_stats)

# Step 6: Visualizations
message("Generating visualizations...")

# 1. Global Active Power Over Time
ggplot(data_filtered, aes(x = Datetime, y = Global_active_power)) +
  geom_line(color = "blue") +
  labs(
    title = "Global Active Power Over Time",
    x = "Datetime",
    y = "Global Active Power (kilowatts)"
  ) +
  theme_minimal()

# 2. Voltage Over Time
ggplot(data_filtered, aes(x = Datetime, y = Voltage)) +
  geom_line(color = "green") +
  labs(
    title = "Voltage Over Time",
    x = "Datetime",
    y = "Voltage"
  ) +
  theme_minimal()

# 3. Energy Sub-Metering Over Time
data_filtered %>%
  pivot_longer(cols = starts_with("Sub_metering"), names_to = "Sub_metering", values_to = "Value") %>%
  ggplot(aes(x = Datetime, y = Value, color = Sub_metering)) +
  geom_line() +
  labs(
    title = "Energy Sub-Metering Over Time",
    x = "Datetime",
    y = "Energy Sub-Metering (watt-hour)"
  ) +
  theme_minimal() +
  scale_color_manual(values = c("red", "blue", "purple"))

# Step 7: Save Processed Data and Summary
message("Saving processed data and summary statistics...")
write.csv(data_filtered, "filtered_household_power_consumption.csv", row.names = FALSE)
write.csv(summary_stats, "household_power_consumption_summary.csv", row.names = FALSE)

message("Filtered data and summary statistics saved successfully.")
