#Source file (downloaded from https://www.jets.nhs.uk/NED/CMS_Documents/NED%20Terms%20in%20XML.xlsx)
#dfw <-read_excel("/home/rstudio/NEDMineR/data/NED Terms in XML.xlsx","NED Enumeration Values")
library(readxl)
library(stringr)
library(dplyr)
library(tidyverse)
library(EndoMineR)
# names(dfw)<-c("groups","values")
# dfw<-data.frame(dfw[1:2])
# data_out <- dfw %>%
#   group_by(groups) %>%
#   nest(values)

#These terms are then separated manually into terms that are procedure specific 
#and those that are non-specific into the text file called "/home/rstudio/NEDMineR/data/ProcedureSpecificValues"


ListContstructor<-function(string1,string2,textfile){
  #Add all the extra hyphens in that make the text file more readable
  conStart<-paste0(paste0(replicate(65,"-"),collapse = '')
                   ,string1)
  conEnd<-paste0(paste0(replicate(65,"-"),collapse = '')
                 ,string2)
  #Find the delimiters by which is in the index
  start <- which(textfile==conStart)+1
  end <- which(textfile==conEnd)-1
  return(textfile[start:end])
}

#Import the list of phrases for sentence construction
ProcedureSpecifiValues <- readLines("~/NEDMineR/data/ProcedureSpecifiValues")
ProcedureSpecifiValues<-gsub("\"","",ProcedureSpecifiValues)
names(ProcedureSpecifiValues) <- rep("x", length(ProcedureSpecifiValues))
ProcedureSpecifiValues <- as.list(ProcedureSpecifiValues)

##### LISTS- Sentence introduction #####
# Distribute the reports so that there are empties and Normals


#Create an empty dataframe
ProcFrame <- as.data.frame(matrix(0, ncol = 1, nrow = 1000))

#Get the raw terms from the text file
ProcedureNameEnum<-as.list(c("OGD","FLEXI","ERCP","COLON"))
ProcFrame$Procedure<-apply(ProcFrame, 1, function(x) paste("Procedure: ",sample(ProcedureNameEnum,1)))
#Heirarchy of report synthesis.
#if not: Extent type ="Abandoned".
#if biopsies taken and site.
#Extent and biopsies should measure up OK.

#Number of records to generate
NumRec<-1000



########################### GeneralEnums - these are from the downloaded xlsx but eventually want to include these terms in the ProcedureSpecifValues file###########################
GeneralSessionTypeEnum<-ListContstructor("GeneralSessionTypeEnum","GeneralAdmissionTypeEnum",ProcedureSpecifiValues)
GeneralAdmissionTypeEnum<-ListContstructor("GeneralAdmissionTypeEnum","GeneralUrgencyEnum",ProcedureSpecifiValues)
GeneralUrgencyEnum<-ListContstructor("GeneralUrgencyEnum","GeneralProcedureRoleTypeEnum",ProcedureSpecifiValues)
GeneralProcedureRoleTypeEnum<-ListContstructor("GeneralProcedureRoleTypeEnum","GeneralEndoscopistRoleTypeEnum",ProcedureSpecifiValues)
GeneralEndoscopistRoleTypeEnum<-ListContstructor("GeneralEndoscopistRoleTypeEnum","GeneralDiscomfortEnum",ProcedureSpecifiValues)
GeneralDiscomfortEnum<-ListContstructor("GeneralDiscomfortEnum","GeneralAdverseEventEnum",ProcedureSpecifiValues)
GeneralAdverseEventEnum<-ListContstructor("GeneralAdverseEventEnum","GeneralGenderType",ProcedureSpecifiValues)
GeneralGenderType<-ListContstructor("GeneralGenderType","GeneralYesNoEnum",ProcedureSpecifiValues)
GeneralYesNoEnum<-ListContstructor("GeneralYesNoEnum","GeneralTimeEnum",ProcedureSpecifiValues)
GeneralTimeEnum<-ListContstructor("GeneralTimeEnum","GeneralDrugType",ProcedureSpecifiValues)
GeneralDrugType<-ListContstructor("GeneralDrugType","GeneralPolypSizeEnum",ProcedureSpecifiValues) 
GeneralPolypSizeEnum<-ListContstructor("GeneralPolypSizeEnum","OGDTattooEnum",ProcedureSpecifiValues)


#The next step is to use the buioding blocks of the enums to crate a compiled phrasea which then create the whole report
########################### Creating the General enums of enum ####################################################################################################################################### 


PatientType<- paste(replicate(NumRec,sample(paste("Gender: ",GeneralGenderType),1)),replicate(NumRec,paste("Age: ",sample(18:99))),replicate(NumRec,sample(paste("Admission Type: ",GeneralAdmissionTypeEnum),1)),replicate(NumRec,sample(paste("Urgency: ",GeneralUrgencyEnum),1,replace=F)))
AdverseEventType<-replicate(NumRec,sample(paste("Adverse Event: ",GeneralAdverseEventEnum[[1]]),1))
UKDateType<-sample(seq(as.Date('1999/01/01'), as.Date('2000/01/01'), by="day"), 365)
hourTime<-(seq.POSIXt(as.POSIXct(Sys.Date()),
                      as.POSIXct(Sys.Date()+1),
                      by = "5 min"))

t<-as.character(hourTime)
TimeEnum<-str_extract(t," .*")

########################### OGDEnums listfrom here onwards is included in the the ProcedureSpecifValues file###########################
source("/home/rstudio/NEDMineR/OGD.R")

########################### FlexiEnums ###########################
source("/home/rstudio/NEDMineR/Flexi.R")

########################### ColonEnums ###########################
source("/home/rstudio/NEDMineR/Colon.R")

########################### ERCPEnum s###########################
source("/home/rstudio/NEDMineR/ERCP.R")


# OGDSessionType<-paste(replicate(NumRec,sample(OGDProcedureType,1)),replicate(NumRec,paste("Date: ",sample(UKDateType, 12))),replicate(NumRec,paste("Time: ",sample(TimeEnum,1))),replicate(NumRec,paste("Session Type: ",sample(GeneralSessionTypeEnum,1))))
# FlexiSessionType<-paste(replicate(NumRec,sample(FlexiProcedureType,1)),replicate(NumRec,paste("Date: ",sample(UKDateType, 12))),replicate(NumRec,paste("Time: ",sample(TimeEnum,1))),replicate(NumRec,paste("Session Type: ",sample(GeneralSessionTypeEnum,1))))
# ColonSessionType<-paste(replicate(NumRec,sample(ColonProcedureType,1)),replicate(NumRec,paste("Date: ",sample(UKDateType, 12))),replicate(NumRec,paste("Time: ",sample(TimeEnum,1))),replicate(NumRec,paste("Session Type: ",sample(GeneralSessionTypeEnum,1))))
# ERCPSessionType<-paste(replicate(NumRec,sample(ERCPProcedureType,1)),replicate(NumRec,paste("Date: ",sample(UKDateType, 12))),replicate(NumRec,paste("Time: ",sample(TimeEnum,1))),replicate(NumRec,paste("Session Type: ",sample(GeneralSessionTypeEnum,1))))
# 

# # TO BE REINSTATED
# ProcFrame$Procedure<-apply(ProcFrame, 1, function(x) {ifelse(grepl("OGD",x["Procedure"]),sample(OGDSessionType,1),
#                                    ifelse(grepl("COLON",x["Procedure"]),sample(ColonSessionType,1),
#                                           ifelse(grepl("FLEXI",x["Procedure"]),sample(FlexiSessionType,1),
#                                                  ifelse(grepl("ERCP",x["Procedure"]),sample(ERCPSessionType,1),""))))
# })


bounddf<-rbind(ColonProcedureDf,OGDProcedureDf)
bounddf<-rbind(bounddf,FlexiProcedureDf)
bounddf<-rbind(bounddf,ERCPProcedureDf)
#Then fill the rest of the columns with the relevant findings- it is easier to created the columns from the separated out whole report rather than as we go
#This means that the separated out columns are relevant to the whole report

#Then use the HES_ID.
#Then see if can merge with some of the HES dataset
#Then use EndoMineR to see if can develop some functions for complications 
       
#      
# #to Do:
# #How to split the Endoscopy into separate columns ?Using EndoMineR
# mywords<-c("Gender","Age","Admission Type","Urgency","Pethidine","Midazolam","Fentanyl","Buscopan","Propofol",
#            "entonox","generalAnaes","pharyngealAnaes","NestedProcByRole","Therapy",
#                   "Biopsy","PolypSize","Tattoo:","Endoscopist Role","Procedure Role","Extent Type",
#                  "jManoeuvre","Indications", "Limitations","Biopsy site","Number of biopsies:","Adverse Event",
#                  "Diagnosis","Biopsy site:","Procedure","Discomfort","Discomfort","Extent","antibioticGiven",
#                  "digitalRectalExamination","magneticEndoscopeImagerUsed","Date","Time","Session Type" )
# 
# 
# ProcFrame2<-Extractor(ProcFrame,"Procedure",mywords)
# ProcFrameFily<-ProcFrame[grepl("OGD",ProcFrame$Procedure),]
# ProcFrameFily<-Extractor(ProcFrameFily,"Procedure",mywords)


#Give weightings when sampling.
#Algorithm the Enums- determine the field dependencies as conditionals NestedProcByRole BiopsyType Extent

#Within NestedProcByRole need to make sure it is consistent is polyp vs no polyp and with the Extent
#Biopsy type needs to be consistent with number taken and also with the Extent
#Procedure abandoned or limited-----

# If bounddf=="Abandoned" then NA for the rest of the fields

bounddf$NestedProcByRole<-ifelse(grepl("Abandoned", bounddf$Extent),NA,bounddf$NestedProcByRole)
bounddf$LimitationType<-ifelse(grepl("Abandoned", bounddf$Extent),NA,bounddf$LimitationType)
bounddf$BiopsyType<-ifelse(grepl("Abandoned", bounddf$Extent),NA,bounddf$BiopsyType)
bounddf$AdverseEventType<-ifelse(grepl("Abandoned", bounddf$Extent),NA,bounddf$AdverseEventType)
bounddf$DiagnoseType<-ifelse(grepl("Abandoned", bounddf$Extent),NA,bounddf$DiagnoseType)
bounddf$NestedProcByRole<-ifelse(grepl("Abandoned", bounddf$Extent),NA,bounddf$magneticEndoscopeImagerUsed)





#Need to give extents numbers so that biopsy site can be <numberin extent- need to write this as a function maybe
#If polypSize is something then Therapy is polyp related thing


#Then see if can incorporate HES_ID's and take it from there.
#Allow incorporation of two or more things into some of the sections- how are polyps and respective sizes handled.


