# Load required libraries
library(ggplot2)
library(viridis)
library(dplyr)
library(lubridate)
library(dplyr)


# get some acc data

data <- data.frame(demodata)

# Ensure the 'V2' column is numeric
data$V2 <- as.numeric(data$V2)

# Initial start time and desired start time
initial_start_time <- as.POSIXct("1997-04-22 09:38:00", format = "%Y-%m-%d %H:%M:%S")
desired_start_time <- as.POSIXct("1997-04-23 06:00:00", format = "%Y-%m-%d %H:%M:%S")

# Calculate the difference in minutes
time_difference <- as.numeric(difftime(desired_start_time, initial_start_time, units = "mins"))

# Calculate the number of rows to skip
rows_to_skip <- time_difference

# Remove the first 'n' rows
data <- data[-(1:rows_to_skip), ]

# Number of rows in the updated data
num_rows <- nrow(data)

# Create a new sequence of dates every minute starting from the desired start time
time_sequence <- seq(from = desired_start_time, by = "min", length.out = num_rows)
data$time <- time_sequence

# Aggregate the data by 10-minute bins
aggregated_data <- data %>%
  mutate(time_bin = cut(time, breaks = "10 min")) %>%
  group_by(time_bin) %>%
  summarise(acc = mean(V2, na.rm = TRUE))
plot(data$time, data$V2)
plot(aggregated_data)

aggregated_data<-aggregated_data[c(1:432),]
plot(aggregated_data$acc)
####################################



# make the sine waves
color_values <- aggregated_data [c(1:1440),]

# Function to generate data for a single wave
generate_wave_data <- function(num_points_per_cycle) {
  # Generate x-values for one cycle
  x_cycle <- seq(0, 2 * pi, length.out = num_points_per_cycle)
  
  # Calculate y-values based on a sine wave for one cycle
  y_cycle <- sin(x_cycle) * 100
  
  # Generate random color values for each point
  #color_values <- runif(num_points_per_cycle, min = 0, max = 1)
  
  data.frame(x = x_cycle, y = y_cycle, color = color_values)
}

# Number of cycles per wave
num_cycles_per_wave <- 3

# Number of points per cycle
num_points_per_cycle <- 1440  # 1440 units per cycle

# Generate data for all waves
all_data <- lapply(1:num_cycles_per_wave, function(wave) {
  # Generate data for current wave
  wave_data <- generate_wave_data(num_points_per_cycle)
  wave_data$wave <- wave  # Add wave number
  wave_data$x <- wave_data$x + 2 * pi * (wave - 1)  # Shift x values for each wave
  wave_data
})

# Combine data for all waves
combined_data <- do.call(rbind, all_data)

# Plot all waves in a single geom_path() call
ggplot(combined_data, aes(x = x, y = y, color = color, group = wave)) +
  geom_path(size = 5) +
  scale_color_viridis(option="inferno") +  # Use default viridis color palette
  scale_y_continuous(limits = c(-100, 100), breaks = seq(-100, 100, by = 20)) +
  theme_minimal() +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    legend.position = "none",  # Suppress legend
    panel.grid.major = element_blank(),  # Remove major gridlines
    panel.grid.minor = element_blank()   # Remove minor gridlines
  )




# Function to generate data for three waves
generate_three_waves_data <- function(num_points_per_cycle, num_segments_per_cycle) {
  # Function to generate data for a single wave with given number of segments
  generate_wave_data <- function(num_points_per_cycle, num_segments_per_cycle) {
    x_cycle <- seq(0, 2 * pi, length.out = num_points_per_cycle)
    y_cycle <- sin(x_cycle) * 100
    color_values <- runif(num_segments_per_cycle, min = 0, max = 1)
    segment_data <- lapply(1:num_segments_per_cycle, function(i) {
      x_start <- x_cycle[i * (num_points_per_cycle / num_segments_per_cycle)]
      x_end <- x_cycle[(i + 1) * (num_points_per_cycle / num_segments_per_cycle)]
      y_start <- y_cycle[i * (num_points_per_cycle / num_segments_per_cycle)]
      y_end <- y_cycle[(i + 1) * (num_points_per_cycle / num_segments_per_cycle)]
      data.frame(x = c(x_start, x_end), y = c(y_start, y_end), color = color_values[i])
    })
    return(do.call(rbind, segment_data))
  }
  
  # Generate data for three waves
  wave1_data <- generate_wave_data(num_points_per_cycle, num_segments_per_cycle)
  wave1_data$wave <- 1
  
  wave2_data <- generate_wave_data(num_points_per_cycle, num_segments_per_cycle)
  wave2_data$wave <- 2
  wave2_data$x <- wave2_data$x + 2 * pi  # Shift x values for the second wave
  
  wave3_data <- generate_wave_data(num_points_per_cycle, num_segments_per_cycle)
  wave3_data$wave <- 3
  wave3_data$x <- wave3_data$x + 4 * pi  # Shift x values for the third wave
  
  return(rbind(wave1_data, wave2_data, wave3_data))
}

# Number of segments per cycle (180 segments)
num_segments_per_cycle <- 180

# Generate data for three waves with 180 segments each
three_waves_data <- generate_three_waves_data(num_points_per_cycle, num_segments_per_cycle)

# Plot the three waves
ggplot(three_waves_data, aes(x = x, y = y, xend = lead(x), yend = lead(y), color = color)) +
  geom_segment(size = 10) +
  scale_color_viridis(option="inferno") +
  scale_y_continuous(limits = c(-100, 100), breaks = seq(-100, 100, by = 20)) +
  theme_minimal() +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    legend.position = "none",
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )


#####################################  wed  ####

library(ggplot2)
library(dplyr)
library(viridis)
library(lubridate)
library(scales)  # For rescale

generate_three_waves_data <- function(num_points_per_cycle, num_segments_per_cycle) {
  generate_wave_data <- function(num_points_per_cycle, num_segments_per_cycle) {
    x_cycle <- seq(0, 2 * pi, length.out = num_points_per_cycle + 1)
    y_cycle <- sin(x_cycle) * 100
    segment_data <- data.frame(
      x_start = x_cycle[-length(x_cycle)],
      x_end = x_cycle[-1],
      y_start = y_cycle[-length(y_cycle)],
      y_end = y_cycle[-1]
    )
    return(segment_data)
  }
  
  wave1_data <- generate_wave_data(num_points_per_cycle, num_segments_per_cycle)
  wave1_data$wave <- 1
  
  wave2_data <- generate_wave_data(num_points_per_cycle, num_segments_per_cycle)
  wave2_data$wave <- 2
  wave2_data$x_start <- wave2_data$x_start + 2 * pi
  wave2_data$x_end <- wave2_data$x_end + 2 * pi
  
  wave3_data <- generate_wave_data(num_points_per_cycle, num_segments_per_cycle)
  wave3_data$wave <- 3
  wave3_data$x_start <- wave3_data$x_start + 4 * pi
  wave3_data$x_end <- wave3_data$x_end + 4 * pi
  
  return(rbind(wave1_data, wave2_data, wave3_data))
}

num_points_per_cycle <- 144
num_segments_per_cycle <- 144
three_waves_data <- generate_three_waves_data(num_points_per_cycle, num_segments_per_cycle)


# Example aggregated data (replace with your actual aggregated_data)
aggregated_data2 <- data.frame(
  time_bin = seq(from = as.POSIXct("1997-04-22 06:00:00"), by = "10 mins", length.out = num_segments_per_cycle*3),
  acc = aggregated_data[c(1:(num_segments_per_cycle*3)),]
)

# Normalize the `acc` values to range [0, 1] for coloring
aggregated_data2$color <- rescale(aggregated_data2$acc.acc, to = c(0, 1))


summary(transformed_color)

# Repeat the color values to match the length of the three_waves_data
three_waves_data$color <- rep(aggregated_data2$color, length.out = nrow(three_waves_data))


# Apply a transformation to amplify the variation in the color index variable
transformed_color <- log(three_waves_data$color+0.00001)

plot <- ggplot(three_waves_data, aes(x = x_start, y = y_start, xend = x_end, yend = y_end, color = transformed_color)) +
  geom_segment(size = 4) +
  scale_color_viridis_c(option = "inferno", limits = range(transformed_color) +
  scale_y_continuous(limits = c(-100, 100), breaks = seq(-100, 100, by = 20)) +
  theme_minimal() +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    legend.position = "none",
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )
)+
  theme_void()  +
  guides(color = FALSE)

# Save the plot as SVG
ggsave("plot.svg", plot, width = 10, height = 2, units = "in", dpi = 300)
write.csv(demodata,file="data.csv")