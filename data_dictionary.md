# Data Dictionary

There are two data sets produced by the script in this repository.  The first is a tidy version of a subset of human activity data collected using Samsung smart phones which I will call *Activity Data*.  The second is some analytic results draw from the first set also in a tidy format which I will call *Analysis Results*.  There are two variables in common across the sets.  Other variable names are drawn directly from the raw data or are built in the raw data names.

## Activity Data

The raw data was collected using the accelerometer and gyroscope internal to a Samsung Galaxy SII smartphone worn on the waist of thirty volunteers who performed a variety of physical activities.  Linear acceleration and angular velocity in three dimensions were sampled on each phone at a constant rate.  The acceleration was split into gravity based acceleration and acceleration due to the movement of a volunteer.  Each set of measurements were also derived in time to obtain the corresponding *jerk* values over time.  Magnitudes of total acceleration and jerk were calcuated using the normal Euclidean measures.  Finally, some signals were also processed via Fast Fourier Transform to produce corresonding frequency domain signals.

For the purposes of creation of this dataset we only selected the signal mean and standard deviation for each measurement.  Several other values were calculated and are in the raw data.  Futher details on raw data collection and the processing described above can be found in the accompaning file *raw_data_README.txt* .  Details on other variables calculated from the signals are in *raw_data_feature_feature_info.txt*.  These files are provided in the raw data set as well (although there the prefix 'raw_data_' is not used).

As a result the majority of the variable names in the activity data can be easily deconstructed to learn the data being observed.

### Component Variable Names

Most variable names are built of the following components:
	* **t**: A leading t indicates a time domain variable.
	* **f**: A leading f indicates a frequency domain variable.
	* **Body**: Indicates a body motion variable.
	* **Gravity**: Indicates a Gravity variable.
	* **Gyro**: Indicates a gyroscope angular velocity variable.
	* **Acc**: Indicates an acceleration variable.
	* **Jerk**: Indicates a jerk (acceleration first derivative) variable.
	* **X**, **Y**, **Z**: Indicate a variable measured along the corresponding axis
	* **Mag**: Indicates a magnitude variable covering all three axis.
	* **mean()**: Indicates the mean of the signal strength for the value.
	* **std()**: Indicates the standard deviation of the signal strength for the value.

For example, *tBodyAcc-Y* indicates the time domain(t) measurement of body movement induced(Body) acceleration(Acc) on the Y(Y) access.

### Non-component named variables

The two variables that do not comform to this format are in columns 1 and 2:
	1. **subject**: An integer from 1 to 30 indiciating which volunteer produced the measured signal.
	2. **activity**: A descriptive name of thea activity during which the signal was produced.

## Analysis Results

The analysis aggregated all signal measurements by volunteer subject and activity.  Thus, each row provides data for all measurements for a given subject and activity pair.  The method of aggregation in call cases was the mean of the available observations for that variable.

### Component Variable Names

Component variable names use the same system as the *Activity Data* described above.  In the *Analysis Results* they are prefixed with "Mean_of_" to indicate the method of aggregation.

### Non-component named variables
These are identical to the variables used in the *Activity Data*.  Remember, however, here they also serve as groups for aggregation.
