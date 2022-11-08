#Installing SIAMCAT and dependencies
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("SIAMCAT")

#Import libraries
library("SIAMCAT")
library(phyloseq)
library(dplyr)


#Reading data from organisms abundances
df <- read.csv(file = 'reads-organisms.csv')
df <- df[,-2:-4]
df <- df[,-14]
rownames(df) <- df$Name
df = df[,-1]

#Parse all column as numeric
df$ERR1398068 <- as.numeric(df$ERR1398068) 
df$ERR1398168 <- as.numeric(df$ERR1398168)
df$ERR1398221 <- as.numeric(df$ERR1398221)
df$ERR1398129 <- as.numeric(df$ERR1398129)
df$ERR1398206 <- as.numeric(df$ERR1398206)
df$ERR1398263 <- as.numeric(df$ERR1398263)
df$ERR1398076 <- as.numeric(df$ERR1398076)
df$ERR1398077 <- as.numeric(df$ERR1398077)
df$ERR1398085 <- as.numeric(df$ERR1398085)
df$ERR1398078 <- as.numeric(df$ERR1398078)
df$ERR1398257 <- as.numeric(df$ERR1398257)
df$ERR1398089 <- as.numeric(df$ERR1398089)

# Normalize data
df$ERR1398068 <- (df$ERR1398068)/(sum(df$ERR1398068))
df$ERR1398168 <-  (df$ERR1398168)/(sum(df$ERR1398168))
df$ERR1398221 <-  (df$ERR1398221)/(sum(df$ERR1398221))
df$ERR1398129 <-  (df$ERR1398129)/(sum(df$ERR1398129))
df$ERR1398206 <- (df$ERR1398206)/(sum(df$ERR1398206))
df$ERR1398263 <-  (df$ERR1398263)/(sum(df$ERR1398263))
df$ERR1398076 <- (df$ERR1398076)/(sum(df$ERR1398076))
df$ERR1398077 <- (df$ERR1398077)/(sum(df$ERR1398077))
df$ERR1398085 <- (df$ERR1398085)/(sum(df$ERR1398085))
df$ERR1398078 <- (df$ERR1398078)/(sum(df$ERR1398078))
df$ERR1398257 <- (df$ERR1398257)/(sum(df$ERR1398257))
df$ERR1398089 <- (df$ERR1398089)/(sum(df$ERR1398089))


#Loading metadata 
metadata <- read.table('metadata_v2.txt',sep='\t')
names(metadata) <- c("Sample", "Group")
rownames(metadata) <- metadata$Sample
metadata$Sample <- NULL

#Creating labels for phyloseq object
label <- create.label(meta=metadata, label="Group",
                      case = 'Hipertension', control='No hipertension')

#Creating phyloseq object
sc.obj <- siamcat(feat=df, meta=metadata, label=label)
show(sc.obj)

#Filter features
sc.obj <- filter.features(sc.obj,
                          filter.method = 'abundance'
                          ,cutoff = 0.001)


#Check associations
sc.obj <- check.associations(
  sc.obj,
  sort.by = 'fc',
  alpha = 0.9,
  mult.corr = "fdr",
  detect.lim = 10^-6,
  plot.type = "quantile.box",
  panels = c("fc", "prevalence", "auroc"))



############# Creating custom models #############

#Normalize features values
sc.obj <- normalize.features(
  sc.obj,
  norm.method = "log.unit",
  norm.param = list(
    log.n0 = 1e-06,
    n.p = 2,
    norm.margin = 1
  )
)

#Split data for models
sc.obj <-  create.data.split(
  sc.obj,
  num.folds = 2,
  num.resample = 1
)

#Train model with lasso method
sc.obj <- train.model(
  sc.obj,
  method = "lasso"
)

#Train model with ridge method
sc.obj <- train.model(
  sc.obj,
  method = "ridge"
)


# get information about the model type
model_type(sc.obj)
# access the models
models <- models(sc.obj)
models[[1]]

#Make predictions with the created model
sc.obj <- make.predictions(sc.obj)
pred_matrix <- pred_matrix(sc.obj)
head(pred_matrix)

#Evaluate the 
sc.obj <-  evaluate.predictions(sc.obj)
model.evaluation.plot(sc.obj)



