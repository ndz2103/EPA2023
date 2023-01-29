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
    <td>anes_gss2020data.csv</td>
    <td>Merged ANES and GSS data with all variables</td>
   <tr>
    <td>anes_gss2020clean.csv</td>
    <td>Merged ANES and GSS data with variables of interest only</td>
  </tr>
  <tr>
    <td>EPA2023_analysis.R</td>
    <td>R file consisting of data merging, cleaning, and analyses</td>
  <tr>  
    <td>EPA2023_Environment.RData</td>
    <td>RData file consisting of R studio environment necessary to complete the analyses in EPA2023_analysis.R</td>
  </tr>
  <tr>
    <td>EPA2023_Proposal</td>
    <td>Word document containing the long and short abstract of my EPA2023 submission</td>
  </tr>
</table>

## Instructions for Download

### Pre-Processing the Data

For pre-processing and analyzing the data, I used the R packages readr, haven, dplyr, and tidyr. Visualizations were created using ggplot2. 

To import the supplied RData file containing the necessary R environment, first open the EPA2023_analysis.R file. Next, navigate to the "environment" pane and select the icon in the top-left corner of the designated area. This allows you to load an R environment. Navigate to and open EPA2023_Environment.RData, which contains the raw ANES (anes) and GSS (gss) data, the merged raw data (gss_anes), and the pre-processed data (data).

To start from scratch, import the ANES and GSS raw data files attached to this repository into your R Studio environment. Once this data is loaded into the environment, first filter the gss data frame so that the variable "anesid" is greater than 0. A non-zero positive integer in this variable indicates that a GSS participant was part of the ANES-GSS 2020 Joint Study. 

Next, reorder the gss data frame so that "anesid" is organized numerically. Do the same reordering to the anes data frame such that the variable "V200001"(the same identifier found in the gss data frame) is organized numerically.

Once each data frame is organized numerically by their ID, merge the data frames using the cbind() function. This data frame, called gss_anes, is attached to the repository as anes_gss2020data.csv.

Using the gss_anes data frame, select the following dependent and control variables:

**INSERT TABLE OF VARIABLES HERE**

### Software, Packages, and Applications for Wrangling and Analysis

I used RStudio (2022.07.1) as my statistical software for this activity. The wrangling and analyses conducted in the reposited files required the installation and use of several R packages including readr, tidyr, and dplyr. 

The attached document files were created in Microsoft Word, where tables and regression outputs in the R Console were copy-and-pasted. Another word document file such as .rtf, .txt, .pages, or Google Document would be equally as effective. These word documents were then exported as .pdf files for best distribution.

## Other Requirements

### Time

This acitivity spanned roughly 2-3 weeks in length. However, wrangling, analysis, and documentation took roughly 5-8 hours total. 

### Computing 

The wrangling, analysis, and documentation required of this activity was done on macOS Monterey v 12.6 with a 2.6 GHz 6-Core Intel Core i7 processer and 16 GB 2400 MHz DDR4 memory. 
