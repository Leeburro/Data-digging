#                             ###              ###
#                    (^v^)    ##  Penguinwatch  ##   (^v^)    
#                  <(     )>  ##                ## <(     )>
#                     W W     ##      code      ##    W W
#                             ###              ###
         
                            

#thanks to baptiste from stack overflow
#http://stackoverflow.com/users/471093/baptiste
#Tom Hart, with original code from Robin Freeman



#
##
###

#Step 1: Preparation

###
##
#

# Photos should be in a folder with their cameraname (e.g. AITCb2018b) within a path that follows this pattern: Drive/Penguinwatch_Timelapse/colonyname_raw/cameraname_raw/  
# This can be done manually or refer to the "pw Backup v1.R" script that prepares all folders and copies raw data in the right place.
# If done manually an example of this would be C:/Penguinwatch_Timelapse/AITC/AITC_raw/AITCa2018b_raw/IMG_0001.JPG
# If you are new to programming and R we reccommend using RStudio to view the different scripts. To run functions like install.packages('jpeg') below select the lines you want to run and press Ctrl+Enter
# Install jpeg, grid and exiftoolr packages

install.packages('jpeg')
install.packages('grid')
install.packages('exiftoolr')
install_exiftool()#Before the first analysis we should use the exiftoolr package to install the exiftool program in the right directory



#
##
###

#Step 2: Select and run the full 'process' function below until the endbracket '}'

###
##
#
                                                            
                                                          
process<-function(cameras, path, codepath, t1, t2, t3){
                             

 for (j in 1:length(cameras)){
   
   path <<-path
   t1 <<- t1
   t2 <<- t2
   t3 <<- t3
  
 cameraname<<-cameras[j]
  
 print(cameraname)
  
  #setup folders to write images to.
  foldersetup<-paste(codepath, "pw setup folders v6.R", sep="")
  source(foldersetup, local = FALSE)
  setupfolders(path, cameraname)
  print(paste(cameraname, "Folder setup. TRUE"))
  
  #read the copy images function and copy images across to "renamed" folder
  copyallpath<-paste(codepath, "pw copyall v5.R", sep="")
  source(copyallpath, local = FALSE)
  copyall()
  print(paste(cameraname, "Images copied. TRUE"))
  
  #extract the metadata to a data file in the zooniverse folder
  metadataextractpath<-paste(codepath, "pw metadata extraction v6.R", sep="")
  source(metadataextractpath, local = FALSE)# this part of the code gives Warning messages apparently with no consequences
  metadataextract()
  print(paste(cameraname, "Metadata extraction. TRUE"))
  print(paste("Don't worry about warning messages here"))

   ## Select three pictures per day
  select3adaypath<-paste(codepath, "/pw select and reduce zooniverse v4.R", sep="")
  source(select3adaypath, local = FALSE)
  selectreducezooniverse()
  print(paste(cameraname, "Three a day selected. TRUE"))
  
  ##automatically select midday images
  selectmiddaypath<-paste(codepath, "pw midday and animation v2.R", sep="")
  source(selectmiddaypath, local = FALSE)
  selectmidday()
  print(paste(cameraname, "Midday img selected. TRUE. Cameras completed:",j, "/", length(cameras)))
  
}}



#
##
###

#Step 3: Using the function
###
##
#

#Arguments in the function:
# 'cameras': This argument should be a list of camera names to process. For example: c("AITCb2017a", "GASTa2018b", "ROOKa2018a")
# 'path': should be the address of the Penguinwatch_Timelapse folder that contains all colony names. For example: C:/Penguinwatch_Timelapse/
# 'codepath': This is the location of the .R files where the code for the necessary functions is stored. For example C:/R code/
# 't1', 't2' and 't3' are the three hours at which we are retrieving photos. Input format: "11:00:00"

#Warnings
# The process function in this script is going to call functions from other scripts, make sure the .R code file names inside the process function are correct and you are using the latest version. Also be careful as there are penguinwatch (pw) and seabirdwatch (sw) codes.
# Make sure you end both the path and codepath arguments in a forward slash '/'
# Write the three hours in chronological order ( t1 sooner than t2 and t2 sooner than  t3)


#Example:
#process(cameras = c("AITCb2018a","AITCb2018b"), # Feel free to add as many camera names in the parentheses as needed
#        path = "C:/Antarctic test/", 
#       codepath = "C:/Users/dtp18/Desktop/R code/",
#       t1 = "11:00:00",
#       t2 = "12:00:00",
#       t3 = "13:00:00")  
#

process(cameras = c('AITCb2018b'),
      path = "C:/Antarctic test/Penguinwatch_Timelapse/", 
      codepath = "C:/Users/dtp18/Desktop/R code/",
      t1 = "11:00:00",
      t2 = "12:00:00",
      t3 = "13:00:00")  

#
##
###

#Step 4: Upload the images to Zooniverse. Once the script has finished running pictures should be ready to use in the folder named zooniverse
###
##
#





