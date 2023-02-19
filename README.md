# EPA2023

This is a repository for my Eastern Psychological Association 2023 poster submission. I will be presenting this research on March 3rd, 2023 in Boston, MA. 

## Acitvity Description

This study investigates the impact of intergroup contact in informing feelings about LGBT people. 1,164 participants completed survey items measuring their conservatism, religiosity, and support for LGBT people. Results show that conservatives and religious people are more likely to view LGBT people unfavorably and disapprove of same-sex marriage. However, LGBT favorability is moderated through intergroup contact with an LGBT person, but this is not the case for LGBT policy. The findings suggest intergroup contact informs attitudes about LGBT people, but not policy support.

## Data Description

### Data Source Availability Statement

Data used in this exercise were obtained through the American National Election Studies[(ANES)](https://electionstudies.org/data-center/anes-gss-2020-joint-study/) and General Social Survey[(GSS)](https://gss.norc.org/getthedata/Pages/SAS.aspx) websites. Access is restricted for statistical and research purposes. To downloadd the data, you must first create a free account on each data base.Thee terms of use for each dataset can be found on the organizations' websites.

### Codebook and Data

The ANES-GSS joint study was conducted in 2020, however, there is not concatenated dataset for download. Therefore, you must download each organization's half of the data using the links in the section above and merge them on your own. 

Access to the codebook for the ANES 2020 timeseries data can be found [here](https://acrobat.adobe.com/link/review?uri=urn:aaid:scds:US:fb8bc509-8b72-380e-856d-a048ea9e0b71). Similarly, the codebook for the GSS 2016-2020 panel data can be viewed [here](https://acrobat.adobe.com/link/review?uri=urn:aaid:scds:US:b2d60355-2576-3cc7-ae56-724d3ef88d7e).

### Citation

American National Election Studies. 2022. ANES-GSS 2020 Joint Study [dataset and documentation]. April 8, 2022 version. www.electionstudies.org

Davern, Michael; Bautista, Rene; Freese, Jeremy; Morgan, Stephen L.; and Tom W. Smith. General Social Survey
2016-2020 Panel. [Machine-readable data file]. Principal Investigator, Michael Davern; Co-Principal
Investigators, Rene Bautista, Jeremy Freese, Stephen L. Morgan, and Tom W. Smith. NORC ed. Chicago, 2021.
1 datafile (5,125 cases) and 1 codebook (4,586 pages).

## Files Included

<table>
  <tr>
    <th>File Name</th>
    <th>Description</th> 
  </tr>
  <tr>
    <td>gss2020panel_r1a.sas7bdat</td>
     <td>Raw GSS 2016-2020 panel data as a SAS file</td>
  <tr/>
  <tr>
    <td>anes_timeseries_2020_gss_csv_20220408.csv</td>
    <td>Raw ANES 2020 time-series data as a CSV file</td>
  </tr>
  <tr>
    <td>anes_gss2020clean.csv</td>
    <td>Merged ANES and GSS data processed and cleaned</td>
  </tr>
  <tr>
    <td>anes_gss2020regression.csv</td>
    <td>Merged ANES and GSS data processed and cleaned containing only complete cases</td>
  <tr>  
    <td>EPA2023_RawEnviron.RData</td>
    <td>RData file consisting of R studio environment with raw data for reproducibility check</td>
  </tr>
  <tr>
    <td>EPA2023_Environ.RData</td>
    <td>RData file consisting of R sttudio environemtn with cleaned and regression-ready data for analysis</td>
  </tr>
  <tr>
    <td>EPA2023.R</td>
    <td>R file containing code for data processing, cleaning, analysis, and visualization</td>
  </tr>
  <tr>
    <td>EPA2023_report.pdf</td>
    <td>PDF file functioning as project program report with code, visuals, and rationale of throughout research process</td>
  </tr>
  <tr>
    <td>EPA2023_proposal.pdf</td>
    <td>PDF file containing short and long abstract of EPA 2023 proposal</td>
  </tr>
  <tr>
    <td>References</td>
    <td>Git document of references used in EPA 2023 proposal and presentation</td>
  </tr>
</table>

## Instructions

For pre-processing and analyzing the data, I used R packages including readr, haven, dplyr, and tidyr. Visualizations were created using ggplot2.

To import the supplied RData file containing the necessary R environment, first open the EPA2023.R file. Next, navigate to the "environment" pane and select the icon in the top-left corner of the designated area. This allows you to load an R environment. Navigate to and open EPA2023_RawEnviron.RData, which contains the raw ANES (anes) and GSS (gss) data for reproducibility. 

### Processing

To start from scratch, import the EPA2023_RawEnviron.RData file which contains the raw ANES (anes) and GSS (gss) data. First, filter the data frame gss so that the variable "anesid" is greater than 0. This variable indicates that a respondent completed the joint ANES-GSS 2020 survey. Next, order the anes and gss data frames by ID. The variable "V200001" in the anes data frame is the same as the variable "anesid" in the gss data frame. Once these data frames are ordered numerically, we can bind them using the cbind() function to create a concatenated data frame of the raw data. 

To select the variables of interest, use the select() function. Once selected, use the rename() function to rename the variables so they are understandable. The following predictor and control variables and their descriptions are as follows:

<table>
  <tr>
    <th>Variable Name</th>
    <th>Value range</th>
    <th>Rename</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>AGE_1A</td>
    <td>continuous</td>
    <td>age</td>
    <td>Respondent age</td>
  </tr>
  <tr>
    <td>SEX_1A</td>
    <td>1 = male, 2 = female</td>
    <td>sex</td>
    <td>Respondent sex</td>
  </tr>
  <tr>
    <td>RACE_1A</td>
    <td>1=White, 2=Black, 3=other</td>
    <td>race</td>
    <td>Respondent race</td>
  </tr>
  <tr>
    <td>SEXORNT_1A</td>
    <td>1 = homosexual, 2 = bisexual, 3 = straight</td>
    <td>sexori</td>
    <td>Respondent sexual orientation</td>
  </tr>
  <tr>
    <td>ATTEND_1A</td>
    <td>0 = never to 8 = several times a week
    <td>relig_attend</td>
    <td>Religiosity measured as religious service attendance</td>
  </tr>
  <tr>
    <td>MARHOMO1_1A</td>
    <td>1 = strongly agree to 5 = strongly disagree</td>
    <td>equal_mar</td>
    <td>Approval of marriage equality</td>
  </tr>
  <tr>
    <td>POLVIEWS_1A</td>
    <td>1 = extremely liberal to 7 = extremely conservative</td>
    <td>poli</td>
    <td>Political ideology</td>
  </tr>
  <tr>
    <td>V202166</td>
    <td>0 = disfavor to 100 = favor</td>
    <td>feel_LGB</td>
    <td>Feeling thermometer of Lesbian, Gay, and Bixsexual persons</td>
  </tr>
  <tr>
    <td>V202172</td>
    <td>0 = disfavor to 100 = favor</td>
    <td>feel_T</td>
    <td>Feeling thermometer of Transgender persons</td>
  </tr>
  <tr>
    <td>V202471</td>
    <td>1 = know, 2 = don't know</td>
    <td>know_LGB</td>
    <td>know a Lesbian, Gay, or Bisexual person</td>
  </tr>
  <tr>
    <td>V202473</td>
    <td>0 = know, 2 = don't know</td>
    <td>know_T</td>
    <td>know a Transgender person</td>
  </tr>
</table>

Using the lapply() function, reclassify the variables of interest to a numeric class. Once this is done, complete the following processing changes:

1) reverse code equal_mar so those who support marriage equality have a higher score than those who don't.
2) filter any respondent with an age < 18 years old.
3) recode feel_LGB and feel_T so that any 0 values = NA.
4) recode know_LGB and know_T so that any values < 0 = NA and any 2 values = 0.
5) create a new variable called "feel_LGBT" which is the average of the feel_LGB and feel_T columns to create an aggregated feeling thermometer score (0 to 100).
6) create a new variable called "know_LGBT" which is the average of the know_LGB and know_T columns to crease an aggregated feeling thermometer score (0 to 1).

This file constitutes the anes_gss2020clean.csv file found in EPA2023_Environ.RDdata.

### Correlations

Import a [custom function](https://www.r-bloggers.com/2020/07/create-a-publication-ready-correlation-matrix-with-significance-levels-in-r/) created by Paul van der Laken (2020), to create a publication-ready correlation matrix in R. 

Using the anes_gss2020clean.csv data, create a data frame consisting of only the variables poli, relig_attend, equal_mar, feel_LGBT, and know_LGBT. Now using the custom function correlation_matrix(), create a data frame of the function output. 

Import the linrary gridExtra to export this data frame as a PDF file. First, use the pdf() function and specify the path, along with the dimensions of the PDF (I chose height = 4 and width = 12). Then use the grid.table() function and specify that you want to use the data frame of the correlation matrix. To fully render the PDF at the location you specify, use the function dev.off(). 

This creates a correlation matrix of the variables of interest. 

To get the specific p-values, t-values, and r of the correlations of interest, use the cor.test() function on the anes_gss2020clean data frame. Get the correlations of relig_attend X poli, relig_attend & poli X equal_mar, and relig_attend & poli X feel_LGBT. 

### Regression

For regression modeling, create a data frame from the anes_gss2020clean data frame that contains only complete.cases. The product of this constitutes the anes_gss2020regression.csv file. Specify this data frame in the regression equations.

**Marriage Equality**
1) linear regression: y = equal_mar and x's = relig_attend, poli, age, sex, race, and sexori.
2) linear regression: y = equal_mar and x's = (relig_attend X know_LGBT), (poli X know_LGBT), age, sex, race, and sexori.
3) anova of both models. 

**LGBT Favorability**
1) linear regression: y = feel_LGBT and x's = relig_attend, poli, age, sex, race, and sexori.
2) linear regression: y = feel_LGBT and x's = (relig_attend X know_LGBT), (poli X know_LGBT), age, sex, race, and sexori.
3) anove of both models. 

### Data Visualization

Import the ggplot2 package. Using the attach() function, specify the anes_gss2020regression data frame. 

Personally, I was having difficulty using the predict() function to plot the regression lines of my models. As a last resort, I manually wrote the regression equations as a custom function and specified the variables. The regression equation followed the following pattern, where B1 and B2 are the coefficients of interest and k represents the controls. 

y = intercept + B1(relig_attend) + B2(poli) + k
y = intercept + B1(relig_attend X know_LGBT) + B2(poli X know_LGBT) + k

Using the regression functions following the pattern above, input the variables in the order that their coefficients are shown so that the variable is paired with the proper coefficient. Using the 4 regression functions, create 4 new columns of predicted values. 

**Marriage Equality**

To plot the regression lines associated with marriage equality, use the ggplot() function and specify the x aesthetic as the interaciton between poli and know_LGBT and the y aesthetic as equal_mar. 

Using the geom_jitter() geometry, specify jitter width and height along with point characteristics. Then using the stat_smooth() geometry, specify the parameter geom as "line", the x aesthetic as the interaction between poli and know_LGBT, and the y aesthetic as the predicted values of the non-interaction model. Finally, use the geom_smooth() geometry to plot the interaction model, specifying the x aesthetic as the interaction between poli and know_LGBT and y aesthetic of the corresponding interaction model's predicted values. In the geom_jitter(), stat_smooth(), and geom_smooth() geometries, you can specify parameters like standard error, alpha, and color to preference. Additional geometries like labels and annotations can be added as well. 

**LGBT Favorability**

To plot the regression lines associated with LGBT favorability follow the same steps as above, but set the ggplot() y aesthetic to feel_LGBT, and the stat_smooth() and geom_smooth y aethetics to their corresponding predicted values. 

### Software, Packages, and Applications for Wrangling and Analysis

I used RStudio (2022.12.0+353) as my statistical software for this activity. The wrangling and analyses conducted in the reposited files required the installation and use of several R packages including readr, tidyr, and dplyr. 

## Other Requirements

### Time

Total processing time takes less than an hour. Starting from scratch takes approximately 2-3 hours if unacquainted with the data.

### Computing 

The wrangling, analysis, and documentation required of this activity was done on macOS Ventura v 13.2.1 with a 2.6 GHz 6-Core Intel Core i7 processer and 16 GB 2400 MHz DDR4 memory. 
