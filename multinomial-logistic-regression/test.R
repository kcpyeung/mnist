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

print(paste("finished reading labels at", Sys.time()))

df <- cbind(labels, df)

# print("randomly sample 100 rows...")
# df <- df[sample(nrow(df), 100), ]

print(paste("started loading models at", Sys.time()))
load("multinom.rda")
print(paste("finished loading models at", Sys.time()))

print(paste("start prediction at", Sys.time()))
library(nnet)
df$predicted <- predict(fit, df)
# predicted <- c()
# for (i in 1:100) {
#   r <- df[i, ]
#   predicted[i] <- predict_digit(r)
# }
# df <- cbind(predicted, df)
correct <- df$predicted == df$labels
print(paste("finished prediction at", Sys.time()))

df <- df[df$predicted != df$labels, ]
bad <- df[, c("predicted", "labels")]
print(bad)
print(table(correct))
print(paste("accuracy: ", length(correct[correct]) / length(correct) * 100, "%"))
df$predicted <- NULL
df$labels <- NULL
par(mfrow=c(5,5))
par(mar=c(0,0,0,0))
for (i in 1:25) {
  r <- unlist(df[i, ])
  p <- matrix(r, nrow=y, ncol=x)
  image(p[, 28:1])
}

