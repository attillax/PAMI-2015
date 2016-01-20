# This script is a derivative work from the "image segmentation demo" by Ryan Walker
# Check out the "Color quantization in R" tutorial at 
#   http://www.r-bloggers.com/color-quantization-in-r/
# author: rwalker (ryan@ryanwalker.us)
# license: MIT

library("jpeg")
library("png")
library("graphics")
library("ggplot2")
library("grid")
library("gridExtra")
#######################################################################################
# This script demonstrates a very simple image segmenter on color scheme
#######################################################################################
#
# Kmeans based segmenter
# 
segment_image = function(img, n){
  # create a flat, segmented image data set using kmeans
  # Segment an RGB image into n groups based on color values using Kmeans
  df = data.frame(
    red = matrix(img[,,1], ncol=1),
    green = matrix(img[,,2], ncol=1),
    blue = matrix(img[,,3], ncol=1)
  )
  
  # enter kmeans code here
  # K = ...
  # the function returns a structure whose attribute "cluster" contains the labels
  df$label = K$cluster
  
  # compute rgb values and color codes based on Kmeans centers
  colors = data.frame(
    label = 1:nrow(K$centers), 
    R = K$centers[,"red"],
    G = K$centers[,"green"],
    B = K$centers[,"blue"],
    color=rgb(K$centers)
  )
  
  # merge color codes on to df but maintain the original order of df
  df$order = 1:nrow(df)
  df = merge(df, colors)
  df = df[order(df$order),]
  df$order = NULL
  
  return(df)
  
}

#
# reconstitue the segmented images to RGB matrix
#
build_segmented_image = function(df, img){
  # reconstitue the segmented images to RGB array
  
  # get mean color channel values for each row of the df.
  R = matrix(df$R, nrow=dim(img)[1])
  G = matrix(df$G, nrow=dim(img)[1])
  B = matrix(df$B, nrow=dim(img)[1])
  
  # reconsitute the segmented image in the same shape as the input image
  img_segmented = array(dim=dim(img))
  img_segmented[,,1] = R
  img_segmented[,,2] = G
  img_segmented[,,3] = B
  
  return(img_segmented)
}

#
# 2D projection for visualizing the kmeans clustering
#
project2D_from_RGB = function(df){
  # Compute the projection of the RGB channels into 2D
  PCA = prcomp(df[,c("red","green","blue")], center=TRUE, scale=TRUE)
  pc2 = PCA$x[,1:2]
  df$x = pc2[,1]
  df$y = pc2[,2]
  return(df[,c("x","y","label","R","G","B", "color")])
}

#
# Create the projection plot of the clustered segments
#
plot_projection <- function(df, sample.size){
  # plot the projection of the segmented image data in 2D, using the
  # mean segment colors as the colors for the points in the projection
  index = sample(1:nrow(df), sample.size)
  return(ggplot(df[index,], aes(x=x, y=y, col=color)) + geom_point(size=2) + scale_color_identity())
}

#
# Inspect
#
inspect_segmentation <- function(image.raw, image.segmented, image.proj){
  # helper function to review the results of segmentation visually
  img1 = rasterGrob(image.raw)
  img2 = rasterGrob(image.segmented)
  plt = plot_projection(image.proj, 50000)
  grid.arrange(arrangeGrob(img1,img2, nrow=1),plt)
}

##############################################################
# DEMO
##############################################################
cat("
-------------------------------------------------------------------------------------
Welcome to the fourth PAMI demo/homework (year 2016): clustering

This year we are focusing on a single algorithm: K-Means. In particular, we are going
to use a particular application (color quantization) to study some of its properties.

To do this, we are relying on a recent demo which is published and described in detail
at the following URL:

http://www.r-bloggers.com/color-quantization-in-r/

Check it out and get ready to answer the following questions!

NOTE: the demo will try to download some images from different URLs. If you have no
connectivity, make sure to set the working directory to the one where this script
resides, so the local copies of the images will be used instead.

")

invisible(readline(prompt = "Press [enter] to continue"))  

cat("
The first task you are assigned is to understand how k-means is used to perform color
quantization. To do this, you first need to complete the code in the segment_image
function (adding a call to the k-means function you find in the \"stats\" library),
then answer the following question:

Q1) What does the segment_image function do? What are the operations to be performed 
    if you want to do color quantization using k-means?

Once you have completed the code in segment_image the demo will continue, otherwise
it will stop with an error (object 'K' not found) after you press [enter].

")

invisible(readline(prompt = "Press [enter] to continue"))  


# some interesting sample images -- download them if they aren't in the current working directory
if(!file.exists("mandrill.png")){
  download.file(url = "http://graphics.cs.williams.edu/data/images/mandrill.png", destfile="mandrill.png")
  download.file(url = "https://upload.wikimedia.org/wikipedia/commons/2/28/RGB_illumination.jpg", destfile="RGB_illumination.jpg")
  download.file(url = "http://r0k.us/graphics/kodak/kodak/kodim03.png", destfile="kodim03.png")
  download.file(url = "http://r0k.us/graphics/kodak/kodak/kodim22.png", destfile="kodim22.png")
}

# we can work with both JPEGs and PNGS.  For simplicty, we'll always write out to PNG though.
mandrill <- readPNG("mandrill.png")
rgb <- readJPEG("RGB_illumination.jpg")
hats <- readPNG("kodim03.png")
barn <- readPNG("kodim22.png")

# segment -- tune the number of segments for each image
mandrill.df = segment_image(mandrill, 7)
rgb.df = segment_image(rgb, 12)
hats.df = segment_image(hats, 8)
barn.df = segment_image(barn, 10)

# project RGB channels
mandrill.proj = project2D_from_RGB(mandrill.df)
rgb.proj = project2D_from_RGB(rgb.df)
hats.proj = project2D_from_RGB(hats.df)
barn.proj = project2D_from_RGB(barn.df)

# create segmented image data structure and write to disk
mandrill.segmented = build_segmented_image(mandrill.df, mandrill)
rgb.segmented = build_segmented_image(rgb.df, rgb)
hats.segmented = build_segmented_image(hats.df, hats)
barn.segmented = build_segmented_image(barn.df, barn)

# write the segmented images to disk
writePNG(mandrill.segmented, "mandrill_segmented.png" )
writePNG(rgb.segmented, "rgb_illumination_segmented.png")
writePNG(hats.segmented, "kodim03_segmented.png")
writePNG(barn.segmented, "kodim22_segmented.png")

# inspect the results
dev.new()
inspect_segmentation(mandrill, mandrill.segmented, mandrill.proj)
dev.new()
inspect_segmentation(rgb, rgb.segmented, rgb.proj)
dev.new()
inspect_segmentation(hats, hats.segmented, hats.proj)
dev.new()
inspect_segmentation(barn, barn.segmented, barn.proj)

cat("
Now that you ran the full demo, you should have the quantized images saved on your
disk, and four windows showing you the results of the quantization (both on the 
colormap and on the final image). Try to answer the following questions:

Q2: What are the observations in this particular application and what is the
    dimensionality of your problem?

")
invisible(readline(prompt = "Press [enter] to continue"))  


cat("
Q3) Try to run the following code many times and comment the results: are they always 
    the same or not? Does this behavior confirm your expectations? Now try to do the 
    same after modifying the call to k-means as kmeans(df,n, algorithm = \"MacQueen\"). 
    Do results change now or not? What can you deduce from this (the fact that in some
    cases the two algorithms behave differently)?

HINT: differences might not be visible at a glance. Try to use a more robust way to
check them out, e.g. if you have two rgb.segmented_* images (1 and 2) you can 
run norm(as.matrix(rgb.segmented_1 - rgb.segmented_2)). Also, you can show
the differences with 
inspect_segmentation(rgb, abs(rgb.segmented_1-rgb.segmented_2), rgb.proj)

")
invisible(readline(prompt = "Press [enter] to continue"))  

rgb.df = segment_image(rgb, 8)
rgb.proj = project2D_from_RGB(rgb.df)
rgb.segmented_1 = build_segmented_image(rgb.df, rgb)
dev.new()
inspect_segmentation(rgb, rgb.segmented_1, rgb.proj)
# you can repeat the above code for rgb.segmented_2 below here

cat("
Q4) We know that k-means needs to have K (the number of clusters) provided 
in advance. What is the meaning of k here? Try to run the previous code
many times with different values of k and comment the results. Are they better?
Are they more stable?

")
invisible(readline(prompt = "Press [enter] to continue"))  


cat("
As you have seen, increasing K gives you a quantized image with a better quality,
i.e. one which is closer to the original image.

Q5) Is there a way to find the \"best K\" for this application? As an example,
    try running the following code to calculate the SSE of the quantized image
    w.r.t. the original one for different values of K, plot them and comment
    the results (could you spot a K which is clearly better than others using
    the \"elbow method\"? Is the result qualitatively satisfying or do you 
    need a much bigger K to have a good image?). Also think about alternatives
    to the elbow method if that is not sufficient (e.g. what if you choose the
    K that lowers the average error down to a given threshold?)
    
HINT: you can try the same code on different images (the fewer colors they have, 
the easier it might be to spot an elbow). If kmeans returns weird warnings, you
can change the algorithm e.g.  kmeans(df, n, iter.max = 1000, algorithm=\"Lloyd\").

")

invisible(readline(prompt = "Press [enter] to continue (and wait a little while)"))  

image = rgb
err = 0
for(k in 1:30){
  image.segmented = build_segmented_image(segment_image(image, k), image)
  err[k] =  sum((image-image.segmented)^2)
}

plot(err)
# choose the best k, recompute and show it
#best_k = ...
#image.df = segment_image(image, best_k)
#image.segmented = build_segmented_image(image.df, image)
#image.proj = project2D_from_RGB(image.df)
#dev.new()
#inspect_segmentation(image, image.segmented, image.proj)
