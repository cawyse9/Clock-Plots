# Sleep-Bubbles:  Using color and shape to visualise sleep duration and variation

## Background</summary>
<img align="right" width=300 src="https://user-images.githubusercontent.com/29300100/195515257-780e10eb-f95e-45d9-95ed-c7a42a74e612.png">
Wrist-worn sensors allow physical activity, sleep and circadian rhythms to be monitored unobtrusively over long time periods, and can reveal patterns that cannot be detected in datasets collected over days. 

</details>
 
##  Methods
<img align="right" width=170 src="https://user-images.githubusercontent.com/29300100/195515689-7d6a3329-e15d-4f60-a135-1f171d68037d.png">
Daily physical activity was monitored using a triaxial accelerometer (Geneactiv, UK) worn on the wrist for one year.
$~$
Data are measurements of gravity (g) in three axes (x, y, z) sampled at 100Hz.  The Euclidean norm (square root of the sum of the squares) of these measurements was used to summarise the information at each time point and the data were binned to 1 minute or 1 hour epochs.  These data are taken to approximate human activity over 24h.  The R package ggplot2 was used to contruct polar plots of activity against time with epoch represented by tiles or segments.  The level of activity was shown by a colour gradient using the viridis package. Axes and tick mark labels were customised to improve the aesthetic quality of the plot.  This allowed the changes in daily locomotor activity and variations in circadian rhythms over the 7 days of recording to be visualized.

The R-code is here:  

[Processing and cleaning accelerometery raw data](/analysis/Spirals_data_cleaning.R)  

[Plotting a sleep spiral in segments or tiles](/analysis/Spirals_plotting.R)  

[Batch plotting sprials](https://github.com/cawyse9/Sleep-Spirals/blob/main/analysis/Spirals_batch%20plot.R)  
