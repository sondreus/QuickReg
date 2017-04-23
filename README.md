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
         type = "html",
         silent = TRUE
         )
```

<table style="text-align:center">
<caption>
<strong>QuickReg Table (created: 2017-04-23 13:19:12)</strong>
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
-   **html.only** - *(Optional)* If TRUE, no latex output produced (only HTML table). Defaults to FALSE.
-   **type** - *(Optional)* Specifies the type of table output that will be requested from Stargazer. Possible values are: "latex", "html", and "text". Defaults to "latex".
-   **silent** - *(Optional)* If TRUE, no messages are returned by the function. Defaults to FALSE.
-   **save.fits** - *(Optional)* If TRUE, saves fitted lm objects in a list by the name "QuickReg.fits" adding an integer if an object by this name already exists. Defaults to FALSE.
-   **demeaning.acceleration** - *(Optional)* If TRUE, attempts to speed up regression by the method of alternating projections. In particular, it utilizes the "demeanlist" function of the "lfe" package to create a matrix of all covariates demeaned by all fixed effects, and then fits the different regression specifications on this demeaned matrix. Time saved is increasing in the number of fixed effects, specifications and observations, and this method is slower when all these are low. If there are thousands of fixed effects and many specifications, time saved is potentially quite large. Note: Overrides fixed.effects.specifications, always including all variables specified in fixed.effects, and does not supply R-squared or other model statistics. Defaults to FALSE.
-   **...** - Various options passed to the stargazer function. In particular: *stargazer.digits* = integer of number of digits to be displayed, *stargazer.font.size* = font size (e.g. "tiny") if output is latex (no font size is imposed by default), *stargazer.style* = table style (see "?stargazer\_style\_list"), *stargazer.omit.stat* = character vector of model statistics to be omitted from table output.

Explanation and detail
----------------------

The QuickReg function is meant to provide a comprehensive and convenient linear regression interface in R. It has been designed with the objective of being intuitive and easy to use at default settings, but with enough options for advanced users. Most importantly, the function is meant to facilitate a smooth and productive workflow.

QuickReg is designed to work smoothly with knitr and Rmarkdown, and allows output to be requested from stargazer to be in "latex", "html", or "text" format.

To illustrate the use of QuickReg, consider a researcher considering the linear relationships between a few variables.

``` r
N <- 1000
mydata <- cbind.data.frame(rnorm(N), rnorm(N), rnorm(N), rnorm(N), rnorm(N), 
                           rep(seq(1:10), N/10), sample(1:10, N, replace = TRUE))
colnames(mydata) <- c("y", "alternative.y", "x1", "x2", "x3", "group1", "group2")
```

Let's fit a simple regression in base R:

``` r
# Standard R
summary(lm(y ~ x1, data = mydata))
```

    ## 
    ## Call:
    ## lm(formula = y ~ x1, data = mydata)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -3.2958 -0.7097  0.0463  0.7061  3.0068 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)  
    ## (Intercept)  0.075587   0.031832   2.375   0.0178 *
    ## x1          -0.004025   0.032464  -0.124   0.9013  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 1.007 on 998 degrees of freedom
    ## Multiple R-squared:  1.541e-05,  Adjusted R-squared:  -0.0009866 
    ## F-statistic: 0.01538 on 1 and 998 DF,  p-value: 0.9013

And then in QuickReg:

``` r
# QuickReg
QuickReg(data = mydata, dv.vars = "y", iv.vars = "x1", type = "html")
```

<!-- % Automated Regression specification, labeling and SE calculations created using QuickReg by Sondre U. Solstad, Princeton University. E-mail: ssolstad [at] princeton.edu -->
<table style="text-align:center">
<caption>
<strong>QuickReg Table (created: 2017-04-23 13:19:18)</strong>
</caption>
<tr>
<td colspan="2" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
<em>Dependent variable:</em>
</td>
</tr>
<tr>
<td>
</td>
<td colspan="1" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
y
</td>
</tr>
<tr>
<td colspan="2" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
x1
</td>
<td>
-0.004
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
(0.03)
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
</td>
</tr>
<tr>
<td style="text-align:left">
Constant
</td>
<td>
0.08<sup>\*\*</sup>
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
(0.03)
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
</td>
</tr>
<tr>
<td colspan="2" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
Observations
</td>
<td>
1,000
</td>
</tr>
<tr>
<td style="text-align:left">
R<sup>2</sup>
</td>
<td>
0.0000
</td>
</tr>
<tr>
<td style="text-align:left">
Adjusted R<sup>2</sup>
</td>
<td>
-0.001
</td>
</tr>
<tr>
<td style="text-align:left">
Residual Std. Error
</td>
<td>
1.01 (df = 998)
</td>
</tr>
<tr>
<td colspan="2" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
<em>Note:</em>
</td>
<td style="text-align:right">
<sup>*</sup>p&lt;0.1; <sup>**</sup>p&lt;0.05; <sup>***</sup>p&lt;0.01
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td style="text-align:right">
(Normal Standard Errors in Parenthesis)
</td>
</tr>
</table>
Suppose we also are interested in the effects of "x2" and "x3".

Base R:

``` r
# Standard R
summary(lm(y ~ x1 + x2 + x3, data = mydata))
```

    ## 
    ## Call:
    ## lm(formula = y ~ x1 + x2 + x3, data = mydata)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -3.2331 -0.7015  0.0502  0.6801  2.9596 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)  
    ## (Intercept)  0.076970   0.031788   2.421   0.0156 *
    ## x1          -0.003123   0.032433  -0.096   0.9233  
    ## x2           0.044727   0.031930   1.401   0.1616  
    ## x3           0.056325   0.031974   1.762   0.0784 .
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 1.005 on 996 degrees of freedom
    ## Multiple R-squared:  0.005224,   Adjusted R-squared:  0.002228 
    ## F-statistic: 1.744 on 3 and 996 DF,  p-value: 0.1564

QuickReg:

``` r
# QuickReg
QuickReg(data = mydata, dv.vars = "y", iv.vars = c("x1", "x2", "x3"), type = "html")
```

<!-- % Automated Regression specification, labeling and SE calculations created using QuickReg by Sondre U. Solstad, Princeton University. E-mail: ssolstad [at] princeton.edu -->
<table style="text-align:center">
<caption>
<strong>QuickReg Table (created: 2017-04-23 13:19:19)</strong>
</caption>
<tr>
<td colspan="2" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
<em>Dependent variable:</em>
</td>
</tr>
<tr>
<td>
</td>
<td colspan="1" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
y
</td>
</tr>
<tr>
<td colspan="2" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
x1
</td>
<td>
-0.003
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
(0.03)
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
</td>
</tr>
<tr>
<td style="text-align:left">
x2
</td>
<td>
0.04
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
(0.03)
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
</td>
</tr>
<tr>
<td style="text-align:left">
x3
</td>
<td>
0.06<sup>\*</sup>
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
(0.03)
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
</td>
</tr>
<tr>
<td style="text-align:left">
Constant
</td>
<td>
0.08<sup>\*\*</sup>
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
(0.03)
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
</td>
</tr>
<tr>
<td colspan="2" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
Observations
</td>
<td>
1,000
</td>
</tr>
<tr>
<td style="text-align:left">
R<sup>2</sup>
</td>
<td>
0.01
</td>
</tr>
<tr>
<td style="text-align:left">
Adjusted R<sup>2</sup>
</td>
<td>
0.002
</td>
</tr>
<tr>
<td style="text-align:left">
Residual Std. Error
</td>
<td>
1.00 (df = 996)
</td>
</tr>
<tr>
<td colspan="2" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
<em>Note:</em>
</td>
<td style="text-align:right">
<sup>*</sup>p&lt;0.1; <sup>**</sup>p&lt;0.05; <sup>***</sup>p&lt;0.01
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td style="text-align:right">
(Normal Standard Errors in Parenthesis)
</td>
</tr>
</table>
But what are the unconditional effects of x2 and x3, and how do they compare with x1?

Base R:

``` r
# Standard R
summary(lm(y ~ x1, data = mydata))
```

    ## 
    ## Call:
    ## lm(formula = y ~ x1, data = mydata)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -3.2958 -0.7097  0.0463  0.7061  3.0068 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)  
    ## (Intercept)  0.075587   0.031832   2.375   0.0178 *
    ## x1          -0.004025   0.032464  -0.124   0.9013  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 1.007 on 998 degrees of freedom
    ## Multiple R-squared:  1.541e-05,  Adjusted R-squared:  -0.0009866 
    ## F-statistic: 0.01538 on 1 and 998 DF,  p-value: 0.9013

``` r
summary(lm(y ~ x2, data = mydata))
```

    ## 
    ## Call:
    ## lm(formula = y ~ x2, data = mydata)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -3.2206 -0.6866  0.0471  0.7068  3.0049 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)  
    ## (Intercept)  0.07581    0.03180   2.384   0.0173 *
    ## x2           0.04630    0.03193   1.450   0.1474  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 1.005 on 998 degrees of freedom
    ## Multiple R-squared:  0.002102,   Adjusted R-squared:  0.001102 
    ## F-statistic: 2.103 on 1 and 998 DF,  p-value: 0.1474

``` r
summary(lm(y ~ x3, data = mydata))
```

    ## 
    ## Call:
    ## lm(formula = y ~ x3, data = mydata)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -3.2975 -0.7013  0.0438  0.6879  2.9747 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)  
    ## (Intercept)  0.07670    0.03178   2.413   0.0160 *
    ## x3           0.05771    0.03194   1.807   0.0711 .
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 1.005 on 998 degrees of freedom
    ## Multiple R-squared:  0.00326,    Adjusted R-squared:  0.002261 
    ## F-statistic: 3.264 on 1 and 998 DF,  p-value: 0.07112

QuickReg:

``` r
# QuickReg
QuickReg(data = mydata, dv.vars = "y", iv.vars = c("x1", "x2", "x3"), specifications = list(1, 2, 3), 
         type = "html")
```

<!-- % Automated Regression specification, labeling and SE calculations created using QuickReg by Sondre U. Solstad, Princeton University. E-mail: ssolstad [at] princeton.edu -->
<table style="text-align:center">
<caption>
<strong>QuickReg Table (created: 2017-04-23 13:19:20)</strong>
</caption>
<tr>
<td colspan="4" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td colspan="3">
<em>Dependent variable:</em>
</td>
</tr>
<tr>
<td>
</td>
<td colspan="3" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td colspan="3">
y
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
</tr>
<tr>
<td colspan="4" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
x1
</td>
<td>
-0.004
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
(0.03)
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
</tr>
<tr>
<td style="text-align:left">
x2
</td>
<td>
</td>
<td>
0.05
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
(0.03)
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
</tr>
<tr>
<td style="text-align:left">
x3
</td>
<td>
</td>
<td>
</td>
<td>
0.06<sup>\*</sup>
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
(0.03)
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
</tr>
<tr>
<td style="text-align:left">
Constant
</td>
<td>
0.08<sup>\*\*</sup>
</td>
<td>
0.08<sup>\*\*</sup>
</td>
<td>
0.08<sup>\*\*</sup>
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
(0.03)
</td>
<td>
(0.03)
</td>
<td>
(0.03)
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
</tr>
<tr>
<td colspan="4" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
Observations
</td>
<td>
1,000
</td>
<td>
1,000
</td>
<td>
1,000
</td>
</tr>
<tr>
<td style="text-align:left">
R<sup>2</sup>
</td>
<td>
0.0000
</td>
<td>
0.002
</td>
<td>
0.003
</td>
</tr>
<tr>
<td style="text-align:left">
Adjusted R<sup>2</sup>
</td>
<td>
-0.001
</td>
<td>
0.001
</td>
<td>
0.002
</td>
</tr>
<tr>
<td style="text-align:left">
Residual Std. Error (df = 998)
</td>
<td>
1.01
</td>
<td>
1.01
</td>
<td>
1.00
</td>
</tr>
<tr>
<td colspan="4" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
<em>Note:</em>
</td>
<td colspan="3" style="text-align:right">
<sup>*</sup>p&lt;0.1; <sup>**</sup>p&lt;0.05; <sup>***</sup>p&lt;0.01
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td colspan="3" style="text-align:right">
(Normal Standard Errors in Parenthesis)
</td>
</tr>
</table>
We might also want robust standard errors or standard errors clustered at "group1":

Base R: See this guide - <http://www.drewdimmery.com/robust-ses-in-r/>

or use QuickReg with the option "robust.se = TRUE" or "cluster ='clustering variable'":

``` r
# QuickReg
QuickReg(data = mydata, dv.vars = "y", iv.vars = c("x1", "x2", "x3"), specifications = list(1, 2, 3), 
         type = "html", robust.se = TRUE)
```

<!-- % Automated Regression specification, labeling and SE calculations created using QuickReg by Sondre U. Solstad, Princeton University. E-mail: ssolstad [at] princeton.edu -->
<table style="text-align:center">
<caption>
<strong>QuickReg Table (created: 2017-04-23 13:19:21)</strong>
</caption>
<tr>
<td colspan="4" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td colspan="3">
<em>Dependent variable:</em>
</td>
</tr>
<tr>
<td>
</td>
<td colspan="3" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td colspan="3">
y
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
</tr>
<tr>
<td colspan="4" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
x1
</td>
<td>
-0.004
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
(0.03)
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
</tr>
<tr>
<td style="text-align:left">
x2
</td>
<td>
</td>
<td>
0.05
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
(0.03)
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
</tr>
<tr>
<td style="text-align:left">
x3
</td>
<td>
</td>
<td>
</td>
<td>
0.06<sup>\*</sup>
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
(0.03)
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
</tr>
<tr>
<td style="text-align:left">
Constant
</td>
<td>
0.08<sup>\*\*</sup>
</td>
<td>
0.08<sup>\*\*</sup>
</td>
<td>
0.08<sup>\*\*</sup>
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
(0.03)
</td>
<td>
(0.03)
</td>
<td>
(0.03)
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
</tr>
<tr>
<td colspan="4" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
Observations
</td>
<td>
1,000
</td>
<td>
1,000
</td>
<td>
1,000
</td>
</tr>
<tr>
<td style="text-align:left">
R<sup>2</sup>
</td>
<td>
0.0000
</td>
<td>
0.002
</td>
<td>
0.003
</td>
</tr>
<tr>
<td style="text-align:left">
Adjusted R<sup>2</sup>
</td>
<td>
-0.001
</td>
<td>
0.001
</td>
<td>
0.002
</td>
</tr>
<tr>
<td style="text-align:left">
Residual Std. Error (df = 998)
</td>
<td>
1.01
</td>
<td>
1.01
</td>
<td>
1.00
</td>
</tr>
<tr>
<td colspan="4" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
<em>Note:</em>
</td>
<td colspan="3" style="text-align:right">
<sup>*</sup>p&lt;0.1; <sup>**</sup>p&lt;0.05; <sup>***</sup>p&lt;0.01
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td colspan="3" style="text-align:right">
(Robust Standard Errors in Parenthesis)
</td>
</tr>
</table>
``` r
QuickReg(data = mydata, dv.vars = "y", iv.vars = c("x1", "x2", "x3"), specifications = list(1, 2, 3), 
         type = "html", cluster = "group1")
```

<!-- % Automated Regression specification, labeling and SE calculations created using QuickReg by Sondre U. Solstad, Princeton University. E-mail: ssolstad [at] princeton.edu -->
<table style="text-align:center">
<caption>
<strong>QuickReg Table (created: 2017-04-23 13:19:21)</strong>
</caption>
<tr>
<td colspan="4" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td colspan="3">
<em>Dependent variable:</em>
</td>
</tr>
<tr>
<td>
</td>
<td colspan="3" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td colspan="3">
y
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
</tr>
<tr>
<td colspan="4" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
x1
</td>
<td>
-0.004
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
(0.04)
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
</tr>
<tr>
<td style="text-align:left">
x2
</td>
<td>
</td>
<td>
0.05
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
(0.03)
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
</tr>
<tr>
<td style="text-align:left">
x3
</td>
<td>
</td>
<td>
</td>
<td>
0.06<sup>\*\*</sup>
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
(0.02)
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
</tr>
<tr>
<td style="text-align:left">
Constant
</td>
<td>
0.08<sup>\*\*\*</sup>
</td>
<td>
0.08<sup>\*\*\*</sup>
</td>
<td>
0.08<sup>\*\*\*</sup>
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
(0.03)
</td>
<td>
(0.03)
</td>
<td>
(0.03)
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
</tr>
<tr>
<td colspan="4" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
Observations
</td>
<td>
1,000
</td>
<td>
1,000
</td>
<td>
1,000
</td>
</tr>
<tr>
<td style="text-align:left">
R<sup>2</sup>
</td>
<td>
0.0000
</td>
<td>
0.002
</td>
<td>
0.003
</td>
</tr>
<tr>
<td style="text-align:left">
Adjusted R<sup>2</sup>
</td>
<td>
-0.001
</td>
<td>
0.001
</td>
<td>
0.002
</td>
</tr>
<tr>
<td style="text-align:left">
Residual Std. Error (df = 998)
</td>
<td>
1.01
</td>
<td>
1.01
</td>
<td>
1.00
</td>
</tr>
<tr>
<td colspan="4" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
<em>Note:</em>
</td>
<td colspan="3" style="text-align:right">
<sup>*</sup>p&lt;0.1; <sup>**</sup>p&lt;0.05; <sup>***</sup>p&lt;0.01
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td colspan="3" style="text-align:right">
(Cluster-Robust Standard Errors in Parenthesis)
</td>
</tr>
</table>
Let us also try a few more combinations using QuickReg:

``` r
# QuickReg
QuickReg(data = mydata, dv.vars = "y", iv.vars = c("x1", "x2", "x3"), 
         specifications = list(1, 2, 3, c(1, 3), c(1,2), c(2, 3),  c(1,2,3)), 
         type = "html", robust.se = TRUE)
```

<!-- % Automated Regression specification, labeling and SE calculations created using QuickReg by Sondre U. Solstad, Princeton University. E-mail: ssolstad [at] princeton.edu -->
<table style="text-align:center">
<caption>
<strong>QuickReg Table (created: 2017-04-23 13:19:22)</strong>
</caption>
<tr>
<td colspan="8" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td colspan="7">
<em>Dependent variable:</em>
</td>
</tr>
<tr>
<td>
</td>
<td colspan="7" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td colspan="7">
y
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
<td>
(7)
</td>
</tr>
<tr>
<td colspan="8" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
x1
</td>
<td>
-0.004
</td>
<td>
</td>
<td>
</td>
<td>
-0.002
</td>
<td>
-0.005
</td>
<td>
</td>
<td>
-0.003
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
(0.03)
</td>
<td>
</td>
<td>
</td>
<td>
(0.03)
</td>
<td>
(0.03)
</td>
<td>
</td>
<td>
(0.03)
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
<td>
</td>
</tr>
<tr>
<td style="text-align:left">
x2
</td>
<td>
</td>
<td>
0.05
</td>
<td>
</td>
<td>
</td>
<td>
0.05
</td>
<td>
0.04
</td>
<td>
0.04
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
</td>
<td>
(0.03)
</td>
<td>
</td>
<td>
</td>
<td>
(0.03)
</td>
<td>
(0.03)
</td>
<td>
(0.03)
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
<td>
</td>
</tr>
<tr>
<td style="text-align:left">
x3
</td>
<td>
</td>
<td>
</td>
<td>
0.06<sup>\*</sup>
</td>
<td>
0.06<sup>\*</sup>
</td>
<td>
</td>
<td>
0.06<sup>\*</sup>
</td>
<td>
0.06<sup>\*</sup>
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
(0.03)
</td>
<td>
(0.03)
</td>
<td>
</td>
<td>
(0.03)
</td>
<td>
(0.03)
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
<td>
</td>
</tr>
<tr>
<td style="text-align:left">
Constant
</td>
<td>
0.08<sup>\*\*</sup>
</td>
<td>
0.08<sup>\*\*</sup>
</td>
<td>
0.08<sup>\*\*</sup>
</td>
<td>
0.08<sup>\*\*</sup>
</td>
<td>
0.08<sup>\*\*</sup>
</td>
<td>
0.08<sup>\*\*</sup>
</td>
<td>
0.08<sup>\*\*</sup>
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
(0.03)
</td>
<td>
(0.03)
</td>
<td>
(0.03)
</td>
<td>
(0.03)
</td>
<td>
(0.03)
</td>
<td>
(0.03)
</td>
<td>
(0.03)
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
<td>
</td>
</tr>
<tr>
<td colspan="8" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
Observations
</td>
<td>
1,000
</td>
<td>
1,000
</td>
<td>
1,000
</td>
<td>
1,000
</td>
<td>
1,000
</td>
<td>
1,000
</td>
<td>
1,000
</td>
</tr>
<tr>
<td style="text-align:left">
R<sup>2</sup>
</td>
<td>
0.0000
</td>
<td>
0.002
</td>
<td>
0.003
</td>
<td>
0.003
</td>
<td>
0.002
</td>
<td>
0.01
</td>
<td>
0.01
</td>
</tr>
<tr>
<td style="text-align:left">
Adjusted R<sup>2</sup>
</td>
<td>
-0.001
</td>
<td>
0.001
</td>
<td>
0.002
</td>
<td>
0.001
</td>
<td>
0.0001
</td>
<td>
0.003
</td>
<td>
0.002
</td>
</tr>
<tr>
<td style="text-align:left">
Residual Std. Error
</td>
<td>
1.01 (df = 998)
</td>
<td>
1.01 (df = 998)
</td>
<td>
1.00 (df = 998)
</td>
<td>
1.01 (df = 997)
</td>
<td>
1.01 (df = 997)
</td>
<td>
1.00 (df = 997)
</td>
<td>
1.00 (df = 996)
</td>
</tr>
<tr>
<td colspan="8" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
<em>Note:</em>
</td>
<td colspan="7" style="text-align:right">
<sup>*</sup>p&lt;0.1; <sup>**</sup>p&lt;0.05; <sup>***</sup>p&lt;0.01
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td colspan="7" style="text-align:right">
(Robust Standard Errors in Parenthesis)
</td>
</tr>
</table>
Or try adding another DV:

``` r
# QuickReg
QuickReg(data = mydata, dv.vars = c("y", "alternative.y"), iv.vars = c("x1", "x2", "x3"), specifications = list(1, 2, 3),
         type = "html", robust.se = TRUE)
```

<!-- % Automated Regression specification, labeling and SE calculations created using QuickReg by Sondre U. Solstad, Princeton University. E-mail: ssolstad [at] princeton.edu -->
<table style="text-align:center">
<caption>
<strong>QuickReg Table (created: 2017-04-23 13:19:24)</strong>
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
y
</td>
<td colspan="3">
alternative.y
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
x1
</td>
<td>
-0.004
</td>
<td>
</td>
<td>
</td>
<td>
-0.01
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
(0.03)
</td>
<td>
</td>
<td>
</td>
<td>
(0.03)
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
x2
</td>
<td>
</td>
<td>
0.05
</td>
<td>
</td>
<td>
</td>
<td>
-0.01
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
(0.03)
</td>
<td>
</td>
<td>
</td>
<td>
(0.03)
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
x3
</td>
<td>
</td>
<td>
</td>
<td>
0.06<sup>\*</sup>
</td>
<td>
</td>
<td>
</td>
<td>
-0.03
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
(0.03)
</td>
<td>
</td>
<td>
</td>
<td>
(0.03)
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
0.08<sup>\*\*</sup>
</td>
<td>
0.08<sup>\*\*</sup>
</td>
<td>
0.08<sup>\*\*</sup>
</td>
<td>
0.06<sup>\*</sup>
</td>
<td>
0.06<sup>\*</sup>
</td>
<td>
0.06<sup>\*</sup>
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
(0.03)
</td>
<td>
(0.03)
</td>
<td>
(0.03)
</td>
<td>
(0.03)
</td>
<td>
(0.03)
</td>
<td>
(0.03)
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
Observations
</td>
<td>
1,000
</td>
<td>
1,000
</td>
<td>
1,000
</td>
<td>
1,000
</td>
<td>
1,000
</td>
<td>
1,000
</td>
</tr>
<tr>
<td style="text-align:left">
R<sup>2</sup>
</td>
<td>
0.0000
</td>
<td>
0.002
</td>
<td>
0.003
</td>
<td>
0.0002
</td>
<td>
0.0001
</td>
<td>
0.001
</td>
</tr>
<tr>
<td style="text-align:left">
Adjusted R<sup>2</sup>
</td>
<td>
-0.001
</td>
<td>
0.001
</td>
<td>
0.002
</td>
<td>
-0.001
</td>
<td>
-0.001
</td>
<td>
-0.0002
</td>
</tr>
<tr>
<td style="text-align:left">
Residual Std. Error (df = 998)
</td>
<td>
1.01
</td>
<td>
1.01
</td>
<td>
1.00
</td>
<td>
1.01
</td>
<td>
1.01
</td>
<td>
1.01
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
Or fixed effects:

``` r
# QuickReg
QuickReg(data = mydata, dv.vars = c("y", "alternative.y"), iv.vars = c("x1", "x2", "x3"), fixed.effects = c("group1", "group2"), specifications = list(1, 2, 3), 
         type = "html", robust.se = TRUE)
```

<!-- % Automated Regression specification, labeling and SE calculations created using QuickReg by Sondre U. Solstad, Princeton University. E-mail: ssolstad [at] princeton.edu -->
<table style="text-align:center">
<caption>
<strong>QuickReg Table (created: 2017-04-23 13:19:25)</strong>
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
y
</td>
<td colspan="3">
alternative.y
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
x1
</td>
<td>
-0.01
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
(0.03)
</td>
<td>
</td>
<td>
</td>
<td>
(0.03)
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
x2
</td>
<td>
</td>
<td>
0.05
</td>
<td>
</td>
<td>
</td>
<td>
-0.01
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
(0.03)
</td>
<td>
</td>
<td>
</td>
<td>
(0.03)
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
x3
</td>
<td>
</td>
<td>
</td>
<td>
0.06<sup>\*</sup>
</td>
<td>
</td>
<td>
</td>
<td>
-0.03
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
(0.03)
</td>
<td>
</td>
<td>
</td>
<td>
(0.03)
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
-0.07
</td>
<td>
-0.08
</td>
<td>
-0.06
</td>
<td>
0.04
</td>
<td>
0.05
</td>
<td>
0.04
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
(0.15)
</td>
<td>
(0.14)
</td>
<td>
(0.14)
</td>
<td>
(0.14)
</td>
<td>
(0.14)
</td>
<td>
(0.14)
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
group1
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
group2
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
1,000
</td>
<td>
1,000
</td>
<td>
1,000
</td>
<td>
1,000
</td>
<td>
1,000
</td>
<td>
1,000
</td>
</tr>
<tr>
<td style="text-align:left">
R<sup>2</sup>
</td>
<td>
0.02
</td>
<td>
0.02
</td>
<td>
0.02
</td>
<td>
0.01
</td>
<td>
0.01
</td>
<td>
0.01
</td>
</tr>
<tr>
<td style="text-align:left">
Adjusted R<sup>2</sup>
</td>
<td>
-0.002
</td>
<td>
0.0001
</td>
<td>
0.001
</td>
<td>
-0.01
</td>
<td>
-0.01
</td>
<td>
-0.01
</td>
</tr>
<tr>
<td style="text-align:left">
Residual Std. Error (df = 980)
</td>
<td>
1.01
</td>
<td>
1.01
</td>
<td>
1.01
</td>
<td>
1.01
</td>
<td>
1.01
</td>
<td>
1.01
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
Lastly, we can make it look better by adding labels and titles:

``` r
# QuickReg
QuickReg(data = mydata,
         table.title = "My Regression Results", 
         dv.vars = c("y", "alternative.y"), 
         dv.vars.names = c("Outcome", "Alternative Outcome"),
         iv.vars = c("x1", "x2", "x3"),
         iv.vars.names = c("Variable 1", "Variable 2", "Variable 3"),
         fixed.effects = c("group1", "group2"),
         fixed.effects.names = c("Group 1 FE", "Group 2 FE"),
         specifications = list(1, 2, 3), 
         cluster = "group1", 
         cluster.names = "Group 1",
         type = "html")
```

<!-- % Automated Regression specification, labeling and SE calculations created using QuickReg by Sondre U. Solstad, Princeton University. E-mail: ssolstad [at] princeton.edu -->
<table style="text-align:center">
<caption>
<strong>My Regression Results</strong>
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
Outcome
</td>
<td colspan="3">
Alternative Outcome
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
Variable 1
</td>
<td>
-0.01
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
(0.04)
</td>
<td>
</td>
<td>
</td>
<td>
(0.02)
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
Variable 2
</td>
<td>
</td>
<td>
0.05<sup>\*</sup>
</td>
<td>
</td>
<td>
</td>
<td>
-0.01
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
(0.03)
</td>
<td>
</td>
<td>
</td>
<td>
(0.03)
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
Variable 3
</td>
<td>
</td>
<td>
</td>
<td>
0.06<sup>\*\*</sup>
</td>
<td>
</td>
<td>
</td>
<td>
-0.03
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
(0.02)
</td>
<td>
</td>
<td>
</td>
<td>
(0.02)
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
-0.07
</td>
<td>
-0.08
</td>
<td>
-0.06
</td>
<td>
0.04
</td>
<td>
0.05
</td>
<td>
0.04
</td>
</tr>
<tr>
<td style="text-align:left">
</td>
<td>
(0.10)
</td>
<td>
(0.09)
</td>
<td>
(0.10)
</td>
<td>
(0.10)
</td>
<td>
(0.10)
</td>
<td>
(0.10)
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
Group 1 FE
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
Group 2 FE
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
1,000
</td>
<td>
1,000
</td>
<td>
1,000
</td>
<td>
1,000
</td>
<td>
1,000
</td>
<td>
1,000
</td>
</tr>
<tr>
<td style="text-align:left">
R<sup>2</sup>
</td>
<td>
0.02
</td>
<td>
0.02
</td>
<td>
0.02
</td>
<td>
0.01
</td>
<td>
0.01
</td>
<td>
0.01
</td>
</tr>
<tr>
<td style="text-align:left">
Adjusted R<sup>2</sup>
</td>
<td>
-0.002
</td>
<td>
0.0001
</td>
<td>
0.001
</td>
<td>
-0.01
</td>
<td>
-0.01
</td>
<td>
-0.01
</td>
</tr>
<tr>
<td style="text-align:left">
Residual Std. Error (df = 980)
</td>
<td>
1.01
</td>
<td>
1.01
</td>
<td>
1.01
</td>
<td>
1.01
</td>
<td>
1.01
</td>
<td>
1.01
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
(Group 1-Clustered Standard Errors in Parenthesis)
</td>
</tr>
</table>
It is worth noting that despite QuickReg's number of options and different syntax than base R, the function's setup cost is low: tests suggest about 1/5th of a second.

Demeaning Acceleration:
-----------------------

With a large number of fixed effects, regression analysis can take a very long time. QuickReg offers a solution to this problem. First, QuickReg implements the method of alternating projections, which takes advantage of the fact that fixed effects are equivalent to "demeaning" covariates by the levels of the fixed effects. If the number of fixed effects are large, it can be faster to demean than to invert matricies). This procedure is implemented through the demean.list function in the *lfe* package.

Secondly, and more importantly for speed purposes, one often wants to calculate results for a number of different specifications of IVs and DVs with the same fixed effects and sample of observations. QuickReg is suitable for such cases for several reasons, the first being that it provides a convenient interface for listing specifications, and second because it summarizes model results in the familiar and concise table format with columns corresponding to different models. QuickReg is also able to speed up the calculations of such tables *significantly* by applying the demeaning procedure to a single covariate matrix shared by all specifications. While standard implementations calculate fixed effects repeatedly for different specifications, it is here only done once, and then shared across all specifications. Two words of caution are in order: (1) this limits calculations to a common sample, and (2) it makes fitted objects' model statistics (e.g. R-squared) meaningless (these are removed from the resultant table automatically). Coefficient confidence intervals can and are however still calculated correctly, and all QuickReg options (including to calculate robust SEs) are available.

``` r
library("microbenchmark")

N <- 1000
mydata <- cbind.data.frame(rnorm(N), rnorm(N), rnorm(N), rnorm(N), rnorm(N), 
                           rep(seq(1:100), N/100), sample(1:100, N, replace = TRUE))
colnames(mydata) <- c("y", "alternative.y", "x1", "x2", "x3", "group1", "group2")

# Testing performance gain:
speed.test <- suppressWarnings(microbenchmark(QuickReg(data = mydata, iv.vars = c("x1", "x2", "x3"),
         dv.vars = c("y", "alternative.y"),
         specifications = list( c(1),
                        c(2, 3), 
                        c(1, 2, 3)), 
         fixed.effects = c("group1", "group2"), 
         html.only = TRUE,
         silent = TRUE,
         out.name = "QuickReg.normal",
         
         # Demeaning acceleration is set to FALSE (default)
         demeaning.acceleration = FALSE
         ),
         QuickReg(data = mydata, iv.vars = c("x1", "x2", "x3"),
         dv.vars = c("y", "alternative.y"),
         specifications = list( c(1),
                        c(2, 3), 
                        c(1, 2, 3)), 
         fixed.effects = c("group1", "group2"), 
         html.only = TRUE,
         silent = TRUE,
         out.name = "QuickReg.fast",
         
         # Demeaning acceleration is set to TRUE (not default)
         demeaning.acceleration = TRUE
         ), 
  
         # Specifying number of trails. 
          times = 20))
speed.test
```

    ## Unit: seconds
    ##                                                                                                                                                                                                                                                                                              expr
    ##  QuickReg(data = mydata, iv.vars = c("x1", "x2", "x3"), dv.vars = c("y",      "alternative.y"), specifications = list(c(1), c(2, 3), c(1,      2, 3)), fixed.effects = c("group1", "group2"), html.only = TRUE,      silent = TRUE, out.name = "QuickReg.normal", demeaning.acceleration = FALSE)
    ##     QuickReg(data = mydata, iv.vars = c("x1", "x2", "x3"), dv.vars = c("y",      "alternative.y"), specifications = list(c(1), c(2, 3), c(1,      2, 3)), fixed.effects = c("group1", "group2"), html.only = TRUE,      silent = TRUE, out.name = "QuickReg.fast", demeaning.acceleration = TRUE)
    ##       min       lq     mean   median       uq      max neval cld
    ##  4.823974 5.078692 5.562987 5.730423 5.877364 6.207369    20   b
    ##  2.056930 2.330866 2.505817 2.510799 2.708035 3.190829    20  a

``` r
print( paste("Total number of observations:", N))
```

    ## [1] "Total number of observations: 1000"

``` r
print( paste( "Total number of fixed effects:", length(unique(mydata[, "group1"])) + length(unique(mydata[, "group2"]))))
```

    ## [1] "Total number of fixed effects: 200"

In the above example, QuickReg provided an almost a 50 percent decrease in time spent. Gains are much larger when we increase the number of fixed effects, as in the below example:

``` r
library("microbenchmark")

N <- 10000
mydata <- cbind.data.frame(rnorm(N), rnorm(N), rnorm(N), rnorm(N), rnorm(N), 
                           rep(seq(1:1000), N/1000), sample(1:100, N, replace = TRUE))
colnames(mydata) <- c("y", "alternative.y", "x1", "x2", "x3", "group1", "group2")

# Testing performance gain:
speed.test <- suppressWarnings(microbenchmark(QuickReg(data = mydata, iv.vars = c("x1", "x2", "x3"),
         dv.vars = c("y", "alternative.y"),
         specifications = list( c(1),
                        c(2, 3), 
                        c(1, 2, 3)), 
         fixed.effects = c("group1", "group2"), 
         html.only = TRUE,
         silent = TRUE,
         out.name = "QuickReg.normal.html",
         
         # Demeaning acceleration is set to FALSE (default)
         demeaning.acceleration = FALSE
         ),
         QuickReg(data = mydata, iv.vars = c("x1", "x2", "x3"),
         dv.vars = c("y", "alternative.y"),
         specifications = list( c(1),
                        c(2, 3), 
                        c(1, 2, 3)), 
         fixed.effects = c("group1", "group2"), 
         html.only = TRUE,
         silent = TRUE,
         out.name = "QuickReg.fast.html",
         
         # Demeaning acceleration is set to TRUE (not default)
         demeaning.acceleration = TRUE
         ), 
  
         # Specifying number of trails. 
          times = 10))
speed.test
```

    ## Unit: seconds
    ##                                                                                                                                                                                                                                                                                                   expr
    ##  QuickReg(data = mydata, iv.vars = c("x1", "x2", "x3"), dv.vars = c("y",      "alternative.y"), specifications = list(c(1), c(2, 3), c(1,      2, 3)), fixed.effects = c("group1", "group2"), html.only = TRUE,      silent = TRUE, out.name = "QuickReg.normal.html", demeaning.acceleration = FALSE)
    ##     QuickReg(data = mydata, iv.vars = c("x1", "x2", "x3"), dv.vars = c("y",      "alternative.y"), specifications = list(c(1), c(2, 3), c(1,      2, 3)), fixed.effects = c("group1", "group2"), html.only = TRUE,      silent = TRUE, out.name = "QuickReg.fast.html", demeaning.acceleration = TRUE)
    ##        min        lq      mean    median        uq       max neval cld
    ##  207.44335 208.75496 215.13072 211.17020 221.93954 229.72499    10   b
    ##   75.15571  76.29382  82.12245  80.91357  87.47553  93.53871    10  a

``` r
print( paste("Total number of observations:", N))
```

    ## [1] "Total number of observations: 10000"

``` r
print( paste( "Total number of fixed effects:", length(unique(mydata[, "group1"])) + length(unique(mydata[, "group2"]))))
```

    ## [1] "Total number of fixed effects: 1100"

Acknowledgements
----------------

This package relies on the stargazer package by Marek Hlavac, the sandwich package by Thomas Lumley and Achim Zeileis, the lfe package by Simen Gaure, the multivcov package by Nathaniel Graham and Mahmood Arai and Björn Hagströmer, and the lmtest package by Torsten Hothorn, Achim Zeileis, Richard W. Farebrother, Clint Cummins, Giovanni Millo, and David Mitchell.

See also:

Hlavac, Marek (2015). stargazer: Well-Formatted Regression and Summary Statistics Tables. R package version 5.2. <http://CRAN.R-project.org/package=stargazer>
