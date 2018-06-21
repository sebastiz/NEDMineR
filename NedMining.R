#Source file (downloaded from https://www.jets.nhs.uk/NED/CMS_Documents/NED%20Terms%20in%20XML.xlsx)
dfw <-read_excel("/home/rstudio/NEDMineR/data/NED Terms in XML.xlsx","NED Enumeration Values")
library(readxl)
library(stringr)
library(dplyr)
library(tidyverse)
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

#For each row where Procedure=='OGD' add a sample to extentTypeEnum to the Extent Column



########################### GeneralEnums - these are from teh downloaded xlsx but eventually want to include these terms in the ProcedureSpecifValues file###########################
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
GeneralPolypSizeEnum<-ListContstructor("GeneralPolypSizeEnum","OGDExtentTypeEnum",ProcedureSpecifiValues)

########################### OGDEnums from here onwards is included in the the ProcedureSpecifValues file###########################
OGDExtentTypeEnum<-ListContstructor("OGDExtentTypeEnum","OGDLimitationsEnum",ProcedureSpecifiValues)
OGDLimitationsEnum<-ListContstructor("OGDLimitationsEnum","OGDIndicationsEnum",ProcedureSpecifiValues)
OGDIndicationsEnum<-ListContstructor("OGDIndicationsEnum","OGDDiagnosisLookupEnum",ProcedureSpecifiValues)
OGDDiagnosisLookupEnum<-ListContstructor("OGDDiagnosisLookupEnum","OGDTherapeuticLookupEnum",ProcedureSpecifiValues)
OGDTherapeuticLookupEnum<-ListContstructor("OGDTherapeuticLookupEnum","OGDBiopsyEnum",ProcedureSpecifiValues)
OGDBiopsyEnum<-ListContstructor("OGDBiopsyEnum","ColonExtentTypeEnum",ProcedureSpecifiValues)

########################### FlexiEnums ###########################
FlexiExtentTypeEnum<-ListContstructor("FlexiExtentTypeEnum","FlexiLimitationsEnum",ProcedureSpecifiValues)
FlexiLimitationsEnum<-ListContstructor("FlexiLimitationsEnum","FlexiIndicationsEnum",ProcedureSpecifiValues)
FlexiIndicationsEnum<-ListContstructor("FlexiIndicationsEnum","FlexiDiagnosisLookupEnum",ProcedureSpecifiValues)
FlexiDiagnosisLookupEnum<-ListContstructor("FlexiDiagnosisLookupEnum","FlexiTherapeuticLookupEnum",ProcedureSpecifiValues)
FlexiTherapeuticLookupEnum<-ListContstructor("FlexiTherapeuticLookupEnum","FlexiBiopsyEnum",ProcedureSpecifiValues)
FlexiBiopsyEnum<-ListContstructor("FlexiBiopsyEnum","FlexiBowelPrepEnum",ProcedureSpecifiValues)
FlexiBowelPrepEnum<-ListContstructor("FlexiBowelPrepEnum","FlexiTattooEnum",ProcedureSpecifiValues)
FlexiTattooEnum<-ListContstructor("FlexiTattooEnum","ERCPExtentTypeEnum",ProcedureSpecifiValues)

########################### ColonEnums ###########################

ColonExtentTypeEnum<-ListContstructor("ColonExtentTypeEnum","ColonLimitationsEnum",ProcedureSpecifiValues)
ColonLimitationsEnum<-ListContstructor("ColonLimitationsEnum","ColonIndicationsEnum",ProcedureSpecifiValues)
ColonIndicationsEnum<-ListContstructor("ColonIndicationsEnum","ColonDiagnosisLookupEnum",ProcedureSpecifiValues)
ColonDiagnosisLookupEnum<-ListContstructor("ColonDiagnosisLookupEnum","ColonTherapeuticLookupEnum",ProcedureSpecifiValues)
ColonTherapeuticLookupEnum<-ListContstructor("ColonTherapeuticLookupEnum","ColonBiopsyEnum",ProcedureSpecifiValues)
ColonBiopsyEnum<-ListContstructor("ColonBiopsyEnum","ColonBowelPrepEnum",ProcedureSpecifiValues)
ColonBowelPrepEnum<-ListContstructor("ColonBowelPrepEnum","ColonTattooEnum",ProcedureSpecifiValues)
ColonTattooEnum<-ListContstructor("ColonTattooEnum","FlexiExtentTypeEnum",ProcedureSpecifiValues)

########################### ERCPEnum s###########################
ERCPExtentTypeEnum<-ListContstructor("ERCPExtentTypeEnum","ERCPLimitationsEnum",ProcedureSpecifiValues)
ERCPLimitationsEnum<-ListContstructor("ERCPLimitationsEnum","ERCPIndicationsEnum",ProcedureSpecifiValues)
ERCPIndicationsEnum<-ListContstructor("ERCPIndicationsEnum","ERCPDiagnosisLookupEnum",ProcedureSpecifiValues)
ERCPDiagnosisLookupEnum<-ListContstructor("ERCPDiagnosisLookupEnum","ERCPTherapeuticLookupEnum",ProcedureSpecifiValues)
ERCPTherapeuticLookupEnum<-ListContstructor("ERCPTherapeuticLookupEnum","END",ProcedureSpecifiValues)







########################### Create the dataframe with the procedure per row which will dictate which enums are jigsawed together #####################################################################  




########################### Creating the General enums of enum ####################################################################################################################################### 


PatientType<- paste(replicate(10,sample(paste("Gender: ",GenderType[[1]]),1)),replicate(10,paste("Age: ",sample(18:99))),replicate(10,sample(paste("Admission Type: ",AdmissionTypeEnum[[1]]),1)),replicate(10,sample(paste("Urgency: ",UrgencyEnum[[1]]),1,replace=F)))
AdverseEventType<-replicate(10,sample(paste("Adverse Event: ",AdverseEventEnum[[1]]),1))
UKDateType<-sample(seq(as.Date('1999/01/01'), as.Date('2000/01/01'), by="day"), 365)
hourTime<-(seq.POSIXt(as.POSIXct(Sys.Date()),
                      as.POSIXct(Sys.Date()+1),
                      by = "5 min"))

t<-as.character(hourTime)
TimeEnum<-str_extract(t," .*")

########################### Creating the OGD enums of enum ####################################################################################################################################### 
OGDTherapeuticType<-paste(replicate(10,sample(paste("Therapeutic: ",OGDTherapeuticLookupEnum),1)),
                       replicate(10,sample(paste("Biopsy: ",OGDBiopsyEnum),1)),
                       replicate(10,sample(paste("Procedure Role: ",GeneralProcedureRoleTypeEnum[[1]]),1)),
                       replicate(10,sample(paste("PolypSize: ",GeneralPolypSizeEnum[[1]]),1)))

OGDBiopsyType<-paste(replicate(10,paste("Biopsy site:",sample(OGDBiopsyEnum)),1),"Number of biopsies: ",sample(1:8))

OGDDiagnoseType<-paste(replicate(10,paste("Diagnosis:",sample(OGDDiagnosisLookupEnum,2))),
                       replicate(10,paste("Biopsy site:",sample(OGDBiopsyEnum,1))))

OGDIndicationType<-replicate(10,paste("Indications:",sample(OGDIndicationsEnum,1)))
OGDLimitationType<-replicate(10,paste("Limitations:",sample(OGDLimitationsEnum,1)))

OGDStaffType<-paste(replicate(10,paste("Therapy:",sample(OGDTherapeuticLookupEnum,1))),
                       replicate(10,paste("Endoscopist Role:",sample(GeneralEndoscopistRoleTypeEnum[[1]],1))),
                       replicate(10,paste("Procedure Role:",sample(GeneralProcedureRoleTypeEnum[[1]],1))),
                       replicate(10,paste("Extent Type:",sample(OGDExtentTypeEnum,1))),
                       replicate(10,sample(OGDLimitationType,1)),
                       replicate(10,paste("jManoeuvre:",sample(YesNoEnum,1))))


OGDProcedureType<- paste(replicate(10,sample(PatientType,1)),
                      replicate(10,sample(paste("Meds:",DrugType[[1]])),1),
                      replicate(10,sample(OGDStaffType,1)),
                      replicate(10,sample(OGDIndicationType,1)),
                      replicate(10,sample(OGDLimitationType,1)),
                      replicate(10,sample(OGDBiopsyType,1)),
                      replicate(10,sample(AdverseEventType,1)),
                      replicate(10,sample(OGDDiagnoseType,1)),
                      replicate(10,paste("Procedure:OGD")),
                      replicate(10,paste("Discomfort:",sample(DiscomfortEnum[[1]],1))),
                      replicate(10,paste("Discomfort:",sample(DiscomfortEnum[[1]],1))),
                      replicate(10,paste("Extent:",sample(OGDExtentTypeEnum,1))),
                      paste("entonox:",replicate(10,sample(YesNoEnum,1))),
                      paste("antibioticGiven:",replicate(10,sample(YesNoEnum,1))),
                      paste("generalAnaes:",replicate(10,sample(YesNoEnum,1))),
                      paste("pharyngealAnaes:",replicate(10,sample(YesNoEnum,1))),
                      paste("magneticEndoscopeImagerUsed:",replicate(10,sample(YesNoEnum,1))))



########################### Creating the Flexi enums of enum ####################################################################################################################################### 
FlexiTherapeuticType<-paste(replicate(10,sample(paste("Therapeutic: ",FlexiTherapeuticLookupEnum),1)),
                            replicate(10,sample(paste("Biopsy: ",FlexiBiopsyEnum),1)),
                            replicate(10,sample(paste("Procedure Role: ",GeneralProcedureRoleTypeEnum[[1]]),1)),
                            replicate(10,sample(paste("PolypSize: ",GeneralPolypSizeEnum[[1]]),1)))

FlexiBiopsyType<-paste(replicate(10,paste("Biopsy site:",sample(FlexiBiopsyEnum[[1]])),1),"Number of biopsies: ",sample(1:8))

FlexiDiagnoseType<-paste(replicate(10,paste("Diagnosis:",sample(FlexiDiagnosisLookupEnum,1))),
                         replicate(10,paste("Biopsy site:",sample(FlexiBiopsyEnum,1))))

FlexiIndicationType<-replicate(10,paste("Indications:",sample(FlexiIndicationsEnum,1)))
FlexiLimitationType<-replicate(10,paste("Limitations:",sample(FlexiLimitationsEnum,1)))

FlexiStaffType<-paste(replicate(10,paste("Therapy:",sample(FlexiTherapeuticLookupEnum,1))),
                      replicate(10,paste("Endoscopist Role:",sample(GeneralEndoscopistRoleTypeEnum[[1]],1))),
                      replicate(10,paste("Procedure Role:",sample(GeneralProcedureRoleTypeEnum[[1]],1))),
                      replicate(10,paste("Extent Type:",sample(FlexiExtentTypeEnum,1))),
                      replicate(10,sample(FlexiLimitationType,1)),
                      replicate(10,paste("jManoeuvre:",sample(YesNoEnum,1))))


FlexiProcedureType<- paste(replicate(10,sample(PatientType,1)),
                           replicate(10,sample(paste("Meds:",DrugType[[1]])),1),
                           replicate(10,sample(FlexiStaffType,1)),
                           replicate(10,sample(FlexiIndicationType,1)),
                           replicate(10,sample(FlexiLimitationType,1)),
                           replicate(10,sample(FlexiBiopsyType,1)),
                           replicate(10,sample(AdverseEventType,1)),
                           replicate(10,sample(FlexiDiagnoseType,1)),
                           replicate(10,paste("Procedure:Flexi")),
                           replicate(10,paste("Discomfort:",sample(DiscomfortEnum[[1]],1))),
                           replicate(10,paste("Discomfort:",sample(DiscomfortEnum[[1]],1))),
                           replicate(10,paste("Extent:",sample(FlexiExtentTypeEnum,1))),
                           paste("entonox:",replicate(10,sample(YesNoEnum,1))),
                           paste("antibioticGiven:",replicate(10,sample(YesNoEnum,1))),
                           paste("generalAnaes:",replicate(10,sample(YesNoEnum,1))),
                           paste("pharyngealAnaes:",replicate(10,sample(YesNoEnum,1))),
                           paste("digitalRectalExamination",replicate(10,sample(YesNoEnum,1))),
                           paste("magneticEndoscopeImagerUsed:",replicate(10,sample(YesNoEnum,1))))


########################### Creating the Colon enums of enum ####################################################################################################################################### 
ColonTherapeuticType<-paste(replicate(10,sample(paste("Therapeutic: ",ColonTherapeuticLookupEnum),1)),
                            replicate(10,sample(paste("Biopsy: ",ColonBiopsyEnum),1)),
                            replicate(10,sample(paste("Procedure Role: ",GeneralProcedureRoleTypeEnum[[1]]),1)),
                            replicate(10,sample(paste("PolypSize: ",GeneralPolypSizeEnum[[1]]),1)))

ColonBiopsyType<-paste(replicate(10,paste("Biopsy site:",sample(ColonBiopsyEnum[[1]])),1),"Number of biopsies: ",sample(1:8))

ColonDiagnoseType<-paste(replicate(10,paste("Diagnosis:",sample(ColonDiagnosisLookupEnum,1))),
                         replicate(10,paste("Biopsy site:",sample(ColonBiopsyEnum,1))))

ColonIndicationType<-replicate(10,paste("Indications:",sample(ColonIndicationsEnum,1)))
ColonLimitationType<-replicate(10,paste("Limitations:",sample(ColonLimitationsEnum,1)))

ColonStaffType<-paste(replicate(10,paste("Therapy:",sample(ColonTherapeuticLookupEnum,1))),
                      replicate(10,paste("Endoscopist Role:",sample(GeneralEndoscopistRoleTypeEnum[[1]],1))),
                      replicate(10,paste("Procedure Role:",sample(GeneralProcedureRoleTypeEnum[[1]],1))),
                      replicate(10,paste("Extent Type:",sample(ColonExtentTypeEnum,1))),
                      replicate(10,sample(ColonLimitationType,1)),
                      replicate(10,paste("jManoeuvre:",sample(YesNoEnum,1))))


ColonProcedureType<- paste(replicate(10,sample(PatientType,1)),
                           replicate(10,sample(paste("Meds:",DrugType[[1]])),1),
                           replicate(10,sample(ColonStaffType,1)),
                           replicate(10,sample(ColonIndicationType,1)),
                           replicate(10,sample(ColonLimitationType,1)),
                           replicate(10,sample(ColonBiopsyType,1)),
                           replicate(10,sample(AdverseEventType,1)),
                           replicate(10,sample(ColonDiagnoseType,1)),
                           replicate(10,paste("Procedure:Colon")),
                           replicate(10,paste("Discomfort:",sample(DiscomfortEnum[[1]],1))),
                           replicate(10,paste("Discomfort:",sample(DiscomfortEnum[[1]],1))),
                           replicate(10,paste("Extent:",sample(ColonExtentTypeEnum,1))),
                           paste("entonox:",replicate(10,sample(YesNoEnum,1))),
                           paste("antibioticGiven:",replicate(10,sample(YesNoEnum,1))),
                           paste("generalAnaes:",replicate(10,sample(YesNoEnum,1))),
                           paste("pharyngealAnaes:",replicate(10,sample(YesNoEnum,1))),
                           paste("digitalRectalExamination",replicate(10,sample(YesNoEnum,1))),
                           paste("magneticEndoscopeImagerUsed:",replicate(10,sample(YesNoEnum,1))))
                           



########################### Creating the ERCP enums of enum ####################################################################################################################################### 
ERCPTherapeuticType<-paste(replicate(10,sample(paste("Therapeutic: ",ERCPTherapeuticLookupEnum[[1]]),1)),
                      replicate(10,sample(paste("Procedure Role: ",GeneralProcedureRoleTypeEnum[[1]]),1)),
                      replicate(10,sample(paste("PolypSize: ",GeneralPolypSizeEnum[[1]]),1)),
                      replicate(10,sample(paste("Tattoo: ",TattooEnum[[1]]),1)))

ERCPDiagnoseType<-paste(replicate(10,paste("Diagnosis:",sample(ERCPDiagnosisLookupEnum,1))))

ERCPIndicationType<-replicate(10,paste("Indications:",sample(ERCPIndicationsEnum,1)))
ERCPLimitationType<-replicate(10,paste("Limitations:",sample(ERCPLimitationsEnum,1)))

ERCPStaffType<-paste(replicate(10,paste("Limitations:",sample(ERCPTherapeuticLookupEnum,1))),
                      replicate(10,paste("Endoscopist Role:",sample(EndoscopistRoleTypeEnum[[1]],1))),
                      replicate(10,paste("Procedure Role:",sample(ProcedureRoleTypeEnum[[1]],1))),
                      replicate(10,paste("Extent Type:",sample(ERCPExtentTypeEnum[[1]],1))),
                      replicate(10,paste("Limitations:",sample(ERCPExtentTypeEnum,1))))


ERCPProcedureType<- paste(replicate(10,sample(PatientType,1)),
                          replicate(10,sample(paste("Meds:",DrugType[[1]])),1),
                          replicate(10,sample(ERCPStaffType,1)),
                          replicate(10,sample(ERCPIndicationType,1)),
                          replicate(10,sample(ERCPLimitationType,1)),
                          replicate(10,sample(AdverseEventType,1)),
                          replicate(10,sample(ERCPDiagnoseType,1)),
                          replicate(10,paste("Procedure:ERCP")),
                          replicate(10,paste("Discomfort:",sample(DiscomfortEnum[[1]],1))),
                          replicate(10,paste("Discomfort:",sample(DiscomfortEnum[[1]],1))),
                          replicate(10,paste("Extent:",sample(ERCPExtentTypeEnum,1))),
                          paste("entonox:",replicate(10,sample(YesNoEnum,1))),
                          paste("antibioticGiven:",replicate(10,sample(YesNoEnum,1))),
                          paste("generalAnaes:",replicate(10,sample(YesNoEnum,1))),
                          paste("pharyngealAnaes:",replicate(10,sample(YesNoEnum,1))),
                          paste("digitalRectalExamination",replicate(10,sample(YesNoEnum,1))),
                          paste("magneticEndoscopeImagerUsed:",replicate(10,sample(YesNoEnum,1))))




########################### Putting together as the Session type  ####################################################################################################################################### 



OGDSessionType<-paste(replicate(10,sample(OGDProcedureType,1)),replicate(10,sample(UKDateType, 12)),replicate(10,sample(TimeEnum[[1]],1)),replicate(10,sample(SessionTypeEnum[[1]],1)))
FlexiSessionType<-paste(replicate(10,sample(FlexiProcedureType,1)),replicate(10,sample(UKDateType, 12)),replicate(10,sample(TimeEnum[[1]],1)),replicate(10,sample(SessionTypeEnum[[1]],1)))
ColonSessionType<-paste(replicate(10,sample(ColonProcedureType,1)),replicate(10,sample(UKDateType, 12)),replicate(10,sample(TimeEnum[[1]],1)),replicate(10,sample(SessionTypeEnum[[1]],1)))
ERCPSessionType<-paste(replicate(10,sample(ERCPProcedureType,1)),replicate(10,sample(UKDateType, 12)),replicate(10,sample(TimeEnum[[1]],1)),replicate(10,sample(SessionTypeEnum[[1]],1)))



ProcFrame$Procedure<-apply(ProcFrame, 1, function(x) {ifelse(grepl("OGD",x["Procedure"]),sample(OGDSessionType,1),
                                   ifelse(grepl("COLON",x["Procedure"]),sample(ColonSessionType,1),
                                          ifelse(grepl("FLEXI",x["Procedure"]),sample(FlexiSessionType,1),
                                                 ifelse(grepl("ERCP",x["Procedure"]),sample(ERCPSessionType,1),""))))
})

#Then fill the rest of the columns with the relevant findings 

#Then use the HES_ID.
#Then see if can merge with some of the HES dataset
#Then use EndoMineR to see if can develop some functions for complications 
       
     
#to Do:
#Algorithm the Enums
#Then see if can incorporate HES_ID's and take it from there
