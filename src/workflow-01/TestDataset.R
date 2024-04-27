# limpio la memoria
rm(list = ls(all.names = TRUE)) # remove all objects
gc(full = TRUE) # garbage collection

require("data.table")
require("yaml")
library(caret)

dataset <- fread( "buckets/b1/datasets/competencia_2024.csv.gz" )


n_samples = length(unique(dataset$foto_mes))
X <- Filter(function(x) x > 202101, unique(dataset$foto_mes))
X

# Definir la división temporal en 2 conjuntos
splits <- createTimeSlices(X, initialWindow = 3, horizon = 1, fixedWindow = FALSE)
splits$train
splits$test
# Configurar la visualización
par(mfrow = c(3, 1))

# Iterar sobre las divisiones y visualizar
for (i in 1:length(splits$test)) {
  train_index <- splits$train[i]
  test_index <- splits$test[i]
  
  train <- X[unlist(train_index)]
  test <- X[unlist(test_index)]
  
  cat('Observations:', length(train) + length(test), '\n')
  cat('Training Observations:', length(train), ' -> ' ,train, '\n')
  cat('Testing Observations:', length(test), ' -> ', test, '\n')
  
}