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
is_0 <- df$labels == 0
df <- cbind(is_0, df)
df$labels <- NULL
fit0 <- glm(is_0 ~ ., data=df, family=binomial(link="logit"))
df$is_0 <- NULL
save(fit0, file="fit0.rda")
rm(fit0)
gc()
print(paste("finished training digit 0 at", Sys.time()))

df <- cbind(labels, df)
is_1 <- df$labels == 1
df <- cbind(is_1, df)
df$labels <- NULL
fit1 <- glm(is_1 ~ ., data=df, family=binomial(link="logit"))
df$is_1 <- NULL
save(fit1, file="fit1.rda")
rm(fit1)
gc()
print(paste("finished training digit 1 at", Sys.time()))

df <- cbind(labels, df)
is_2 <- df$labels == 2
df <- cbind(is_2, df)
df$labels <- NULL
fit2 <- glm(is_2 ~ ., data=df, family=binomial(link="logit"))
df$is_2 <- NULL
save(fit2, file="fit2.rda")
rm(fit2)
gc()
print(paste("finished training digit 2 at", Sys.time()))

df <- cbind(labels, df)
is_3 <- df$labels == 3
df <- cbind(is_3, df)
df$labels <- NULL
fit3 <- glm(is_3 ~ ., data=df, family=binomial(link="logit"))
df$is_3 <- NULL
save(fit3, file="fit3.rda")
rm(fit3)
gc()
print(paste("finished training digit 3 at", Sys.time()))

df <- cbind(labels, df)
is_4 <- df$labels == 4
df <- cbind(is_4, df)
df$labels <- NULL
fit4 <- glm(is_4 ~ ., data=df, family=binomial(link="logit"))
df$is_4 <- NULL
save(fit4, file="fit4.rda")
rm(fit4)
gc()
print(paste("finished training digit 4 at", Sys.time()))

df <- cbind(labels, df)
is_5 <- df$labels == 5
df <- cbind(is_5, df)
df$labels <- NULL
fit5 <- glm(is_5 ~ ., data=df, family=binomial(link="logit"))
df$is_5 <- NULL
save(fit5, file="fit5.rda")
rm(fit5)
gc()
print(paste("finished training digit 5 at", Sys.time()))

df <- cbind(labels, df)
is_6 <- df$labels == 6
df <- cbind(is_6, df)
df$labels <- NULL
fit6 <- glm(is_6 ~ ., data=df, family=binomial(link="logit"))
df$is_6 <- NULL
save(fit6, file="fit6.rda")
rm(fit6)
gc()
print(paste("finished training digit 6 at", Sys.time()))

df <- cbind(labels, df)
is_7 <- df$labels == 7
df <- cbind(is_7, df)
df$labels <- NULL
fit7 <- glm(is_7 ~ ., data=df, family=binomial(link="logit"))
df$is_7 <- NULL
save(fit7, file="fit7.rda")
rm(fit7)
gc()
print(paste("finished training digit 7 at", Sys.time()))

df <- cbind(labels, df)
is_8 <- df$labels == 8
df <- cbind(is_8, df)
df$labels <- NULL
fit8 <- glm(is_8 ~ ., data=df, family=binomial(link="logit"))
df$is_8 <- NULL
save(fit8, file="fit8.rda")
rm(fit8)
gc()
print(paste("finished training digit 8 at", Sys.time()))

df <- cbind(labels, df)
is_9 <- df$labels == 9
df <- cbind(is_9, df)
df$labels <- NULL
fit9 <- glm(is_9 ~ ., data=df, family=binomial(link="logit"))
df$is_9 <- NULL
save(fit9, file="fit9.rda")
rm(fit9)
gc()
print(paste("finished training digit 9 at", Sys.time()))

