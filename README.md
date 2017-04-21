QuickReg
================
Sondre U. Solstad

Easy OLS with options in R
==========================

The QuickReg package and associated function provides an easy interface for linear regression in R. This includes the option to request robust and clustered standard errors, automatic labeling, and an easy way to specify multiple regression specifications simulatenously, and a compact html or latex output (relying on the widely used "stargazer" package).

It also includes several functionalities to speed up computation, including a special implementation of the method of alternating projections that may reduce calculation time by more than 50 percent for analysis with a large number of fixed effects, and whose performance gain is increasing in the number of specifications passed to the function simultaneously.

Written by Sondre U. Solstad (<ssolstad@princeton.edu>)

Installation instructions:

``` r
library(devtools)
install_github("sondreus/QuickReg")
```

Example:
--------

``` r
library(QuickReg)

# Loading data
mydata <- readRDS("3d_example.RDS")

# Use the QuickReg to produce a regression table     
QuickReg(data = mydata, 
         iv.vars = c("upop", "log_gdppc_mad", "SDI", "SDT", "war", "polity2"), 
         iv.vars.names = c("Urban Population", "Log(GDPPC)", "Spatial distance to income", 
          "Spatial distance to technology", "At War", "Polity2 score"), 
         dv.vars = c("log_adoption_lvl_pc", "distance_to_frontier"), 
         dv.vars.names = c("Technology Adoption Level", "Distance to Frontier"), 
         specifications = list( c(1, 4, 5, 6),
                        c(1, 2, 3, 4),
                        c(1, 3, 4)), 
         fixed.effects = c("ccode", "technology", "year"),
         fixed.effects.names = c("Country FE", "Year FE", "Tech. FE"), 
         robust.se = TRUE,
         stargazer.type = "html",
         silent = TRUE
         )
```

<table style="text-align:center">
<caption>
<strong>QuickReg Table (created: 2017-04-21 19:01:18)</strong>
</caption>
<tr>
<td colspan="7" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td colspan="6">
<em>Dependent variable:</em>
</td>
</tr>
<tr>
<td>
</td>
<td colspan="6" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td colspan="3">
Technology Adoption Level
</td>
<td colspan="3">
Distance to Frontier
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
(1)
</td>
<td>
(2)
</td>
<td>
(3)
</td>
<td>
(4)
</td>
<td>
(5)
</td>
<td>
(6)
</td>
</tr>
<tr>
<td colspan="7" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
Urban Population
</td>
<td>
0.0000<sup>\*\*\*</sup>
</td>
<td>
-0.0000
</td>
<td>
0.0000<sup>\*\*\*</sup>
</td>
<td>
0.0000<sup>\*\*\*</sup>
</td>
<td>
0.0000
</td>
<td>
0.0000<sup>\*\*\*</sup>
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
(0.0000)
</td>
<td>
(0.0000)
</td>
<td>
(0.0000)
</td>
<td>
(0.0000)
</td>
<td>
(0.0000)
</td>
<td>
(0.0000)
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
</td>
<td>
</td>
<td>
</td>
<td>
</td>
<td>
</td>
<td>
</td>
</tr>
<tr>
<td style="text-align:left">
Log(GDPPC)
</td>
<td>
</td>
<td>
1.16<sup>\*\*\*</sup>
</td>
<td>
</td>
<td>
</td>
<td>
0.16<sup>\*\*\*</sup>
</td>
<td>
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
</td>
<td>
(0.07)
</td>
<td>
</td>
<td>
</td>
<td>
(0.01)
</td>
<td>
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
</td>
<td>
</td>
<td>
</td>
<td>
</td>
<td>
</td>
<td>
</td>
</tr>
<tr>
<td style="text-align:left">
Spatial distance to income
</td>
<td>
</td>
<td>
0.002<sup>\*\*\*</sup>
</td>
<td>
0.001<sup>\*\*</sup>
</td>
<td>
</td>
<td>
-0.0001
</td>
<td>
-0.0002<sup>\*\*</sup>
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
</td>
<td>
(0.0004)
</td>
<td>
(0.0005)
</td>
<td>
</td>
<td>
(0.0001)
</td>
<td>
(0.0001)
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
</td>
<td>
</td>
<td>
</td>
<td>
</td>
<td>
</td>
<td>
</td>
</tr>
<tr>
<td style="text-align:left">
Spatial distance to technology
</td>
<td>
0.005<sup>\*\*\*</sup>
</td>
<td>
0.004<sup>\*\*\*</sup>
</td>
<td>
0.004<sup>\*\*\*</sup>
</td>
<td>
0.0004<sup>\*\*\*</sup>
</td>
<td>
0.001<sup>\*\*\*</sup>
</td>
<td>
0.001<sup>\*\*\*</sup>
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
(0.0003)
</td>
<td>
(0.0003)
</td>
<td>
(0.0004)
</td>
<td>
(0.0001)
</td>
<td>
(0.0001)
</td>
<td>
(0.0001)
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
</td>
<td>
</td>
<td>
</td>
<td>
</td>
<td>
</td>
<td>
</td>
</tr>
<tr>
<td style="text-align:left">
At War
</td>
<td>
-0.09
</td>
<td>
</td>
<td>
</td>
<td>
-0.02
</td>
<td>
</td>
<td>
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
(0.07)
</td>
<td>
</td>
<td>
</td>
<td>
(0.01)
</td>
<td>
</td>
<td>
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
</td>
<td>
</td>
<td>
</td>
<td>
</td>
<td>
</td>
<td>
</td>
</tr>
<tr>
<td style="text-align:left">
Polity2 score
</td>
<td>
-0.03<sup>\*\*\*</sup>
</td>
<td>
</td>
<td>
</td>
<td>
-0.002<sup>\*\*\*</sup>
</td>
<td>
</td>
<td>
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
(0.004)
</td>
<td>
</td>
<td>
</td>
<td>
(0.001)
</td>
<td>
</td>
<td>
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
</td>
<td>
</td>
<td>
</td>
<td>
</td>
<td>
</td>
<td>
</td>
</tr>
<tr>
<td style="text-align:left">
Constant
</td>
<td>
2.73<sup>\*\*\*</sup>
</td>
<td>
-9.24<sup>\*\*\*</sup>
</td>
<td>
2.29<sup>\*\*\*</sup>
</td>
<td>
0.51<sup>\*\*\*</sup>
</td>
<td>
-1.08<sup>\*\*\*</sup>
</td>
<td>
0.53<sup>\*\*\*</sup>
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
(0.19)
</td>
<td>
(0.74)
</td>
<td>
(0.20)
</td>
<td>
(0.04)
</td>
<td>
(0.12)
</td>
<td>
(0.04)
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
</td>
<td>
</td>
<td>
</td>
<td>
</td>
<td>
</td>
<td>
</td>
</tr>
<tr>
<td colspan="7" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
Country FE
</td>
<td>
Yes
</td>
<td>
Yes
</td>
<td>
Yes
</td>
<td>
Yes
</td>
<td>
Yes
</td>
<td>
Yes
</td>
</tr>
<tr>
<td style="text-align:left">
Year FE
</td>
<td>
Yes
</td>
<td>
Yes
</td>
<td>
Yes
</td>
<td>
Yes
</td>
<td>
Yes
</td>
<td>
Yes
</td>
</tr>
<tr>
<td style="text-align:left">
Tech. FE
</td>
<td>
Yes
</td>
<td>
Yes
</td>
<td>
Yes
</td>
<td>
Yes
</td>
<td>
Yes
</td>
<td>
Yes
</td>
</tr>
<tr>
<td colspan="7" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
Observations
</td>
<td>
5,994
</td>
<td>
5,884
</td>
<td>
6,240
</td>
<td>
5,943
</td>
<td>
5,833
</td>
<td>
6,189
</td>
</tr>
<tr>
<td style="text-align:left">
R<sup>2</sup>
</td>
<td>
0.89
</td>
<td>
0.89
</td>
<td>
0.88
</td>
<td>
0.86
</td>
<td>
0.86
</td>
<td>
0.85
</td>
</tr>
<tr>
<td style="text-align:left">
Adjusted R<sup>2</sup>
</td>
<td>
0.88
</td>
<td>
0.89
</td>
<td>
0.88
</td>
<td>
0.85
</td>
<td>
0.86
</td>
<td>
0.85
</td>
</tr>
<tr>
<td style="text-align:left">
Residual Std. Error
</td>
<td>
0.80 (df = 5810)
</td>
<td>
0.78 (df = 5706)
</td>
<td>
0.81 (df = 6052)
</td>
<td>
0.14 (df = 5759)
</td>
<td>
0.13 (df = 5655)
</td>
<td>
0.14 (df = 6001)
</td>
</tr>
<tr>
<td colspan="7" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
<em>Note:</em>
</td>
<td colspan="6" style="text-align:right">
<sup>*</sup>p&lt;0.1; <sup>**</sup>p&lt;0.05; <sup>***</sup>p&lt;0.01
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td colspan="6" style="text-align:right">
(Robust Standard Errors in Parenthesis)
</td>
</tr>
</table>
See also the resultant html file: QuickReg.html - <https://cdn.rawgit.com/sondreus/QuickReg/e5f72f0a/QuickReg.html>

Arguments:
----------

-   **data** - Data frame in which all model variables are located.
-   **iv.vars** - Vector of independent variable names in dataset (e.g. c("gdppc", "pop"))
-   **iv.vars.names** - *(Optional)* Vector of desired independent variable names in table output (e.g. c("GDP per capita", "Population")). Defaults to values in "iv.vars" if none provided.
-   **dv.vars** - Vector of dependent variable in dataset (e.g. c("democracy", "war"))
-   **dv.vars.names** - *(Optional)* Vector of desired dependent variable names in table output (e.g. c("Democracy (Boix-Rosato-Miller 2012)", "War (with at least 1000 battle deaths)")). Defaults to values in "dv.vars" if none provided.
-   **specifications** - *(Optional)* List of desired regression specifications (selections of independent variables). The list of regression specifications are applied to all dependent variables. E.g. list(c(1), c(1,2), c(2))).
-   **fixed.effects** - *(Optional)* Vector of desired fixed effect variable names in dataset (e.g. c("region", "year"))
-   **fixed.effects.names** - *(Optional)* Vector of desired fixed effects labels in table output (e.g. c("Region FE", "Year FE")). Defaults to values in "fixed.effects" if none provided.
-   **fixed.effects.specifications** - *(Optional)* List of desired fixed effect specifications (selections of independent variables). These specifications are applied in sequence from the first to last model. If the number of specifications is less than the number of models, all fixed effects are applied in the remaining columns by default. If none provided, defaults to all fixed effects in all models.
-   **robust.se** - *(Optional)* If TRUE, returns robust standard errors calculated using a sandwich estimator from the "sandwich" package. Defaults to FALSE (i.e. normal standard errors).
-   **cluster** - *(Optional)* Name of variable in dataset by which cluster-robust standard errors should be computed using the cluster.vcov command of the multiwayvcov package.
-   **cluster.names** - *(Optional)* Desired name or label of clustering variable to be reported in table output (e.g. "Country" yields a note on the bottom of the table reading "Country-Clustered Standard Errors in Parenthesis"). If cluster specified but no "cluster.names" provided, "Cluster-Robust Standard Errors in Parenthesis" is reported.
-   **table.title** - *(Optional)* Specifies the title of the table with regression output. Defaults to "QuickReg" plus the date and time of creation in parenthesis.
-   **out.name** - *(Optional)* Specifies the output file name. Defaults to "QuickReg.html".
-   **dynamic.out.name** - *(Optional)* If TRUE, adds date and time of creation in brackets between the out.name and the file extension (e.g. QuickReg (2017-04-05-14-01-27).html)
-   \*\*html.only - *(Optional)* If TRUE, no latex output produced (only HTML table). Defaults to FALSE.
-   **silent** - *(Optional)* If TRUE, no messages are returned by the function. Defaults to FALSE.
-   **save.fits** - *(Optional)* If TRUE, saves fitted lm objects in a list by the name "QuickReg.fits" adding an integer if an object by this name already exists. Defaults to FALSE.
-   **demeaning.acceleration** - *(Optional)* If TRUE, attempts to speed up regression by the method of alternating projections. In particular, it utilizes the "demeanlist" function of the "lfe" package to create a matrix of all covariates demeaned by all fixed effects, and then fits the different regression specifications on this demeaned matrix. Time saved is increasing in the number of fixed effects, specifications and observations, and this method is slower when all these are low. If there are thousands of fixed effects and many specifications, time saved is potentially quite large. Note: Overrides fixed.effects.specifications, always including all variables specified in fixed.effects, and does not supply R-squared or other model statistics. Defaults to FALSE.
-   **...** - Various options passed to the stargazer function. See ?stargazer.

Explanation and detail
----------------------

N/A

Demeaning Acceleration:
-----------------------

``` r
library("microbenchmark")

mydata$technology_year <- interaction(mydata$technology, mydata$year)
mydata$technology_ccode <- interaction(mydata$technology, mydata$ccode)

N <- 20000
set.seed(12358)

# Testing performance gain:
microbenchmark(
  
   QuickReg(data = mydata[sample(1:nrow(mydata), N, replace = TRUE), ],  
         iv.vars = c("upop", "log_gdppc_mad", "SDI", "SDT", "war", "polity2"), 
         iv.vars.names = c("Urban Population", "Log(GDPPC)", "Spatial distance to income", 
          "Spatial distance to technology", "At War", "Polity2 score"), 
         dv.vars = c("log_adoption_lvl_pc", "distance_to_frontier", "cinc"), 
         dv.vars.names = c("Technology Adoption Level", "Distance to Frontier", "National Capabilities"), 
         specifications = list( c(1, 3, 4, 5, 6),
                        c(1, 5, 6),
                        c(1, 5, 3), 
                        c(1, 2, 3, 4)), 
         fixed.effects = c("technology_ccode", "technology_year"), 
         fixed.effects.names = c("Technology-Country FE", "Technology-Year FE"),
         cluster = "ccode",
         html.only = TRUE,
         silent = TRUE,
         out.name = "QuickReg.normal",
         
         # Demeaning acceleration is set to FALSE (default)
         demeaning.acceleration = FALSE
         )
  ,
         QuickReg(data = mydata[sample(1:nrow(mydata), N, replace = TRUE), ],  
         iv.vars = c("upop", "log_gdppc_mad", "SDI", "SDT", "war", "polity2"), 
         iv.vars.names = c("Urban Population", "Log(GDPPC)", "Spatial distance to income", 
          "Spatial distance to technology", "At War", "Polity2 score"), 
         dv.vars = c("log_adoption_lvl_pc", "distance_to_frontier", "cinc"), 
         dv.vars.names = c("Technology Adoption Level", "Distance to Frontier", "National Capabilities"), 
         specifications = list( c(1, 3, 4, 5, 6),
                        c(1, 5, 6),
                        c(1, 5, 3), 
                        c(1, 2, 3, 4)), 
         fixed.effects = c("technology_ccode", "technology_year"), 
         fixed.effects.names = c("Technology-Country FE", "Technology-Year FE"),
         cluster = "ccode",
         html.only = TRUE,
         silent = TRUE,
         out.name = "QuickReg.normal",
         
         # Demeaning acceleration is set to TRUE
         demeaning.acceleration = TRUE
         ), 
  
         # Specifying number of trails. 
          times = 2)  

print( paste("Total number of observations:", N))
print( paste( "Total number of fixed effects:", nrow(unique(data[, fixed.effects]))))
```

Acknowledgements
----------------

This package relies on the stargazer package by Marek Hlavac, the sandwich package by Thomas Lumley and Achim Zeileis, the lfe package by Simen Gaure, the multivcov package by Nathaniel Graham and Mahmood Arai and Björn Hagströmer, and the lmtest package by Torsten Hothorn, Achim Zeileis, Richard W. Farebrother, Clint Cummins, Giovanni Millo, and David Mitchell.

See also:

Hlavac, Marek (2015). stargazer: Well-Formatted Regression and Summary Statistics Tables. R package version 5.2. <http://CRAN.R-project.org/package=stargazer>
