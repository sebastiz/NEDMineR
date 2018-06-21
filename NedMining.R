
#Source file (downloaded from https://www.jets.nhs.uk/NED/CMS_Documents/NED%20Terms%20in%20XML.xlsx)
dfw <-read_excel("/home/rstudio/NEDMineR/data/NED Terms in XML.xlsx","NED Enumeration Values")
library(readxl)
library(stringr)
library(dplyr)
library(tidyverse)
names(dfw)<-c("groups","values")
dfw<-data.frame(dfw[1:2])
data_out <- dfw %>%
  group_by(groups) %>%
  nest(values)

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
FD_SentenceIntro<-ListContstructor("FD_SentenceIntro","FD_SentenceIntro1",ProcedureSpecifiValues)


#Heirarchy of report synthesis
#Extent type ="Abandoned"

#Get the raw terms from the text file
ProcedureNameEnum<-as.list(data_out[[16,2]])

########################### GeneralEnums ###########################
GeneralSessionTypeEnum<-as.list(data_out[[2,2]])
FD_SentenceIntro<-ListContstructor("FD_SentenceIntro","FD_SentenceIntro1",ProcedureSpecifiValues)
GeneralAdmissionTypeEnum<-as.list(data_out[[5,2]])
FD_SentenceIntro<-ListContstructor("FD_SentenceIntro","FD_SentenceIntro1",ProcedureSpecifiValues)
GeneralUrgencyEnum<-as.list(data_out[[6,2]])
FD_SentenceIntro<-ListContstructor("FD_SentenceIntro","FD_SentenceIntro1",ProcedureSpecifiValues)
GeneralProcedureRoleTypeEnum<-as.list(data_out[[7,2]])
FD_SentenceIntro<-ListContstructor("FD_SentenceIntro","FD_SentenceIntro1",ProcedureSpecifiValues)
GeneralEndoscopistRoleTypeEnum<-as.list(data_out[[8,2]])
FD_SentenceIntro<-ListContstructor("FD_SentenceIntro","FD_SentenceIntro1",ProcedureSpecifiValues)
GeneralDiscomfortEnum<-as.list(data_out[[9,2]])
FD_SentenceIntro<-ListContstructor("FD_SentenceIntro","FD_SentenceIntro1",ProcedureSpecifiValues)
GeneralAdverseEventEnum<-as.list(data_out[[14,2]])
FD_SentenceIntro<-ListContstructor("FD_SentenceIntro","FD_SentenceIntro1",ProcedureSpecifiValues)
GeneralGenderType<-as.list(data_out[[17,2]])#
FD_SentenceIntro<-ListContstructor("FD_SentenceIntro","FD_SentenceIntro1",ProcedureSpecifiValues)
GeneralYesNoEnum<-as.list(data_out[[18,2]])
FD_SentenceIntro<-ListContstructor("FD_SentenceIntro","FD_SentenceIntro1",ProcedureSpecifiValues)
GeneralTimeEnum<-as.list(data_out[[21,2]])
FD_SentenceIntro<-ListContstructor("FD_SentenceIntro","FD_SentenceIntro1",ProcedureSpecifiValues)
GeneralDrugType<-as.list(data_out[[22,2]])
FD_SentenceIntro<-ListContstructor("FD_SentenceIntro","FD_SentenceIntro1",ProcedureSpecifiValues)
GeneralPolypSizeEnum<-as.list(data_out[[19,2]])
FD_SentenceIntro<-ListContstructor("FD_SentenceIntro","FD_SentenceIntro1",ProcedureSpecifiValues)

########################### OGDEnums ###########################
OGDExtentTypeEnum<-as.list(data_out[[3,2]])
OGDExtentTypeEnum<-ListContstructor("OGDExtentTypeEnum","OGDLimitationsEnum",ProcedureSpecifiValues)
OGDLimitationsEnum<-as.list(data_out[[4,2]])
OGDLimitationsEnum<-ListContstructor("OGDLimitationsEnum","OGDIndicationsEnum",ProcedureSpecifiValues)
OGDIndicationsEnum<-as.list(data_out[[10,2]])
OGDIndicationsEnum<-ListContstructor("OGDIndicationsEnum","OGDDiagnosisLookupEnum",ProcedureSpecifiValues)
OGDDiagnosisLookupEnum<-as.list(data_out[[11,2]])
OGDDiagnosisLookupEnum<-ListContstructor("OGDDiagnosisLookupEnum","OGDTherapeuticLookupEnum",ProcedureSpecifiValues)
OGDTherapeuticLookupEnum<-as.list(data_out[[12,2]])
OGDTherapeuticLookupEnum<-ListContstructor("OGDTherapeuticLookupEnum","OGDBiopsyEnum",ProcedureSpecifiValues)
OGDBiopsyEnum<-as.list(data_out[[13,2]])
OGDBiopsyEnum<-ListContstructor("OGDBiopsyEnum","ColonExtentTypeEnum",ProcedureSpecifiValues)

########################### FlexiEnums ###########################
FlexiExtentTypeEnum<-as.list(data_out[[3,2]])
FlexiExtentTypeEnum<-ListContstructor("FlexiExtentTypeEnum","FlexiLimitationsEnum",ProcedureSpecifiValues)
FlexiLimitationsEnum<-as.list(data_out[[4,2]])
FlexiLimitationsEnum<-ListContstructor("FlexiLimitationsEnum","FlexiIndicationsEnum",ProcedureSpecifiValues)
FlexiIndicationsEnum<-as.list(data_out[[10,2]])
FlexiIndicationsEnum<-ListContstructor("FlexiIndicationsEnum","FlexiDiagnosisLookupEnum",ProcedureSpecifiValues)
FlexiDiagnosisLookupEnum<-as.list(data_out[[11,2]])
FlexiDiagnosisLookupEnum<-ListContstructor("FlexiDiagnosisLookupEnum","FlexiTherapeuticLookupEnum",ProcedureSpecifiValues)
FlexiTherapeuticLookupEnum<-as.list(data_out[[12,2]])
FlexiTherapeuticLookupEnum<-ListContstructor("FlexiTherapeuticLookupEnum","FlexiBiopsyEnum",ProcedureSpecifiValues)
FlexiBiopsyEnum<-as.list(data_out[[13,2]])
FlexiBiopsyEnum<-ListContstructor("FlexiBiopsyEnum","FlexiBowelPrepEnum",ProcedureSpecifiValues)
FlexiBowelPrepEnum<-as.list(data_out[[15,2]])
FlexiBowelPrepEnum<-ListContstructor("FlexiBowelPrepEnum","FlexiTattooEnum",ProcedureSpecifiValues)
FlexiTattooEnum<-as.list(data_out[[20,2]])
FlexiTattooEnum<-ListContstructor("FlexiTattooEnum","ERCPExtentTypeEnum",ProcedureSpecifiValues)

########################### ColonEnums ###########################
ColonExtentTypeEnum<-as.list(data_out[[3,2]])
ColonExtentTypeEnum<-ListContstructor("ColonExtentTypeEnum","ColonLimitationsEnum",ProcedureSpecifiValues)
ColonLimitationsEnum<-as.list(data_out[[4,2]])
ColonLimitationsEnum<-ListContstructor("ColonLimitationsEnum","ColonIndicationsEnum",ProcedureSpecifiValues)
ColonIndicationsEnum<-as.list(data_out[[10,2]])
ColonIndicationsEnum<-ListContstructor("ColonIndicationsEnum","ColonDiagnosisLookupEnum",ProcedureSpecifiValues)
ColonDiagnosisLookupEnum<-as.list(data_out[[11,2]])
ColonDiagnosisLookupEnum<-ListContstructor("ColonDiagnosisLookupEnum","ColonTherapeuticLookupEnum",ProcedureSpecifiValues)
ColonTherapeuticLookupEnum<-as.list(data_out[[12,2]])
ColonTherapeuticLookupEnum<-ListContstructor("ColonTherapeuticLookupEnum","ColonBiopsyEnum",ProcedureSpecifiValues)
ColonBiopsyEnum<-as.list(data_out[[13,2]])
ColonBiopsyEnum<-ListContstructor("ColonBiopsyEnum","ColonBowelPrepEnum",ProcedureSpecifiValues)
ColonBowelPrepEnum<-as.list(data_out[[15,2]])
ColonBowelPrepEnum<-ListContstructor("ColonBowelPrepEnum","ColonTattooEnum",ProcedureSpecifiValues)
ColonTattooEnum<-as.list(data_out[[20,2]])
ColonTattooEnum<-ListContstructor("ColonTattooEnum","FlexiExtentTypeEnum",ProcedureSpecifiValues)

########################### ERCPEnum s###########################
ERCPExtentTypeEnum<-as.list(data_out[[3,2]])
ERCPExtentTypeEnum<-ListContstructor("ERCPExtentTypeEnum","ERCPLimitationsEnum",ProcedureSpecifiValues)
ERCPLimitationsEnum<-as.list(data_out[[4,2]])
ERCPLimitationsEnum<-ListContstructor("ERCPLimitationsEnum","ERCPIndicationsEnum",ProcedureSpecifiValues)
ERCPIndicationsEnum<-as.list(data_out[[10,2]])
ERCPIndicationsEnum<-ListContstructor("ERCPIndicationsEnum","ERCPDiagnosisLookupEnum",ProcedureSpecifiValues)
ERCPDiagnosisLookupEnum<-as.list(data_out[[11,2]])
ERCPDiagnosisLookupEnum<-ListContstructor("ERCPDiagnosisLookupEnum","ERCPTherapeuticLookupEnum",ProcedureSpecifiValues)
ERCPTherapeuticLookupEnum<-as.list(data_out[[12,2]])
ERCPTherapeuticLookupEnum<-ListContstructor("ERCPTherapeuticLookupEnum","END",ProcedureSpecifiValues)







########################### Create the dataframe with the procedure per row which will dictate which enums are jigsawed together #####################################################################  




########################### Creating the General enums of enum ####################################################################################################################################### 


PatientType<- paste(replicate(10,sample(paste("Gender: ",GenderType[[1]]),1)),replicate(10,sample(paste("Age: ",18:99))),replicate(10,sample(paste("Admission Type: ",AdmissionTypeEnum[[1]]),1)),replicate(10,sample(paste("Urgency: ",UrgencyEnum[[1]]),1,replace=F)))
AdverseEventType<-replicate(10,sample(paste("Adverse Event: ",AdverseEventEnum[[1]]),1))
UKDateType<-sample(seq(as.Date('1999/01/01'), as.Date('2000/01/01'), by="day"), 365)
hourTime<-(seq.POSIXt(as.POSIXct(Sys.Date()),
                      as.POSIXct(Sys.Date()+1),
                      by = "5 min"))

t<-as.character(hourTime)
TimeEnum<-str_extract(t," .*")

########################### Creating the OGD enums of enum ####################################################################################################################################### 
OGDTherapeuticType<-paste(replicate(10,sample(paste("Therapeutic: ",OGDTherapeuticLookupEnum[[1]]),1)),
                       replicate(10,sample(paste("Biopsy: ",OGDBiopsyEnum[[1]]),1)),
                       replicate(10,sample(paste("Procedure Role: ",GeneralProcedureRoleTypeEnum[[1]]),1)),
                       replicate(10,sample(paste("PolypSize: ",GeneralPolypSizeEnum[[1]]),1)))

OGDBiopsyType<-paste(replicate(10,paste("Biopsy site:",sample(OGDBiopsyEnum[[1]])),1),"Number of biopsies: ",sample(1:8))

OGDDiagnoseType<-paste(replicate(10,paste("Diagnosis:",sample(OGDDiagnosisLookupEnum[[1]],1))),
                       replicate(10,paste("Biopsy site:",sample(OGDBiopsyEnum[[1]]),1)))

OGDIndicationType<-replicate(10,paste("Indications:",sample(OGDIndicationsEnum[[1]],1)))
OGDLimitationType<-replicate(10,paste("Limitations:",sample(OGDLimitationsEnum[[1]],1)))

OGDStaffType<-paste(replicate(10,paste("Limitations:",sample(OGDTherapeuticLookupEnum[[1]],1))),
                       replicate(10,paste("Endoscopist Role:",sample(GeneralEndoscopistRoleTypeEnum[[1]],1))),
                       replicate(10,paste("Procedure Role:",sample(GeneralProcedureRoleTypeEnum[[1]],1))),
                       replicate(10,paste("Extent Type:",sample(OGDExtentTypeEnum[[1]],1))),
                       replicate(10,paste("Limitations:",sample(OGDLimitationsTypeEnum[[1]],1))),
                 "jManoeuvre:",paste("jManoeuvre:",sample(YesNoEnum,1)))



########################### Creating the Flexi enums of enum ####################################################################################################################################### 
OGDTherapeuticType<-paste(replicate(10,sample(paste("Therapeutic: ",OGDTherapeuticLookupEnum[[1]]),1)),
                       replicate(10,sample(paste("Biopsy: ",OGDBiopsyEnum[[1]]),1)),
                       replicate(10,sample(paste("Procedure Role: ",GeneralProcedureRoleTypeEnum[[1]]),1)),
                       replicate(10,sample(paste("PolypSize: ",GeneralPolypSizeEnum[[1]]),1)))

OGDBiopsyType<-paste(replicate(10,paste("Biopsy site:",sample(OGDBiopsyEnum[[1]])),1),"Number of biopsies: ",sample(1:8))

OGDDiagnoseType<-paste(replicate(10,paste("Diagnosis:",sample(OGDDiagnosisLookupEnum[[1]],1))),
                       replicate(10,paste("Biopsy site:",sample(OGDBiopsyEnum[[1]]),1)))

OGDIndicationType<-replicate(10,paste("Indications:",sample(OGDIndicationsEnum[[1]],1)))
OGDLimitationType<-replicate(10,paste("Limitations:",sample(OGDLimitationsEnum[[1]],1)))

OGDStaffType<-paste(replicate(10,paste("Limitations:",sample(OGDTherapeuticLookupEnum[[1]],1))),
                      replicate(10,paste("Endoscopist Role:",sample(GeneralEndoscopistRoleTypeEnum[[1]],1))),
                      replicate(10,paste("Procedure Role:",sample(GeneralProcedureRoleTypeEnum[[1]],1))),
                      replicate(10,paste("Extent Type:",sample(OGDExtentTypeEnum[[1]],1))),
                      replicate(10,paste("Limitations:",sample(OGDLimitationsTypeEnum[[1]],1))),
                      "jManoeuvre:",paste("jManoeuvre:",sample(YesNoEnum,1)))

########################### Creating the Colon enums of enum ####################################################################################################################################### 
OGDTherapeuticType<-paste(replicate(10,sample(paste("Therapeutic: ",OGDTherapeuticLookupEnum[[1]]),1)),
                      replicate(10,sample(paste("Biopsy: ",OGDBiopsyEnum[[1]]),1)),
                      replicate(10,sample(paste("Procedure Role: ",GeneralProcedureRoleTypeEnum[[1]]),1)),
                      replicate(10,sample(paste("PolypSize: ",GeneralPolypSizeEnum[[1]]),1)))

OGDBiopsyType<-paste(replicate(10,paste("Biopsy site:",sample(OGDBiopsyEnum[[1]])),1),"Number of biopsies: ",sample(1:8))

OGDDiagnoseType<-paste(replicate(10,paste("Diagnosis:",sample(OGDDiagnosisLookupEnum[[1]],1))),
                      replicate(10,paste("Biopsy site:",sample(OGDBiopsyEnum[[1]]),1)))

OGDIndicationType<-replicate(10,paste("Indications:",sample(OGDIndicationsEnum[[1]],1)))
OGDLimitationType<-replicate(10,paste("Limitations:",sample(OGDLimitationsEnum[[1]],1)))

OGDStaffType<-paste(replicate(10,paste("Limitations:",sample(OGDTherapeuticLookupEnum[[1]],1))),
                      replicate(10,paste("Endoscopist Role:",sample(GeneralEndoscopistRoleTypeEnum[[1]],1))),
                      replicate(10,paste("Procedure Role:",sample(GeneralProcedureRoleTypeEnum[[1]],1))),
                      replicate(10,paste("Extent Type:",sample(OGDExtentTypeEnum[[1]],1))),
                      replicate(10,paste("Limitations:",sample(OGDLimitationType[[1]],1))),
                      "jManoeuvre:",paste("jManoeuvre:",sample(YesNoEnum,1)))

########################### Creating the ERCP enums of enum ####################################################################################################################################### 
ERCPTherapeuticType<-paste(replicate(10,sample(paste("Therapeutic: ",ERCPTherapeuticLookupEnum[[1]]),1)),
                      replicate(10,sample(paste("Procedure Role: ",GeneralProcedureRoleTypeEnum[[1]]),1)),
                      replicate(10,sample(paste("PolypSize: ",GeneralPolypSizeEnum[[1]]),1)),
                      replicate(10,sample(paste("Tattoo: ",TattooEnum[[1]]),1)))

DiagnoseType<-paste(replicate(10,paste("Diagnosis:",sample(DiagnosisLookupEnum[[1]],1))),
                      replicate(10,paste("Tattoo:",sample(TattooEnum[[1]],1))),
                      replicate(10,paste("Biopsy site:",sample(BiopsyEnum[[1]]),1)))

IndicationType<-replicate(10,paste("Indications:",sample(IndicationsEnum[[1]],1)))
LimitationType<-replicate(10,paste("Limitations:",sample(LimitationsEnum[[1]],1)))

StaffType<-paste(replicate(10,paste("Limitations:",sample(TherapeuticLookupEnum[[1]],1))),
                      replicate(10,paste("Endoscopist Role:",sample(EndoscopistRoleTypeEnum[[1]],1))),
                      replicate(10,paste("Procedure Role:",sample(ProcedureRoleTypeEnum[[1]],1))),
                      replicate(10,paste("Extent Type:",sample(ExtentTypeEnum[[1]],1))),
                      replicate(10,paste("Limitations:",sample(ExtentTypeEnum[[1]],1))),
                      "jManoeuvre:",paste("jManoeuvre:",sample(YesNoEnum,1)))








ProcedureType<- paste(replicate(10,sample(PatientType,1)),
replicate(10,sample(DrugType[[1]]),1),
replicate(10,sample(StaffType,1)),
replicate(10,sample(IndicationType,1)),
replicate(10,sample(LimitationType,1)),
replicate(10,sample(BiopsyType,1)),
replicate(10,sample(AdverseEventType,1)),
replicate(10,sample(DiagnoseType,1)),
replicate(10,paste("Procedure:",sample(ProcedureNameEnum[[1]],1))),
replicate(10,paste("Discomfort:",sample(DiscomfortEnum[[1]],1))),
replicate(10,paste("Discomfort:",sample(DiscomfortEnum[[1]],1))),
replicate(10,paste("Bowel Prep:",sample(BowelPrepEnum[[1]],1))),
replicate(10,paste("Extent:",sample(ExtentTypeEnum[[1]],1))),
paste("entonox:",replicate(10,sample(YesNoEnum,1))),
paste("antibioticGiven:",replicate(10,sample(YesNoEnum,1))),
      paste("generalAnaes:",replicate(10,sample(YesNoEnum,1))),
            paste("pharyngealAnaes:",replicate(10,sample(YesNoEnum,1))),
                  paste("digitalRectalExamination",replicate(10,sample(YesNoEnum,1))),
                        paste("magneticEndoscopeImagerUsed:",replicate(10,sample(YesNoEnum,1))))




SessionType<-paste(replicate(10,sample(ProcedureType,1)),replicate(10,sample(UKDateType, 12)),replicate(10,sample(hourTimeExtracted[[1]],1)),replicate(10,sample(SessionTypeEnum[[1]],1)))


#to Do:
#Export terms from the text file to the raw Enums
#Then convert all the names from the enums of enums and make sure it makes sense
#Then finish the ProcedureType enums and then run the whole thing
#Then see if can incorporate HES_ID's and take it from there
