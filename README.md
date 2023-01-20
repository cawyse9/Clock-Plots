# Sleep-Bubbles:  Using color and shape to visualise sleep duration and variation

## Background</summary>
Wrist-worn sensors allow physical activity, sleep and circadian rhythms to be monitored unobtrusively over long time periods, and can reveal patterns that cannot be detected in datasets collected over days. 

</details>
 
##  Methods
<img align="right" width=170 src="https://user-images.githubusercontent.com/29300100/195515689-7d6a3329-e15d-4f60-a135-1f171d68037d.png")
                                  
The One Year of Actigraphy (OYA) project is exploring new methods of sleep/circadian data analysis. The main target is to search for predictive algorithms from consecutive wrist actigraphy recordings of a free-living single subject using a MotionWatch8 (CamNtech Ltd) system on the non-dominant wrist for an entire year. The single subject was a 62 year-old male who wore the device between June 2016 and June 2017.
Daily physical activity was monitored using a triaxial accelerometer (Geneactiv, UK) worn on the wrist for one year.
$~$
Data are measurements of gravity (g) in three axes (x, y, z) sampled at 100Hz.  The Euclidean norm (square root of the sum of the squares) of these measurements was used to summarise the information at each time point and the data were binned to 1 minute or 1 hour epochs.  These data are taken to approximate human activity over 24h.  The R package ggplot2 was used to contruct polar plots of activity against time with epoch represented by tiles or segments.  The level of activity was shown by a colour gradient using the viridis package. Axes and tick mark labels were customised to improve the aesthetic quality of the plot.  This allowed the changes in daily locomotor activity and variations in circadian rhythms over the 7 days of recording to be visualized.

Citation and acknowledgement
When using this dataset, please cite the following:

Zhang GQ, Cui L, Mueller R, Tao S, Kim M, Rueschman M, Mariani S, Mobley D, Redline S. The National Sleep Research Resource: towards a sleep data commons. J Am Med Inform Assoc. 2018 Oct 1;25(10):1351-1358. doi: 10.1093/jamia/ocy064. PMID: 29860441; PMCID: PMC6188513.

Actigraphy Analysis Project: Predictive algorithms of individual wrist actigraphy for real life. (http://www.actigraphy.eu/actigraphy-analysis-project.html)

delucca, gianluigi. 2021. "Motionwatch8 Wrist Actimetry Data Analysis: From Ambulatory Recording to Real Life Monitoring." OSF Preprints. May 13. doi:10.31219/osf.io/pdctj.

Gianluigi G. Delucca. 2022. “ Motionwatch8 Wrist Activity and Light Analysis: from ambulatory recording toward real life monitoring.” OSF Preprints. June 24. doi.org/10.31219/osf.io/cdqxh.

Please include the following text in the Acknowledgements:

The National Sleep Research Resource was supported by the National Heart, Lung, and Blood Institute (R24 HL114473, 75N92019R002).

The R-code is here:  

[Processing and cleaning accelerometery raw data](/analysis/Spirals_data_cleaning.R)  

[Plotting a sleep spiral in segments or tiles](/analysis/Spirals_plotting.R)  

[Batch plotting sprials](https://github.com/cawyse9/Sleep-Spirals/blob/main/analysis/Spirals_batch%20plot.R)  
