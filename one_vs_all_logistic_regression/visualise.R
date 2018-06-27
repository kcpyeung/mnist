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

print("rendering...")
par(mfrow=c(5,5))
par(mar=c(0,0,0,0))
for (i in 1:25) {
  r <- unlist(df[i, ])
  p <- matrix(r, nrow=y, ncol=x)
  image(p[, 28:1])
}

