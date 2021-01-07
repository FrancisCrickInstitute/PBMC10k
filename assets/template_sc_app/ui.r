###############################################################################
##                                                                           ##       

##                                                                           ##
###############################################################################



###############################################################################
##                                                                           ##       
library(shiny)
library(ggplot2)
library(RMySQL)
library(DT)
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


conditionVec <- unique(sort(dfCoordSel$sampleID))

Nsamples <- length(conditionVec)


XYsel <- c(
  names(dfCoordSel)[grep("UMAP", names(dfCoordSel))],
  names(dfCoordSel)[grep("tSNE", names(dfCoordSel))],
  names(dfCoordSel)[grep("seurat_clusters", names(dfCoordSel))],
  names(dfCoordSel)[grep("sub_clusters", names(dfCoordSel))],
  names(dfCoordSel)[grep("PC", names(dfCoordSel))],
  names(dfCoordSel)[grep("DM_Pseudotime", names(dfCoordSel))],
  names(dfCoordSel)[grep("DF_Classification", names(dfCoordSel))],
  names(dfCoordSel)[grep("nCount", names(dfCoordSel))],
  names(dfCoordSel)[grep("nFeatures", names(dfCoordSel))],
  names(dfCoordSel)[grep("percent", names(dfCoordSel))],
  #names(dfCoordSel)[grep("Con_Prad_AZ", names(dfCoordSel))],
  #names(dfCoordSel)[grep("Norm_Hyp", names(dfCoordSel))],
  names(dfCoordSel)[grep("Gender", names(dfCoordSel))],
  names(dfCoordSel)[grep("CellFromTumor", names(dfCoordSel))],
  names(dfCoordSel)[grep("Patient", names(dfCoordSel))],
  names(dfCoordSel)[grep("Region", names(dfCoordSel))],
  names(dfCoordSel)[grep("Article_Cell_Type", names(dfCoordSel))]
)

## Get color selection ##
allColorOptions <- c(
    #"Log10 Expresson" = "lg10Expr",
    "DM Pseudotime"  = "DM_Pseudotime",
    "SampleID" = "sampleID",
   # "WT vs. IDH" = "WT_IDH",
    "Gender" = "Gender",
  #  "Norm vs Hyp" = "Norm_Hyp",
  #  "Con Prad AZ" = "Con_Prad_AZ",
    "Cells From Tumor" = "CellFromTumor",
    "Patient" = "Patient",
    "Region" = "Region",
    "Article Cell Type" = "Article_Cell_Type",
    "Doublet Classification" = "DF_Classification" ,
    "Cluster" = "seurat_clusters",
    "Subclusters T-Cell" = "sub_clusters_T_cells",
    "Sub-clusters Ex Neurons" = "sub_clusters_ExNeurons",
    "Sub-sub Clusters" = "sub_sub_clusters_ExNeurons",
    "SubCluster_2" = "sub_cluster_3",
    "nCount_RNA" = "nCount_RNA",
    "nFeature_RNA" = "nFeature_RNA",
    "percent_mt" = "percent_mt",
    "S Phase Score" = "S_Score",
    "G2M Score" = "G2M_Score",
    "Cell Cycle Phase" = "Phase",
    "Uniform" = "all"
)

splitOptions <- c(
  "SampleID" = "sampleID",
  "Patient" = "Patient",
  "Gender" = "Gender",
  #"Norm vs Hyp" = "Norm_Hyp",
  #"Con Prad AZ" = "Con_Prad_AZ",
  "Cells From Tumor" = "CellFromTumor",
  "Region" = "Region",
  "Article Cell Type" = "Article_Cell_Type",
  "Doublet Classification" = "DF_Classification" ,
  "None" = "all",
  "WT vs. IDH" = "WT_IDH",
  "Gender" = "Gender",
  "Doublet Classification" = "DF_Classification" ,
  "Cluster" = "seurat_clusters",
  "Sub-clusters Ex Neurons" = "sub_clusters_ExNeurons",
  "Sub-sub Clusters" = "sub_sub_clusters_ExNeurons",
  "SubCluster_2" = "sub_cluster_3",
  "Cell Cycle Phase" = "Phase"
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
            
            
            selectInput("dotcolor", 
                        label = "Choose dot colorscale",
                        choices =c("Darkblue" = "darkblue","Red" = "red","Orange" = "orange", "Green" =  "#009900"),
                        selected = "darkblue"),
            
            selectInput("lowColor",
                        label = "Choose low colorscale",
                        choices =c("Grey" = "#D3D3D3", "White" = "white","Orange" = "orange", "Green" =  "#009900"),
                        selected = "#D3D3D3"),
            
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


