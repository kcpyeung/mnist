# Read image pixels
print(paste("start at", Sys.time()))
imagefile <- file("t10k-images-idx3-ubyte", "rb")
magic <- readBin(imagefile, integer(), size=4, n=1, endian="big")
rows <- readBin(imagefile, integer(), size=4, n=1, endian="big")
x <- readBin(imagefile, integer(), size=4, n=1, endian="big")
y <- readBin(imagefile, integer(), size=4, n=1, endian="big")

bytes <- readBin(imagefile, integer(), size=1, n=rows*x*y, endian="big", signed=FALSE)
close(imagefile)

m <- matrix(bytes, nrow=rows, ncol=x*y, byrow=TRUE)
df <- as.data.frame(m)

print(paste("finished reading images at", Sys.time()))

#Read labels
labelfile <- file("t10k-labels-idx1-ubyte", "rb")
readBin(labelfile, integer(), size=4, n=1, endian="big")
readBin(labelfile, integer(), size=4, n=1, endian="big")
labels <- as.factor(readBin(labelfile, integer(), size=1, n=rows, endian="big", signed=FALSE))
close(labelfile)

df <- cbind(labels, df)
print(paste("finished reading labels at", Sys.time()))

print("randomly sample 100 rows...")
df <- df[sample(nrow(df), 100), ]

print(paste("started loading models at", Sys.time()))
#Load models
load("fit0.rda")
load("fit1.rda")
load("fit2.rda")
load("fit3.rda")
load("fit4.rda")
load("fit5.rda")
load("fit6.rda")
load("fit7.rda")
load("fit8.rda")
load("fit9.rda")
print(paste("finished loading models at", Sys.time()))

predict_digit <- function(r) {
  predicted <- 0
  max_prob <- predict(fit0, r)
  
  prob <- predict(fit1, r)
  if (prob > max_prob) {
    max_prob <- prob
    predicted <- 1
  }
  
  prob <- predict(fit2, r)
  if (prob > max_prob) {
    max_prob <- prob
    predicted <- 2
  }
  
  prob <- predict(fit3, r)
  if (prob > max_prob) {
    max_prob <- prob
    predicted <- 3
  }
  
  prob <- predict(fit4, r)
  if (prob > max_prob) {
    max_prob <- prob
    predicted <- 4
  }
  
  prob <- predict(fit5, r)
  if (prob > max_prob) {
    max_prob <- prob
    predicted <- 5
  }
  
  prob <- predict(fit6, r)
  if (prob > max_prob) {
    max_prob <- prob
    predicted <- 6
  }
  
  prob <- predict(fit7, r)
  if (prob > max_prob) {
    max_prob <- prob
    predicted <- 7
  }
  
  prob <- predict(fit8, r)
  if (prob > max_prob) {
    max_prob <- prob
    predicted <- 8
  }
  
  prob <- predict(fit9, r)
  if (prob > max_prob) {
    max_prob <- prob
    predicted <- 9
  }
  
  return(predicted)
}

print(paste("start prediction at", Sys.time()))
predicted <- c()
for (i in 1:100) {
  r <- df[i, ]
  predicted[i] <- predict_digit(r)
}
df <- cbind(predicted, df)
correct <- df$predicted == df$labels
print(paste("finished prediction at", Sys.time()))

df <- df[df$predicted != df$labels, ]
bad <- df[, c("predicted", "labels")]
print(bad)
print(table(correct))
df$predicted <- NULL
df$labels <- NULL
par(mfrow=c(5,5))
par(mar=c(0,0,0,0))
for (i in 1:25) {
  r <- unlist(df[i, ])
  p <- matrix(r, nrow=y, ncol=x)
  image(p[, 28:1])
}
