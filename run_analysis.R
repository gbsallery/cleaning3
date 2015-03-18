test = read.table("UCI HAR Dataset/test/X_test.txt")
train = read.table("UCI HAR Dataset/train/X_train.txt")

data <- rbind(test, train)

features = read.table("UCI HAR Dataset//features.txt")
colnames(data) <- unlist(features[2])

fd <- data[,grepl("(-mean|-std)", names(data))]

testY = read.table("UCI HAR Dataset/test/y_test.txt")
trainY = read.table("UCI HAR Dataset/train/y_train.txt")

acts <- rbind(testY, trainY)

d <- cbind(acts, fd)

labels = read.table("UCI HAR Dataset/activity_labels.txt")

final <- merge(d, labels, by="V1")
final$V1 <- NULL
names(final)[names(final) == 'V2'] <- 'activity'

avgs <- aggregate(final, list(final$activity), FUN=mean, na.action = na.omit)