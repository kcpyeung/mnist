# Read image pixels
print(paste("start at", Sys.time()))
imagefile <- file("train-images-idx3-ubyte", "rb")
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
labelfile <- file("train-labels-idx1-ubyte", "rb")
readBin(labelfile, integer(), size=4, n=1, endian="big")
readBin(labelfile, integer(), size=4, n=1, endian="big")
labels <- as.factor(readBin(labelfile, integer(), size=1, n=rows, endian="big", signed=FALSE))
close(labelfile)

print(paste("finished reading labels at", Sys.time()))

df <- cbind(labels, df)

print(paste("start training multinomial logistic regression at", Sys.time()))
library(nnet)
fit <- multinom(labels ~ ., data=df, MaxNWts=10000000)

save(fit, file="multinom.rda")
print(paste("finished training multinomial logistic regression at", Sys.time()))
