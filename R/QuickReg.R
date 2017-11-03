#' QuickReg
#'
#' The QuickReg package provides an easy interface for linear regression in R. This includes the option to request robust and clustered standard errors, automatic labeling, and an easy way to specify multiple regression specifications simulatenously, and a compact html or latex output (relying on the widely used "stargazer" package). It also includes several functionalities to speed up computation, including a special implementation of the method of alternating projections that may reduce calculation time by more than 50 percent for analysis with a large number of fixed effects, and whose performance gain is increasing in the number of specifications passed to the function simultaneously. Written by Sondre U. Solstad (ssolstad@princeton.edu).
#' @param data Data frame in which all model variables are located. 
#' @param iv.vars Vector of independent variable names in dataset (e.g. c("gdppc", "pop"))
#' @param iv.vars.names (Optional) Vector of desired independent variable names in table output (e.g. c("GDP per capita", "Population")). Defaults to values in "iv.vars" if none provided.
#' @param dv.vars Vector of dependent variable in dataset (e.g. c("democracy", "war"))
#' @param dv.vars.names (Optional) Vector of desired dependent variable names in table output (e.g. c("Democracy (Boix-Rosato-Miller 2012)", "War (with at least 1000 battle deaths)")). Defaults to values in "dv.vars" if none provided.
#' @param specifications (Optional) List of desired regression specifications (selections of independent variables). The list of regression specifications are applied to all dependent variables. E.g. list(c(1), c(1,2), c(2))).  
#' @param fixed.effects (Optional) Vector of desired fixed effect variable names in dataset (e.g. c("region", "year"))
#' @param fixed.effects.names (Optional) Vector of desired fixed effects labels in table output (e.g. c("Region FE", "Year FE")). Defaults to values in "fixed.effects" if none provided.
#' @param fixed.effects.specifications (Optional) List of desired fixed effect specifications (selections of independent variables). These specifications are applied in sequence from the first to last model. If the number of specifications is less than the number of models, all fixed effects are applied in the remaining columns by default. If none provided, defaults to all fixed effects in all models.
#' @param robust.se (Optional) If TRUE, returns robust standard errors calculated using a sandwich estimator from the "sandwich" package. Defaults to FALSE (i.e. normal standard errors).
#' @param cluster (Optional) Name of variable in dataset by which cluster-robust standard errors should be computed using the cluster.vcov command of the multiwayvcov package.
#' @param cluster.names (Optional) Desired name or label of clustering variable to be reported in table output (e.g. "Country" yields a note on the bottom of the table reading "Country-Clustered Standard Errors in Parenthesis"). If cluster specified but no "cluster.names" provided, "Cluster-Robust Standard Errors in Parenthesis" is reported.
#' @param table.title (Optional) Specifies the title of the table with regression output. Defaults to "QuickReg" plus the date and time of creation in parenthesis.
#' @param out.name (Optional) Specifies the output file name. Defaults to "QuickReg.html". 
#' @param dynamic.out.name (Optional) If TRUE, adds date and time of creation in brackets between the out.name and the file extension (e.g. QuickReg (2017-04-05-14-01-27).html)
#' @param html.only (Optional) If TRUE, no latex output produced (only HTML table). Defaults to FALSE.
#' @param type (Optional) Specifies the type of table output that will be requested from Stargazer. Possible values are: "latex", "html", and "text". Defaults to "latex". Defaults to "latex"
#' @param silent (Optional) If TRUE, no messages are returned by the function. Defaults to FALSE.
#' @param save.fits (Optional) If TRUE, saves fitted lm objects in a list by the name "QuickReg.fits" adding an integer if an object by this name already exists. Defaults to FALSE.
#' @param no.out.file (Optional) If TRUE, does not save html table to working directory. 
#' @param demeaning.acceleration (Optional) If TRUE, attempts to speed up regression by the method of alternating projections. In particular, it utilizes the "demeanlist" function of the "lfe" package to create a matrix of all covariates demeaned by all fixed effects, and then fits the different regression specifications on this demeaned matrix. Time saved is increasing in the number of fixed effects, specifications and observations, and this method is slower when all these are low. If there are thousands of fixed effects and many specifications, time saved is potentially quite large. Note: Overrides fixed.effects.specifications, always including all variables specified in fixed.effects, and does not supply R-squared or other model statistics. Defaults to FALSE.
#' @param ... Various options passed to the stargazer function. See ?stargazer.
#' @keywords lm OLS robust.se robust cluster LS reg regression QuickReg
#' @export
#' @examples
#' Please see: github.com/sondreus/QuickReg
#'

QuickReg <- function (data, iv.vars, iv.vars.names, dv.vars, dv.vars.names, specifications, fixed.effects, fixed.effects.names, fixed.effects.specifications, robust.se, cluster, cluster.names, table.title, out.name, dynamic.out.name, html.only, silent, save.fits, no.out.file, demeaning.acceleration, digits = 2, type = "latex", omit = NULL, ...) {
  
# Loading the "stargazer" package
library(stargazer)  
  
# Checking if data argument provided  
  if(missing(data)){
    stop("Please specify a data frame for your regression variables")
  } 
  
  
# Coercing data into data frame
  data <- as.data.frame(data)  
  
  if(!missing(cluster)){
    if(length(cluster) >= 1){
      
      # If clustering variable specified, ensuring in data
      data <- data[complete.cases(data[, cluster]), ]
      rownames(data) <- 1:nrow(data)
      
      if(nrow(data) == 0){  
        stop("Please specify a data frame and clustering variable combination which is not missing for all observations")
      } 
      
    } 
  }
  
  if(nrow(data) == 0){  
    stop("Please specify a data frame which is not missing for all observations")
  } 
  

  # Checking and specifying output type
  if(missing(type)){
    type <- "latex"
  }
  
  #
  if(type == "latex"){
    creditation.message <- "% Automated Regression specification, labeling and SE calculations created using QuickReg by Sondre U. Solstad, Princeton University. E-mail: ssolstad [at] princeton.edu"
  }
  if(type == "html"){
    creditation.message <- "<!-- % Automated Regression specification, labeling and SE calculations created using QuickReg by Sondre U. Solstad, Princeton University. E-mail: ssolstad [at] princeton.edu -->"
  }
  if(type == "text"){
    creditation.message <- "Automated Regression specification, labeling and SE calculations created using QuickReg by Sondre U. Solstad, Princeton University. E-mail: ssolstad [at] princeton.edu."
  }
  
  
  
# Setting demeaning.acceleration option to default  
accelerate <- FALSE
  
## If demeaning.acceleration option selected, setting "accelerate" to TRUE: 
  if(!missing(fixed.effects)){
  if(!missing(demeaning.acceleration)){
    if(demeaning.acceleration == TRUE){
      if(!is.null(fixed.effects)){
        
        accelerate <- TRUE
        
        # Checking if desired output to be silent, if so:
        if(!missing(silent)){
          if(silent == TRUE ){
            # Print nothing, else:
            
          } else {
            cat("% Demeaning Acceleration initiated || \n % Note : \n % (1) Row.wise deletion for all dv's, iv's, fixed.effects (i.e. all regressions now on same sample of obs.), \n % (2) Overriding manual fixed-effects specification, all fixed effects fitted by default. \n % \n ")
          }
        } else {
          # print warning message:
          cat("% Demeaning Acceleration initiated || \n % Note : \n % (1) Row.wise deletion for all dv's, iv's, fixed.effects (i.e. all regressions now on same sample of obs.), \n % (2) Overriding manual fixed-effects specification, all fixed effects fitted by default. \n % \n ")} 
        
      }
      
    } 
  }
  }
  
# If accelerate option selected, generate new temporary dataset
  if(accelerate == TRUE){
    
    if(!missing(specifications)){  
      if(missing(cluster)){
        
        demean.data <- na.omit(data[ , unique(c(dv.vars, iv.vars[sort(unique(unlist(specifications)))], fixed.effects))])
        
      } else {
        
        demean.data <- na.omit(data[ , unique(c(dv.vars, iv.vars[sort(unique(unlist(specifications)))], fixed.effects, cluster))])
        
      }
    } else {
      if(missing(cluster)){
        demean.data <- na.omit(data[ , unique(c(dv.vars, iv.vars, fixed.effects))])
        
      } else {
        demean.data <- na.omit(data[ , unique(c(dv.vars, iv.vars, fixed.effects, cluster))])
        
      }
      
    }
    
    # Getting (fast) demeaning function (from https://journal.r-project.org/archive/2013-2/gaure.pdf):
    library(lfe, quietly = TRUE)
    
    # Demeaning other covariates by each fixed effect in turn. 
    # This can be time-consuming (if marginally faster than the standard lm implementation), but importantly  
    # only needs to be done once for all regressions, instead of for all specifications separately. 
    
    if(!missing(cluster)){
      demean.data[, setdiff(setdiff(colnames(demean.data), fixed.effects), cluster)] <- demeanlist(demean.data[, setdiff(setdiff(colnames(demean.data), fixed.effects), cluster)], lapply(as.list(as.data.frame(model.matrix(as.formula(paste(" ~ ", paste0("as.factor(", fixed.effects, ")", collapse = "+"), " - 1")), data = demean.data))), factor))
    } else {
      demean.data[, setdiff(colnames(demean.data), fixed.effects)] <- demeanlist(demean.data[, setdiff(colnames(demean.data), fixed.effects)], lapply(as.list(as.data.frame(model.matrix(as.formula(paste(" ~ ", paste0("as.factor(", fixed.effects, ")", collapse = "+"), " - 1")), data = demean.data))), factor))
    }
    
    # From now on using demeaned data.
    data <- demean.data
    fixed.effects.source <- fixed.effects
    fixed.effects <- NULL
    
  }
  
  ## Specifying names for saved fits (and SEs) if option selected:
  
  # Setting default value (= FALSE)
  save.fits.as.object <- FALSE 
  
  if(!missing(save.fits)){
    if(save.fits == TRUE){
      
      # Specifying save option as true if option specified as such 
      save.fits.as.object <- TRUE
      
      # Setting default name
      save.fits.name <- "QuickReg.fits"
      
      # Ensuring name is unique by adding number if object already exists in global environment
      index <- 1
      while(length(grep(save.fits.name, ls(envir = .GlobalEnv))) > 0){
        save.fits.name <- paste0("QuickReg.fits", ".", index)
        index <- index + 1
      } 
    }
  }
  
  
  # Getting user-defined regression table output name, if any
  if(missing(out.name)) {
    out.name <- "QuickReg.html"
  } else {
    out.name <- out.name
  }
  
  # Generating dynamic out name if option selected
  if(!missing(dynamic.out.name)){
    if(dynamic.out.name == TRUE){
      out.name.title <- paste0(unlist(strsplit(out.name, split="\\."))[1:(length(unlist(strsplit(out.name, split="\\.")))-1)], collapse =".")
      out.name.extension <- paste0(".",sapply(strsplit(out.name, split="\\."), tail, 1L))
      
      out.name <- paste0(out.name.title, " (", gsub("\\D", "-", Sys.time()), ")", out.name.extension)
    }
  }
  
  # Checking if "no.out.file" option selected. 
  if(!missing(no.out.file)){
    if(no.out.file == TRUE){
      out.name <- NULL
    }
  }
  
  # Getting user-defined regression table title, if any
  if(missing(table.title)) {
    table.title <- paste0("QuickReg Table ","(created: ", Sys.time(),")") 
  } else {
    table.title <- table.title
  }
  
  # Setting labels to variable names, if none provided
  if(missing(dv.vars.names)){
    dv.vars.names <- dv.vars
  } 
  
  if(missing(iv.vars.names)){
    if(missing(specifications)){
      iv.vars.names <- iv.vars
    } else {
      iv.vars.names <- iv.vars[sort(unique(unlist(specifications)))]
    } 
  } else {
    if(missing(specifications)){
      iv.vars.names <- iv.vars.names
    } else {
      iv.vars.names <- iv.vars.names[sort(unique(unlist(specifications)))]
    }   
  }
  
  # Setting "fixed.effects" to default if not provided  
  if(missing(fixed.effects)){
    fixed.effects <- NULL
  }  
  
  
  # Setting first column number to 1  
  colnumber <- 1
  
  # Looping through all dependent variables
  for(j in 1:length(dv.vars)){
    
    # If user-defined specifications, looping through each in turn within each dependent variable:  
    if(!missing(specifications)){
      for (i in 1:length(specifications)){
        
        # Getting user-defined fixed effects specification, if any:
        if(missing(fixed.effects.specifications)){
          # If none provided, assume all fixed effects included, if any
          col.fixed.effects <- fixed.effects
        } else {
          
          # Else use specifications provided, and if not enough provided, use all fixed effects in remaining columns.
          col.fixed.effects <- tryCatch(fixed.effects[fixed.effects.specifications[[colnumber]]], error = function(e) {return(fixed.effects)}, silent = TRUE) 
        }
        
        regression.specification <- as.formula(paste(paste(paste(dv.vars[j], " ~ ", sep = ""), paste(iv.vars[specifications[[i]]], collapse=" + ")), ifelse(is.null(col.fixed.effects) == TRUE, "", paste(" + ", paste("as.factor(", col.fixed.effects, ")", collapse = " + ")))))
        
        # Fitting OLS and saving as column-specific object 
        fit <- lm(regression.specification, data = data)
        assign(paste("QuickReg.col", colnumber, sep = ""),get("fit"))
        
        # Incrementing column number by 1
        colnumber <- colnumber + 1 
        
      }
    } 
    # If no specifications provided, fitting regression with all independent variables by default 
    
    else {
      regression.specification <- as.formula(paste(paste(paste(dv.vars[j], " ~ ", sep = ""), paste(iv.vars, collapse=" + ")), ifelse(is.null(fixed.effects) == TRUE, "", paste(" + ", paste("as.factor(", fixed.effects, ")", collapse = " + ")))))
      
      fit <- lm(regression.specification, data = data)
      assign(paste("QuickReg.col", colnumber, sep = ""),get("fit"))
      
      colnumber <- colnumber + 1 
      
    }
  }
  
  if(accelerate == TRUE){
    fixed.effects <- fixed.effects.source  
  }
  
  
  
  # Removing labels if no fixed effects
  if(!is.null(fixed.effects)){
    
    if(missing(fixed.effects.names)){
      if(missing(fixed.effects.specifications)){
        fixed.effects.names <- fixed.effects
      } else {
        if(length(c(fixed.effects.specifications, omit)) >= max(colnumber - 1, 1)){
          fixed.effects.names <- fixed.effects[order(unique(unlist(fixed.effects.specifications)))]
        } else {
          fixed.effects.names <- fixed.effects
        }
      } 
    } else { 
      if(length(c(fixed.effects.names, omit)) < length(c(fixed.effects, omit))){
        fixed.effects.names <- c(fixed.effects.names, fixed.effects[(length(fixed.effects.names)+1):length(fixed.effects)])
      }
      if(missing(fixed.effects.specifications)){
        fixed.effects.names <- fixed.effects.names[1:length(unique(c(fixed.effects, omit)))]
      } else {
        if(length(c(fixed.effects.specifications, omit)) >= max(colnumber - 1, 1)){
          fixed.effects.names <- fixed.effects.names[order(unique(unlist(fixed.effects.specifications)))]
        } else {
          fixed.effects.names <- fixed.effects.names[1:length(c(fixed.effects, omit))]
        }
      }
    }
  } else {
    fixed.effects.names <- NULL
  }
  
  # Checking if selected output to be silent, if so:
  if(!missing(silent)){
    if(silent == TRUE){
      # Print nothing, else:
      
    } else {
      
      # Else print creditation message:
      cat(creditation.message)      
    }
  } else {
    
    cat(creditation.message)
  } 
  
    # Adding custom FE lines to stargazer output if demeaning acceleration selected
  if(accelerate == TRUE){
    stargazer.add.lines <- vector("list", length(fixed.effects.names) + 1)  
    stargazer.add.lines <- lapply(fixed.effects.names, FUN = function(x) (c(paste(x), rep("Yes", colnumber - 1))))
    stargazer.add.lines[[length(fixed.effects.names) + 1]] <- "\\hline"

    fixed.effects.names <- NULL  
    fixed.effects <- NULL  
    
  } else {
    stargazer.add.lines <- NULL
  }
  
    # Constructing vector of fixed effects to exclude from table output
  if(!missing(fixed.effects)){
    if(!missing(fixed.effects.specifications)){
      if(length(fixed.effects.specifications) >= max(colnumber - 1, 1)){
        
        # If fixed specifications are more than or equal to number of columns, include only those provided.  
        stargazer.fixed.effects <- paste0("as.factor\\(", fixed.effects[order(unique(unlist(fixed.effects.specifications)))], ")")
      }
    } else {
      
      # If not, then include all fixed effects provided
      stargazer.fixed.effects <- paste0("as.factor\\(", fixed.effects, ")")
    }
  } else {
    # If no fixed effects provided, set to defaults:
    stargazer.fixed.effects <- NULL
  }
  
  # If demeaning acceleration, then exclude (non-informative) intercept
  if(accelerate == TRUE){
    stargazer.fixed.effects <- "Constant"
  }
  
  # If omit provided manually, then append this:
  if(!missing(omit)){
    stargazer.fixed.effects <- c(stargazer.fixed.effects, omit)
    fixed.effects.names <- c(fixed.effects.names, omit)[1:length(stargazer.fixed.effects)]
    }
  
  
  # Checking if user wants no console output, only html
  if(missing(html.only)){
    html.only <- FALSE
  } else {
    html.only <- html.only
  }
  
  # Ensuring covariates returned in correct order:
  if(missing(specifications)){
    stargazer.order <- iv.vars
  } else {
    stargazer.order <- iv.vars[sort(unique(unlist(specifications)))]
  }
   
  
  # Assigning all fits to a list:
  fits <- vector("list", colnumber-1)
  fits <-  lapply(paste("QuickReg.col", 1:(colnumber-1), sep = ""), FUN = get, envir=sys.frame(sys.parent(0)))
  
  ### Clustered SE
  
  if(!missing(cluster)){
    if(length(cluster) >= 1){  
      
      # Load required packages
      require(lmtest)
      require(sandwich)
      
      # Assigning all fits to a list:
      fits <- vector("list", colnumber-1)
      fits <-  lapply(paste("QuickReg.col", 1:(colnumber-1), sep = ""), FUN = get, envir=sys.frame(sys.parent(0)))
      
      # Loading the multiwayvcov package
      library(multiwayvcov, quietly = TRUE)
      
      # Container for cluster-robust standard errors
      cluster.robust.se <- vector("list", colnumber -1)
      
      # Looping through list and calculating Cluster-Robust Standard Errors:
      cluster.robust.se <- lapply(1:(colnumber-1), function(i) {
        
        # Calculating clustered vcov matrix
        fits[[i]]$na.action <- NULL
        vcov.cluster <- cluster.vcov(fits[[i]], cluster = data[complete.cases(data[, c(all.vars(formula(fits[[i]])), cluster)]), cluster])
        
        # Saving the resultant standard errors
        coeftest(fits[[i]], vcov. = vcov.cluster)[, 2]})
      
      # Re-assigning fits to list (to circumvent problem with na.action above in case of missing data)
      fits <- vector("list", colnumber-1)
      fits <-  lapply(paste("QuickReg.col", 1:(colnumber-1), sep = ""), FUN = get, envir=sys.frame(sys.parent(0)))
      
      # Making stargazer note:
      if(!missing(cluster.names)){
        if(!missing(cluster)){
          if(length(cluster.names) > length(cluster)){
            cluster.names <- cluster.names[1:length(cluster)]
          }  
          
          if(length(cluster.names) > 1) {
            cluster.names <- paste(c(paste(cluster.names[1:(length(cluster.names) - 1)], sep = "", collapse = ", "), " and ", cluster.names[length(cluster.names)]), collapse = "", sep = "")  
          } 
          stargazer.notes <- paste0("(", cluster.names ,"-Clustered Standard Errors in Parenthesis)") 
        } 
      } else {
        stargazer.notes <- "(Cluster-Robust Standard Errors in Parenthesis)"
      }
      
    # Saving fits to list if option selected.  
      if(save.fits.as.object == TRUE){
        assign(save.fits.name, list(lm.fits = fits, cluster.robust.se = cluster.robust.se), envir = .GlobalEnv)
      }
      
    # Returning tables:  
      if(html.only == FALSE){
        return(stargazer(fits, se = cluster.robust.se, omit=stargazer.fixed.effects, covariate.labels = iv.vars.names, title = table.title, dep.var.labels = dv.vars.names, type = type,   omit.labels = fixed.effects.names, out = out.name, notes.append = TRUE, notes = stargazer.notes, add.lines = stargazer.add.lines, order = stargazer.order, ...)) } else {
          log <- capture.output(stargazer(fits, se = cluster.robust.se, omit=stargazer.fixed.effects, covariate.labels = iv.vars.names, title = table.title, dep.var.labels = dv.vars.names, type = type,   omit.labels = fixed.effects.names, out = out.name, notes.append = TRUE, notes = stargazer.notes, add.lines = stargazer.add.lines, order = stargazer.order, ...))
        }
      
    } 
  } 
  else {
    
    ### Robust SE:  
    
    if(!missing(robust.se)){
      if(robust.se == TRUE){  
        library(lmtest, quietly = TRUE)
        library(sandwich, quietly = TRUE)
        
        # Looping through list and calculating robust Standard Errors based on sandwich estimator:
        robust.se <- vector("list", colnumber-1)  
        robust.se <- lapply(1:(colnumber-1), 
                            function(i) {
                              coeftest(fits[[i]], vcov. = sandwich)[, 2]
                            })
        
        # Selecting robust standard errors for output
        standard.errors <- robust.se
        
        # Specifying selected SE type
        se.type <- "Robust"
        
        
      } else {
        
        ### Normal SE:   
        
        # Calculate normal standard errors (if robust option other than TRUE)
        standard.errors <- vector("list", length(fits))    
        standard.errors <- lapply(fits, FUN= function(x) (coef(summary(x))[, "Std. Error"]))  
        
        se.type <- "Normal"
      }} else {
        
        # Calculate normal standard errors (if robust option not specified)
        standard.errors <- vector("list", length(fits))    
        standard.errors <- lapply(fits, FUN= function(x) (coef(summary(x))[, "Std. Error"]))
        
        se.type <- "Normal" 
      }
    
    if(save.fits.as.object == TRUE){
      assign(save.fits.name, list(lm.fits = fits, SE.type = se.type, SE = standard.errors), envir = .GlobalEnv)
    }
    
    if(html.only == FALSE){
      return(stargazer(fits, se = standard.errors, 
                       omit=stargazer.fixed.effects, covariate.labels = iv.vars.names,
                       title = table.title, 
                       dep.var.labels = dv.vars.names, type = type,  
                       omit.labels = fixed.effects.names,  out = out.name, notes.append = TRUE, notes = paste0("(", se.type," Standard Errors in Parenthesis)"), add.lines = stargazer.add.lines, order = stargazer.order, ...)) 
    }  
    else {
      log <- capture.output(stargazer(fits, se = standard.errors, omit=stargazer.fixed.effects, covariate.labels = iv.vars.names, title = table.title, dep.var.labels = dv.vars.names, type = type,   omit.labels = fixed.effects.names, out = out.name, notes.append = TRUE, notes = paste0("(", se.type," Standard Errors in Parenthesis)"), add.lines = stargazer.add.lines, order = stargazer.order, ...)) 
    }
  }
}

