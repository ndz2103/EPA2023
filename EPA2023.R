library(readr)
library(haven)
library(dplyr)
library(tidyr)
library(dplyr)
library(tidyr)
library(gridExtra)
library(ggplot2)

# functions -------------------------------------------------------------------------

#' correlation_matrix
#' Creates a publication-ready / formatted correlation matrix, using `Hmisc::rcorr` in the backend.
#'
#' @param df dataframe; containing numeric and/or logical columns to calculate correlations for
#' @param type character; specifies the type of correlations to compute; gets passed to `Hmisc::rcorr`; options are `"pearson"` or `"spearman"`; defaults to `"pearson"`
#' @param digits integer/double; number of decimals to show in the correlation matrix; gets passed to `formatC`; defaults to `3`
#' @param decimal.mark character; which decimal.mark to use; gets passed to `formatC`; defaults to `.`
#' @param use character; which part of the correlation matrix to display; options are `"all"`, `"upper"`, `"lower"`; defaults to `"all"`
#' @param show_significance boolean; whether to add `*` to represent the significance levels for the correlations; defaults to `TRUE`
#' @param replace_diagonal boolean; whether to replace the correlations on the diagonal; defaults to `FALSE`
#' @param replacement character; what to replace the diagonal and/or upper/lower triangles with; defaults to `""` (empty string)
#'
#' @return a correlation matrix
#' @export
#'
#' @examples
#' `correlation_matrix(iris)`
#' `correlation_matrix(mtcars)`
correlation_matrix <- function(df, 
                               type = "pearson",
                               digits = 3, 
                               decimal.mark = ".",
                               use = "all", 
                               show_significance = TRUE, 
                               replace_diagonal = FALSE, 
                               replacement = ""){
  
  # check arguments
  stopifnot({
    is.numeric(digits)
    digits >= 0
    use %in% c("all", "upper", "lower")
    is.logical(replace_diagonal)
    is.logical(show_significance)
    is.character(replacement)
  })
  # we need the Hmisc package for this
  require(Hmisc)
  
  # retain only numeric and boolean columns
  isNumericOrBoolean = vapply(df, function(x) is.numeric(x) | is.logical(x), logical(1))
  if (sum(!isNumericOrBoolean) > 0) {
    cat('Dropping non-numeric/-boolean column(s):', paste(names(isNumericOrBoolean)[!isNumericOrBoolean], collapse = ', '), '\n\n')
  }
  df = df[isNumericOrBoolean]
  
  # transform input data frame to matrix
  x <- as.matrix(df)
  
  # run correlation analysis using Hmisc package
  correlation_matrix <- Hmisc::rcorr(x, type = )
  R <- correlation_matrix$r # Matrix of correlation coeficients
  p <- correlation_matrix$P # Matrix of p-value 
  
  # transform correlations to specific character format
  Rformatted = formatC(R, format = 'f', digits = digits, decimal.mark = decimal.mark)
  
  # if there are any negative numbers, we want to put a space before the positives to align all
  if (sum(R < 0) > 0) {
    Rformatted = ifelse(R > 0, paste0(' ', Rformatted), Rformatted)
  }
  
  # add significance levels if desired
  if (show_significance) {
    # define notions for significance levels; spacing is important.
    stars <- ifelse(is.na(p), "   ", ifelse(p < .001, "***", ifelse(p < .01, "** ", ifelse(p < .05, "*  ", "   "))))
    Rformatted = paste0(Rformatted, stars)
  }
  # build a new matrix that includes the formatted correlations and their significance stars
  Rnew <- matrix(Rformatted, ncol = ncol(x))
  rownames(Rnew) <- colnames(x)
  colnames(Rnew) <- paste(colnames(x), "", sep =" ")
  
  # replace undesired values
  if (use == 'upper') {
    Rnew[lower.tri(Rnew, diag = replace_diagonal)] <- replacement
  } else if (use == 'lower') {
    Rnew[upper.tri(Rnew, diag = replace_diagonal)] <- replacement
  } else if (replace_diagonal) {
    diag(Rnew) <- replacement
  }
  
  return(Rnew)
}

# pre-processing ----------------------------------------------------------------

# filter so gss_anes participants remain

gss <- gss %>%
  filter(anesid > 0)

# sort anesid and V200001 numerically for seamless bind

anes <- anes[order(anes$V200001),]
gss <- gss[order(gss$anesid),]

# column bind gss and anes dfs

data <- cbind(gss, anes)

# data cleaning -----------------------------------------------------------

data <- select(data, c(AGE_1A, SEX_1A, RACE_1A, SEXORNT_1A, ATTEND_1A, MARHOMO1_1A,
                       POLVIEWS_1A, V202166, V202172, V202471, V202473))

# rename vars

data <- dplyr::rename(data, age = AGE_1A, sex = SEX_1A, race = RACE_1A, sexori = SEXORNT_1A, relig_attend = ATTEND_1A, 
                      equal_mar = MARHOMO1_1A, poli = POLVIEWS_1A, feel_LGB = V202166, feel_T = V202172,
                      know_LGB = V202471, know_T = V202473)

# columns to numeric

data[,1:11] <- lapply(data[,1:11], as.numeric)

# recode equal mar so low to hi support

data$equal_mar <- (6-data$equal_mar)

# wrangle missing data

data$age[data$age < 18] <- NA
data$feel_LGB[data$feel_LGB < 0] <- NA
data$feel_T[data$feel_T < 0] <- NA

data$know_LGB[data$know_LGB < 0] <- NA
data$know_LGB[data$know_LGB == 2] <- 0

data$know_T[data$know_T < 0] <- NA
data$know_T[data$know_T == 2] <- 0

# create vars feel_LGBT and know_LBGT as avg. of paired measures

data$feel_LGBT <- ((data$feel_LGB + data$feel_T)/2)
data$know_LGBT <- ((data$know_LGB + data$know_T)/2)

# correlations ------------------------------------------------------------

cor <- data[,c(5:7, 12:13)]
cor <- select(cor, c(poli, everything()))

cor <- dplyr::rename(cor, "Political Ideology" = poli, "Religiosity" = relig_attend,
                     "Pro-Marriage Equality" = equal_mar, "LGBT Favorability" = feel_LGBT,
                     "Know LGBT" = know_LGBT)

cor.mat <- as.data.frame(correlation_matrix(cor), type="pearson", digits=3)
pdf("~/Desktop/cor.mat.pdf", height = 4, width = 12)
grid.table(cor.mat)
dev.off()

# cor tests
attach(data)
# relig x poli
cor.test(relig_attend, poli)

# relig + poli x marriage equality
cor.test(relig_attend, equal_mar)
cor.test(poli, equal_mar)

# relig + poli x LGBT favorability
cor.test(relig_attend, feel_LGBT)
cor.test(poli, feel_LGBT)

# regression --------------------------------------------------------------

data.na<-data[complete.cases(data),]

mar_equality <- lm(equal_mar ~ relig_attend + poli + age + sex + race + sexori, data.na)
mar_equality2 <- lm(equal_mar ~ relig_attend*know_LGBT + poli*know_LGBT + age + sex + race + sexori, data.na)
## check diff
anova(mar_equality, mar_equality2)

LGBT_favor <- lm(feel_LGBT ~ relig_attend + poli + age + sex + race + sexori, data.na)
LGBT_favor2 <- lm(feel_LGBT ~ relig_attend*know_LGBT + poli*know_LGBT + age + sex + race + sexori, data.na)
## check diff
anova(LGBT_favor, LGBT_favor2)

# data visualization ------------------------------------------------------

attach(data.na)

## marriage equality
eqn <- function(a,b,c,d,f,g){
  6.124 - .161*a -.260*b -.019*c + .328*d - .120*f - .064*g}
eqn2 <- function(a,b,c,d,f,g,h,i,j){
  6.512 - .148*a - .696*b - .365*c - .019*d + .311*f - .104*g - .044*h - .004*i + .232*j}

data.na$predicted <- eqn(relig_attend,poli,age,sex,race,sexori)
data.na$predicted2 <- eqn2(relig_attend,know_LGBT,poli,age,sex,race,sexori,relig_attend*know_LGBT, poli*relig_attend)

plt <- ggplot(data.na, aes(poli*know_LGBT, equal_mar))+
  geom_jitter(width=.5, height=.5, alpha=.6, pch=20, color="gray20")+
  stat_smooth(geom="line", aes(y=predicted, x=poli*know_LGBT), method="lm", color = "firebrick1", se=F, alpha=.5) +
  geom_smooth(aes(y=predicted2, x=poli*know_LGBT), method="lm", color="firebrick4", se=F)
plt + theme_minimal() +
  labs(title=NULL,
       x = expression(paste("Political Ideology * Knowing LGBT"), size=2), 
       y = expression(atop("Support for Marriage Equality", atop(italic("0 = Disapprove to 5 = approve"))))) +
  theme(plot.title = element_text(face="bold")) +
  annotate("text", x=5, y=2, label=expression(paste(italic("R")^{2}, italic(" ="), italic(" .378"))), size=3) +   
  annotate("text", x=5, y=1.5, label=expression(paste(italic("y = "), italic("6.512 "), "+ ", italic(".232 ")*"x"[1], italic(" + k"))), size=3)

## lgbt favorability
eqn3 <- function(a,b,c,d,f,g){
  115.174 + .040*a - 6.694*b - .270*c + 10.433*d - 6.756*f - 7.148*g}
eqn4 <- function(a,b,c,d,f,g,h,i,j){
  116.027 + 1.308*a - 14.765*b - 10.317*c - .254*d + 9.370*f - 5.498*g - 6.107*h - 1.702*i + 9.642*j}

data.na$predicted3 <- eqn3(relig_attend,poli,age,sex,race,sexori)
data.na$predicted4 <- eqn4(relig_attend,know_LGBT,poli,age,sex,race,sexori,relig_attend*know_LGBT,poli*know_LGBT)

plot <- ggplot(data.na, aes(poli*know_LGBT, feel_LGBT))+
  geom_jitter(width=.5, height=.5, alpha=.6, pch=20, color="gray20")+
  stat_smooth(geom="line",aes(y=predicted3, x=poli*know_LGBT), method="lm", color = "dodgerblue", se=F, alpha=.5) +
  geom_smooth(aes(y=predicted4, x=poli*know_LGBT), method="lm", color="dodgerblue3", se=F)
plot + theme_minimal() +
  labs(title=NULL, 
       x = expression(paste("Political Ideology * LGBT Contact"), size=2), 
       y = expression(atop("LGBT Favorability", atop(italic("0 = Disfavor to 100 = Favor"))))) +
  theme(plot.title = element_text(face="bold")) +
  annotate("text", x=5, y=15, label=expression(paste(italic("R")^{2}, italic(" ="), italic(" .294"))), size=3) +   
  annotate("text", x=5, y=7, label=expression(paste(italic("y = "), italic("116.027 "), "+ ", italic("9.642 ")*"x"[1], italic(" + k"))), size=3)

