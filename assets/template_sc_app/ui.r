###############################################################################
##                                                                           ##       

##                                                                           ##
###############################################################################



###############################################################################
##  Load required packages                                                   ##       
library(shiny)
library(ggplot2)
library(RMySQL)
library(DT)
library(colourpicker)
## To be added soon
#library(colourpicker)
##                                                                           ##
###############################################################################


###############################################################################
##                                                                           ##       
dfkey <- read.delim("connect/db.txt", header = T, sep="\t", stringsAsFactors = F)

geneDefault = as.character(dfkey$default)

host <- as.character(dfkey$url)
user <- as.character(dfkey$id)
DBpd <- as.character(dfkey$id2)
dbname <- as.character(dfkey$db)
coordinateTbName <- as.character(dfkey$coordTb)
exprTbName <- as.character(dfkey$exprTb)
geneID_TbName <- as.character(dfkey$geneTb)

##                                                                           ##
###############################################################################


###############################################################################
##                                                                           ##       
oldw <- getOption("warn")
options(warn = -1)
dbDB <- dbConnect(MySQL(), user = user, password = DBpd, host = host, dbname=dbname)
query <- paste0("SELECT DISTINCT * FROM ", coordinateTbName)
dfCoordSel <- dbGetQuery(dbDB, query)
dbDisconnect(dbDB)

dfCoordSel[["all"]] <- "all"
##                                                                           ##
###############################################################################


###############################################################################
##                                                                           ##       


conditionVec <- unique(sort(dfCoordSel$sampleName))

Nsamples <- length(conditionVec)


allOptions <- names(dfCoordSel)
rmNameVec <-c(
    "^DC",
    "uniquecellID",
    "hmIdent",
    "old_ident",
    "cellID", 
    "sample_group",
    "DF_pANN",
    "clusterColor",
    "sampleColor",
    "clustIdent",
    "G2M_Score",
    "DM_Pseudotime",
    "^Sub_clusters_ExNeurons$",
    "sample_group_colors",
    "row_names",
    "sampleID"
)

rmVec <- as.vector(NULL, mode = "numeric")
for (i in 1:length(rmNameVec)){
    rmVec <- c(
        rmVec,
        grep(rmNameVec[i], names(dfCoordSel))
    )
}

XYsel <- allOptions
if (length(rmVec) > 0){
    XYsel <- XYsel[-rmVec]
}

## Reorder
XYsel <- c(
    XYsel[grep("UMAP_", XYsel)],
    XYsel[grep("tSNE_", XYsel)],
    XYsel[grep("sampleName", XYsel)],
    XYsel[grep("clusterName", XYsel)],
    XYsel[grep("ClusterTame", XYsel)],
    XYsel[grep("ClusterTest", XYsel)],
    XYsel[grep("PC_", XYsel)],
    XYsel[grep("DM_Pseudotime", XYsel)],
    XYsel[grep("meta_", XYsel)],
    #XYsel[grep("DF_Classification", XYsel)],
    XYsel[grep("nCount", XYsel)],
    XYsel[grep("nFeatures", XYsel)],
    XYsel[grep("nCount", XYsel)],
    XYsel[grep("percent", XYsel)],
    XYsel[grep("nCount", XYsel)],
    XYsel[grep("nCount", XYsel)]
)



## Get color selection ##
allColorOptions <- c(
    #"Log10 Expresson" = "lg10Expr",
    #"DM Pseudotime"  = "DM_Pseudotime",
    "Sample" = "sampleName",
    "Cluster" = "clusterName",
    "Subcluster" = "subClusterName",
   # "WT vs. IDH" = "WT_IDH",
    "Gender" = "Gender",
  #  "Norm vs Hyp" = "Norm_Hyp",
  #  "Con Prad AZ" = "Con_Prad_AZ",
    "Cells From Tumor" = "CellFromTumor",
    "Patient" = "Patient",
    "Region" = "Region",
    "Article Cell Type" = "Article_Cell_Type",
    "Doublet Classification" = "DF_Classification" ,
    "nCount_RNA" = "nCount_RNA",
    "nFeature_RNA" = "nFeature_RNA",
    "percent_mt" = "percent_mt",
    "S Phase Score" = "S_Score",
    "G2M Score" = "G2M_Score",
    "Cell Cycle Phase" = "Phase",
    "Uniform" = "all"
)

colAddvec <- c(
  XYsel[grep("ClusterTest", XYsel)],
  XYsel[grep("meta_", XYsel)]
)

names(colAddvec) <- colAddvec

allColorOptions <- c(
    allColorOptions, 
    colAddvec
)




splitOptions <- c(
  "Sample" = "sampleName",
  "Cluster" = "clusterName",
  "SubCluster" = "subClusterName",
  "Patient" = "Patient",
  "Gender" = "Gender",
  #"Norm vs Hyp" = "Norm_Hyp",
  #"Con Prad AZ" = "Con_Prad_AZ",
  "Cells From Tumor" = "CellFromTumor",
  "Region" = "Region",
  "Article Cell Type" = "Article_Cell_Type",
  #"Doublet Classification" = "DF_Classification" ,
  "None" = "all",
  "WT vs. IDH" = "WT_IDH",
  "Gender" = "Gender",
  "Doublet Classification" = "DF_Classification" ,
  "Cell Cycle Phase" = "Phase"
)

splitAddvec <- c(
  #XYsel[grep("ClusterTest", XYsel)],
  XYsel[grep("meta_", XYsel)]
)

names(splitAddvec) <- splitAddvec
names(splitAddvec) <- gsub("meta", "", names(splitAddvec))
names(splitAddvec) <- gsub("Meta", "", names(splitAddvec))
names(splitAddvec) <- gsub("^_", "", names(splitAddvec))

splitOptions <- c(
  splitAddvec,
  splitOptions
  
)


splitOptions <- splitOptions[splitOptions %in% names(dfCoordSel)]

allColorOptions <- allColorOptions[allColorOptions %in% names(dfCoordSel)]
allColorOptions <- 
    c(
        "Log10 Expression" = "lg10Expr",
        allColorOptions
    )



##                                                                           ##
###############################################################################


###############################################################################
##                                                                           ##       

oldw <- getOption("wafrn")
options(warn = -1)

dbDB <- dbConnect(MySQL(), user = user, password = DBpd, host = host, dbname=dbname)
query <- paste0("SELECT DISTINCT gene FROM ", geneID_TbName)
allGenes <- as.vector(dbGetQuery(dbDB, query)[,"gene"])
dbDisconnect(dbDB)

##                                                                           ##
###############################################################################



###############################################################################
##                                                                           ##       

shinyUI(fluidPage(
    navbarPage(
      
      
        "bioLOGIC SC",
               
        tabPanel("FeatureView"),
        tags$head(
          
          tags$style(type = 'text/css', 
                     HTML('.navbar { background-color: #42972050;}
                          .navbar-default .navbar-brand{color: white;}
                          .tab-panel{ background-color: red; color: white}
                          .navbar-default .navbar-nav > .active > a, 
                           .navbar-default .navbar-nav > .active > a:focus, 
                           .navbar-default .navbar-nav > .active > a:hover {
                                color: #555;
                                background-color: #42972050;
                            }')
          ),
          tags$script(HTML("var header = $('.navbar > .container-fluid');
header.append('<div style=\"float:left\"><ahref=\"URL\"><img src=\"assets/images/logo.ico\" alt=\"alt\" style=\"float:right;width:33px;height:41px;padding-top:10px;\"> </a>`</div>');
    console.log(header)")
          ),
          tags$link(rel="shortcut icon", href="assets/images/logo.ico")
        )
    
    ),
    #titlePanel("FeatureView"),
    sidebarLayout(
        sidebarPanel(
            tags$style(".well {background-color:#42972050;}"),
            helpText("To create a Violin-style plot, select, for example, as x-axis: seurat clusters, as y-axis: log10Expr and as colorBy: seurat clusters. \n\n To view averaged expression values for signature gene categories, start typing cat_ in the search box to see category suggestions. "),
            
            selectizeInput("gene", 
                           label = "Gene or Category Selection",
                           choices = NULL, #c(as.vector(sort(unique(allGenes)))),
                           selected = geneDefault,
                           options = list(maxOptions = 50)) ,
            
            selectInput("x_axis", 
                        label = "Choose an X-axis",
                        choices =unique(c("Log10 Expression" = "lg10Expr", allColorOptions, XYsel)),
                        selected = "UMAP_1"),
            selectInput("y_axis", 
                        label = "Choose an Y-axis",
                        choices =unique(c("Log10 Expression" = "lg10Expr", XYsel)),
                        selected = "UMAP_2"),
            
            selectInput("splitByColumn", 
                        label = "Split Plots By",
                        choices = splitOptions,
                        selected = splitOptions[1]),
            
            selectInput("colorBy", 
                        label = "Color Plots By",
                        choices = allColorOptions,
                        selected = names(allColorOptions)[1]),
            
            ## To be added soon
            #colourInput("dotcolor", "Choose dot colorscale", "darkblue"),
            colourInput("dotcolor", "Select colour", "darkblue"),
            colourInput("lowColor", "Select colour", "#D3D3D3"),
            selectInput("background",
                        label = "Select Background",
                        choices =c("Grey" = "grey", "White" = "white","Minimal" = "minimal", "Plain" =  "plain"),
                        selected = "white"),
            
            
            
            
            radioButtons("dotsize", label = "Choose a Dotsize", choices = c("0.1","0.5","1","2"), selected = "1",
                         inline = FALSE, width = NULL, choiceNames = c("0.1","0.5","1","2"),
                         choiceValues = c("0.1","0.5","1","2")),
            
            # selectInput("dotsize", 
            #             label = "Choose an Dotsize",
            #             choices =c("0.1","0.5","1","2"),
            #             selected = "1"),
            
            #downloadButton('downloadPlot', "Download Plot"),
            
            
            
            #downloadButton("downloadData", "Download Data"),
            
            # checkboxGroupInput("selected_sample",
            #                    label = "Select Column",
            #                    choices = seq_along(mtcars))
            
            
        ),
        mainPanel(
            
                            fluidRow(
                                column(12,
                                       uiOutput("multi_plot_ui")
                                )
                            ),
                            fluidRow(
                              column(12,
                                     textOutput("dev_text")
                              )
                            )
                         
            
        )
        
        
    )
))
      
##                                                                           ##
###############################################################################


