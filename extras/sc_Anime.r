

library(bioLOGIC)

dfMeta <- import.db.table.from.db(
    dbtable = "vpl412_PCA",
    dbname = "vpl_data",
    user     = "boeingS",
    password = "5+3f4nB04042018",
    host     = "10.27.241.82"
)

dfMeta <- dfMeta[,c("PC1", "PC2", "sampleID", "clusterName","clusterColor", "sampleColor", "DM_Pseudotime")]
dfMeta$sampleID <- factor(dfMeta$sampleID, levels = c("DIV0", "DIV4", "DIV10", "DIV20"))
dfMeta$DM_Pseudotime


min(dfMeta$DM_Pseudotime)
max(dfMeta$DM_Pseudotime)


b <- seq(from = 0, to = ceiling(max(dfMeta$DM_Pseudotime)), by = 0.05)
names <- c(paste0("P", 2:length(b)))


dfMeta$TimeBin <- cut(dfMeta$DM_Pseudotime, breaks = b, labels = names)

library(gganimate)
#> Loading required package: ggplot2
dir.create("partT1")
dir.create("partT2")


# We'll start with a static plot
p <- ggplot(dfMeta, aes(x = PC1, y = PC2, color = clusterName)) +
    geom_point()

p2 <- p + facet_wrap( ~ sampleID,  ncol = 2)

setwd("partT1")
anim <- p +
    transition_states(sampleID,
                      transition_length = 3,
                      state_length = 1)



anim <- anim +
    enter_fade() + enter_drift(x_mod = -1) +
    exit_shrink() + exit_drift(x_mod = 5) +
    ggtitle('Now showing {closest_state}',
            subtitle = 'Frame {frame} of {nframes}')

anim

setwd("../partT2")
anim <- p2 +
    transition_states(sampleID,
                      transition_length = 3,
                      state_length = 1)



anim <- anim +
    enter_fade() + enter_drift(x_mod = -1) +
    exit_shrink() + exit_drift(x_mod = 5) +
    ggtitle('Now showing {closest_state}',
            subtitle = 'Frame {frame} of {nframes}')

anim


###############################################################################
## Combine both in one video
setwd("..")
png1 <- paste0("partT1/", list.files("partT1"))
png2 <- paste0("partT2/", list.files("partT2"))

videoDir <- "/Volumes/babs/www/boeings/bioLOGIC_external/data/vpl412/html/report_videos/"

if (!dir.exists(videoDir)){
    dir.create(videoDir)
}

FNtsVideo <- paste0(videoDir, "TSanime.mp4")

library(av)
png_files <- c(png1) #sprintf("input%03d.png", 1:10)
av::av_encode_video(png_files, FNtsVideo , framerate = 1)



## Done
###############################################################################

###############################################################################
## Cycle through PCs

library(bioLOGIC)
library(tidyr)

dfMeta <- import.db.table.from.db(
    dbtable = "vpl412_PCA",
    dbname = "vpl_data",
    user     = "boeingS",
    password = "5+3f4nB04042018",
    host     = "10.27.241.82"
)

dfAnno <- dfMeta[,c("cellID", "sampleID", "sampleColor", "clusterName", "clusterColor", "DM_Pseudotime")]

selVec <- c(
    names(dfMeta)[grep("^UMAP", names(dfMeta))],
    names(dfMeta)[grep("^PC", names(dfMeta))]
)

odd <- seq_along(selVec) %% 2 == 1

dfPair <- data.frame(
    odd = selVec[odd],
    even = selVec[!odd]
)

dfPair[["ID"]] <- paste0(dfPair$odd, "_vs_", dfPair$even)

dfMetaX <- dfMeta[, c("cellID", selVec[odd])] %>% pivot_longer(
    cols = all_of(selVec[odd]),
    names_to = "DimX",
    values_to = "X",
    values_drop_na = TRUE
)

dfMetaX[["Dim"]] <- dfMetaX$DimX

for (i in 1:nrow(dfPair)){
    dfMetaX[["Dim"]] <- gsub(dfPair[i, "odd"], dfPair[i, "ID"], dfMetaX$Dim) 
}

dfMetaX[["mergeID"]] <- paste0(dfMetaX$cellID, "_", dfMetaX$Dim)

dfMetaY <- dfMeta[,c("cellID", selVec[!odd])] %>% pivot_longer(
    cols = all_of(selVec[!odd]),
    names_to = "DimY",
    values_to = "Y",
    values_drop_na = TRUE
)

dfMetaY[["Dim"]] <- dfMetaY$DimY
for (i in 1:nrow(dfPair)){
    dfMetaY[["Dim"]] <- gsub(dfPair[i, "even"], dfPair[i, "ID"], dfMetaY$Dim) 
}

dfMetaY[["mergeID"]] <- paste0(dfMetaY$cellID, "_", dfMetaY$Dim)
dfMetaY$cellID <- NULL
dfMetaY$Dim <- NULL


dfMeta2 <- merge(
    dfMetaX,
    dfMetaY, 
    by.x = "mergeID",
    by.y = "mergeID"
)

dfMeta <- merge(
    dfAnno, 
    dfMeta2, 
    by.x = "cellID",
    by.y = "cellID"
)

## Done 
###############################################################################

###############################################################################
## Plots and Annimations                                                     ##

library(gganimate)
#> Loading required package: ggplot2

# We'll start with a static plot
dfMeta$sampleID <- factor(dfMeta$sampleID, levels = c("DIV0", "DIV4", "DIV10", "DIV20"))
dfMeta$Dim <- factor(dfMeta$Dim, levels= sort(unique(dfMeta$Dim), decreasing = T))
dfMeta <- dfMeta[order(dfMeta$Dim, dfMeta$sampleID, dfMeta$clusterName),]

p <- ggplot(dfMeta, aes(x = X, y = Y, color = clusterName)) +
    geom_point()

p2 <- p + facet_wrap( ~ sampleID,  ncol = 2)

dir.create("part1")
dir.create("part2")
setwd("part1")


anim <- p + transition_states(
    Dim,
    transition_length = 3,
    state_length = 1
) 



anim <- anim + enter_fade() + enter_drift(x_mod = -1) +
    exit_shrink() + exit_drift(x_mod = 5) +
    ggtitle('Now showing {closest_state}',
            subtitle = 'Frame {frame} of {nframes}')

anim

setwd("../part2")

anim <- p2 + transition_states(
    Dim,
    transition_length = 3,
    state_length = 1
)  


anim <- anim +
    enter_fade() + enter_drift(x_mod = -1) +
    exit_shrink() + exit_drift(x_mod = 5) + ggtitle('Now showing {closest_state}',
                                                    subtitle = 'Frame {frame} of {nframes}')

anim

library(av)
png_files <- list.files() #sprintf("input%03d.png", 1:10)
av::av_encode_video(png_files, '../PCdim.mp4', framerate = 1)
utils::browseURL('../output.mp4')


## Done                                                                      ##
###############################################################################