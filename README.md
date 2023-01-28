# EPA2023

This is a repository for my Eastern Psychological Association 2023 poster submission. I will be presenting this research on March 3rd, 2023 in Boston, MA. 

## Acitvity Description

This study investigates the impact of intergroup contact in informing feelings about LGBT people. 1,164 participants completed survey items measuring their conservatism, religiosity, and support for LGBT people. Results show that conservatives and religious people are more likely to view LGBT people unfavorably and disapprove of same-sex marriage. However, LGBT favorability is moderated through intergroup contact with an LGBT person, but this is not the case for LGBT policy. The findings suggest intergroup contact informs attitudes about LGBT people, but not policy support.

## Data Description

### Data Source Availability Statement

Data used in this exercise were obtained through the American National Election Studies([(ANES)](https://electionstudies.org/data-center/anes-gss-2020-joint-study/) and General Social Survey([(GSS)](https://gss.norc.org/getthedata/Pages/SAS.aspx) websites. Access is restricted for statistical and research purposes. To downloadd the data, you must first create a free account on each data base.Thee terms of use for each dataset can be found on the organizations' websites.

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
    <td>RRWM_Instr_CodeOutputs_YT.pdf</td>
     <td>Document which contains instructions, tables, and logit regression output of original code           </td>
  <tr/>
  <tr>
    <td>RRWM_DataWrangling.R</td>
    <td>Contains R code to process data for analysis</td>
  </tr>
  <tr>
    <td>RRWM_DescStats.R</td>
    <td>Contains R code which creates frequency and proportion tables of predictor variables shown in RRWM_CodeOutputs_NZ.pdf</td>
   <tr>
    <td>RRWM_CodeOutputs_NZ.pdf</td>
    <td>Document which contains table and logit regression output of reproduced code–this differs from original code</td>
  </tr>
  </tr>
  <tr>
    <td>RRWM_Reprod.R</td>
    <td>Contains R code which successfully reproduces the RRWM_Instr_CodeOutputs_YT.pdf outputs</td>
  <tr>  
    <td>RRWM_RepDiffs.pdf</td>
    <td>Document which outlines differences between original code and reproduced code and identifies minor value assignment error; classifies activity reproducibility</td>
  </tr>
</table>

## Instructions for Download

### Pre-Processing the Data

Once .csv file of data is downloaded, import file titled "gss_12M0025_E_2017_c_31_F1.csv" into R environment. For efficiency, rename the folder to your desired title (i.e. GSS_data) and select the columns of interest for analysis. These columns include: SEX, AGEGR10, MARSTAT, VISMIN, EHG3_01B, and TOTCHDC. To remove missing data, set any value >= 96 within the data frame equal to NA.

Following the removal of missing values, conduct a brief recoding/one-hot encoding of the variables of focus for future logit regression. 

### Software, Packages, and Applications for Wrangling and Analysis

I used RStudio (2022.07.1) as my statistical software for this activity. The wrangling and analyses conducted in the reposited files required the installation and use of several R packages including readr, tidyr, and dplyr. 

The attached document files were created in Microsoft Word, where tables and regression outputs in the R Console were copy-and-pasted. Another word document file such as .rtf, .txt, .pages, or Google Document would be equally as effective. These word documents were then exported as .pdf files for best distribution.

## Other Requirements

### Time

This acitivity spanned roughly 2-3 weeks in length. However, wrangling, analysis, and documentation took roughly 5-8 hours total. 

### Computing 

The wrangling, analysis, and documentation required of this activity was done on macOS Monterey v 12.6 with a 2.6 GHz 6-Core Intel Core i7 processer and 16 GB 2400 MHz DDR4 memory. 
